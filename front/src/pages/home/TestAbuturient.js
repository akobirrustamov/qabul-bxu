import React, { useEffect, useState } from "react";
import { useLocation, useNavigate } from "react-router-dom";
import ApiCall, { baseUrl } from "../../config";
import Header from "../header/Header";
import Confetti from "react-confetti";
import Zoom from "react-reveal/Zoom";
import Footer from "../footer/Footer";
import {CiLocationOn, CiPhone} from "react-icons/ci";
import bg5 from "./bgImage/4.jpg";
import bg11 from "./bgImage/2.jpg"
function TestAbiturient() {
    const navigate = useNavigate();
    const [showTest, setShowTest] = useState(true);
    const location = useLocation();
    const [answers, setAnswers] = useState({});
    const [correctCount, setCorrectCount] = useState(null);
    const [showConfetti, setShowConfetti] = useState(false);
    const [subjectNames, setSubjectNames] = useState([]);
    const [totalScore, setTotalScore] = useState(null);
    const [formData, setFormData] = useState(null);
    const [failed, setFailed] = useState(false)
    const [certificate1, setCertificate1] = useState(null)
    const [certificate2, setCertificate2] = useState(null)
    const [certificate3, setCertificate3] = useState(null)
    const [ijodiy, setIjodiy] =useState(false)
    const [subjects, setSubjects] = useState({
        subject1: [],
        subject2: [],
        subject3: [],
        subject4: [],
        subject5: [],
    });
    const [canSubmit, setCanSubmit] = useState(false);
    const phone = location.state?.phone || "";

    useEffect(() => {
        if (!phone) {
            navigate("/");
        }

        // Save the phone number in local storage
        const savedPhone = localStorage.getItem("phone");
        if (savedPhone !== phone) {
            // If the phone number has changed, clear old test data
            localStorage.removeItem("testData");
            localStorage.removeItem("answers");
        }

        // Save the new phone number in local storage
        localStorage.setItem("phone", phone);

        // Fetch data for the new phone number
        getPhoneData();
    }, []);

    useEffect(() => {

    }, [correctCount]);

    useEffect(() => {
        checkIfAllQuestionsAnswered();
    }, [answers]);

    const getPhoneData = async () => {
        try {
            const response = await ApiCall(`/api/v1/abuturient/${phone}`, "GET", null, null, true);
            if (response.data === null) {
                navigate("/");
            } else if (response.data) {
                setFormData(response.data);
                if (response.data.status >= 3) {
                    setShowTest(false);
                    getScore();
                } else {
                    const savedTest = localStorage.getItem("testData");
                    if (savedTest) {
                        setSubjects(JSON.parse(savedTest));
                    } else {
                        fetchTestData();
                    }
                }
            }
        } catch (error) {
            console.error("Error fetching data:", error);
        }
    };

    const getScore = async () => {
        try {
            const response = await ApiCall(`/api/v1/test/score/${phone}`, "GET", null, null, true);
            if (response.data === null) {
                navigate("/");
            } else if (response.data) {
                setTotalScore(response.data?.score);

                if(response.data?.score<57){
                    setFailed(true)
                }
            }
        } catch (error) {
            console.error("Error fetching data:", error);
        }
    };

    const fetchTestData = async () => {
        try {
            const response = await ApiCall(`/api/v1/test/${phone}`, "GET", null, null, true);
            if (response.data) {
              if(response.data.subject5.length===0 || response.data.subject5.length===0){
                  setIjodiy(true)
              }
                const subjectsData = {
                    subject1: response.data.subject1 || [],
                    subject2: response.data.subject2 || [],
                    subject3: response.data.subject3 || [],
                    subject4: response.data.subject4 || [],
                    subject5: response.data.subject5 || [],
                };

                setSubjectNames(response?.data?.subjects);
                setSubjects(subjectsData);
                localStorage.setItem("testData", JSON.stringify(subjectsData));
                setFailed(false)
                setShowTest(true)
                // Check if subject4 is empty

            } else {

                navigate("/");
            }
        } catch (error) {
            console.error("Error fetching test data:", error);
        }
    };

    const handleAnswerChange = (questionId, optionIndex) => {
        setAnswers((prev) => {
            const updatedAnswers = { ...prev, [questionId]: optionIndex };
            localStorage.setItem("answers", JSON.stringify(updatedAnswers));
            return updatedAnswers;
        });
    };

    useEffect(() => {
        const savedAnswers = localStorage.getItem("answers");
        if (savedAnswers) {
            setAnswers(JSON.parse(savedAnswers));
        }
    }, []);

    const checkIfAllQuestionsAnswered = () => {
        const allQuestions = Object.values(subjects)
            .flat()
            .map((q) => q.id);


        let ans = localStorage.getItem("answers")
        if (ans){
            const allAnswered = allQuestions.every((id) => Object.keys(answers).includes(id.toString()));
            setCanSubmit(allAnswered);
        }
    };

    const handleSubmit = async () => {
        const calculateScore = (subject, weight) => {
            return subject.reduce((score, question) => {
                const selectedOption = answers[question.id];
                return selectedOption !== undefined && question.answer == selectedOption
                    ? score + weight
                    : score;
            }, 0);
        };
        // alert(JSON.stringify(subjects.subject1))

        const score1 = calculateScore(subjects.subject1, 2.2);
        const score2 = calculateScore(subjects.subject2, 2.2);
        const score3 = calculateScore(subjects.subject3, 2.2);
        const score4 = calculateScore(subjects.subject4, 6.3);
        const score5 = calculateScore(subjects.subject5, 9.3);
        // alert(score1)
        // alert(score2)
        // alert(score3)
        // alert(score4)

        const total =Number( (score1 + score2 + score3 + score5 + score4).toFixed(1));

        // alert(total)

        setShowTest(false);
        let finalScore = total;
        if(!ijodiy){
            if (total < 57) {
                setFailed(true)

            }else {
                setShowConfetti(true);
                const timer = setTimeout(() => setShowConfetti(false), 7000);
                // return () => clearTimeout(timer);

            }
        }


        setCorrectCount(finalScore);
        setTotalScore(finalScore);

        const resultData = {
            score: parseFloat((total || 0).toFixed(1)),
            showScore: parseFloat((finalScore || 0).toFixed(1)),
        };


        try {
            await ApiCall(`/api/v1/test/result/${phone}`, "POST", resultData, null, true);
            localStorage.clear();
            getPhoneData()
        } catch (error) {
            console.error("Error submitting test data:", error);
        }
    };

    const handleDownloadPDF = async () => {
        try {
            const response = await fetch(`${baseUrl}/api/v1/abuturient/contract/${phone}`, {
                method: 'GET',
            });

            if (!response.ok) {
                throw new Error("Failed to download file");
            }

            const contentType = response.headers.get('Content-Type');
            if (!contentType || !contentType.includes('application/pdf')) {
                throw new Error("The response is not a valid PDF file.");
            }

            const blob = await response.blob();
            if (!blob.size) {
                throw new Error("The PDF file is empty.");
            }

            const downloadUrl = window.URL.createObjectURL(blob);
            const link = document.createElement('a');
            link.href = downloadUrl;
            link.download = `Contract_${phone}.pdf`;
            document.body.appendChild(link);
            link.click();
            link.remove();
            window.URL.revokeObjectURL(downloadUrl);

            console.log("PDF downloaded successfully");
        } catch (error) {
            console.error("Error downloading PDF:", error);
        }
    };
    const [shuffledAnswers, setShuffledAnswers] = useState({});
    useEffect(() => {
        if (Object.keys(subjects).length > 0) {
            const shuffled = {};
            Object.keys(subjects).forEach((subjectKey) => {
                subjects[subjectKey].forEach((question) => {
                    const options = [question.answer, question.wrongAnswer1, question.wrongAnswer2, question.wrongAnswer3];
                    shuffled[question.id] = options.sort(() => Math.random() - 0.5); // Shuffle once
                });
            });
            setShuffledAnswers(shuffled);
        }
    }, [subjects]);

    const handleMainImageChange = (e) => {
        setCertificate1(e.target.files[0]);
    };
    return (
        <div>
            <Header />
            {showConfetti && <Confetti />}

            {showTest ? (
                <div className={"pt-40"}>
                    <div className={"border-2 mt-0 m-4 my-0 rounded bg-cyan-300 p-2 "}>
                        <h1 className="text-xl font-semibold">
                            {formData?.lastName} {formData?.firstName} {formData?.fatherName}
                        </h1>
                        <p className="text-xl">
                            Ta'lim turi: {formData?.educationField?.educationForm?.educationType?.name}
                        </p>
                        <p className="text-xl">
                            Ta'lim shakli: {formData?.educationField?.educationForm?.name}
                        </p>
                        <p className="text-xl m-2">
                            Ta'lim yonalishi: {formData?.educationField?.name}
                        </p>

                        {/*<div className={"grid grid-cols-1 md:grid-cols-2 xl:grid-cols-3  justify-center place-items-center"}>*/}

                        {/*  <div>*/}
                        {/*      <div className="flex items-center justify-center w-full mx-4">*/}
                        {/*          <label htmlFor="mainImage"*/}
                        {/*                 className="flex flex-col items-center justify-center w-full h-20 border-2 border-dashed border-gray-300 rounded-lg cursor-pointer bg-gray-50 hover:bg-gray-100">*/}
                        {/*              <div className="flex flex-col items-center justify-center pt-2 ">*/}

                        {/*                  <p className="mb-2 text-sm text-gray-500"><span className="font-semibold">Milly sertifikatni yuklash uchun bosing</span> </p>*/}
                        {/*                  <p className="text-xs text-gray-500">PDF fayl (maksimal o'lcham 5MB)</p>*/}
                        {/*              </div>*/}
                        {/*              <input id="mainImage" type="file" className="hidden" name="mainImage"*/}
                        {/*                     onChange={()=>handleMainImageChange(1)}*/}
                        {/*                     accept="application/pdf"  />*/}
                        {/*          </label>*/}
                        {/*      </div>*/}
                        {/*  </div>*/}


                        {/*    <div>*/}
                        {/*        <div className="flex items-center justify-center w-full mx-4">*/}
                        {/*            <label htmlFor="mainImage"*/}
                        {/*                   className="flex flex-col items-center justify-center w-full h-20 border-2 border-dashed border-gray-300 rounded-lg cursor-pointer bg-gray-50 hover:bg-gray-100">*/}
                        {/*                <div className="flex flex-col items-center justify-center pt-2 ">*/}

                        {/*                    <p className="mb-2 text-sm text-gray-500"><span className="font-semibold">Milly sertifikatni yuklash uchun bosing</span> </p>*/}
                        {/*                    <p className="text-xs text-gray-500">PDF fayl (maksimal o'lcham 5MB)</p>*/}
                        {/*                </div>*/}
                        {/*                <input id="mainImage" type="file" className="hidden" name="mainImage"*/}
                        {/*                       onChange={handleMainImageChange}*/}
                        {/*                       accept="application/pdf"  />*/}
                        {/*            </label>*/}
                        {/*        </div>*/}
                        {/*    </div>*/}

                        {/*    <div>*/}
                        {/*        <div className="flex items-center justify-center w-full mx-4">*/}
                        {/*            <label htmlFor="mainImage"*/}
                        {/*                   className="flex flex-col items-center justify-center w-full h-20 border-2 border-dashed border-gray-300 rounded-lg cursor-pointer bg-gray-50 hover:bg-gray-100">*/}
                        {/*                <div className="flex flex-col items-center justify-center pt-2 ">*/}

                        {/*                    <p className="mb-2 text-sm text-gray-500"><span className="font-semibold">Xorijiy sertifikatni yuklash uchun bosing</span> </p>*/}
                        {/*                    <p className="text-xs text-gray-500">PDF fayl (maksimal o'lcham 5MB)</p>*/}
                        {/*                </div>*/}
                        {/*                <input id="mainImage" type="file" className="hidden" name="mainImage"*/}
                        {/*                       onChange={handleMainImageChange}*/}
                        {/*                       accept="application/pdf"  />*/}
                        {/*            </label>*/}
                        {/*        </div>*/}
                        {/*    </div>*/}

                        {/*</div>*/}
                    </div>


                    <div className={""}>
                        <div className="grid grid-cols-1 md:grid-cols-3 p-4 pt-0">
                            <div className="col-span-1 md:col-span-2 pt-2">
                                <div className="test-container">
                                    {
                                        Object.keys(subjects).reduce((acc, subjectKey) => {
                                            if (!subjects[subjectKey]?.length) return acc;

                                            return [
                                                ...acc,
                                                ...subjects[subjectKey].map((question, idx) => {
                                                    const globalIndex = acc.length + idx + 1;

                                                    return (
                                                        <div key={question.id} className="border-2 rounded p-2 mb-4">
                                                        <p className="text-[16px] sm:text-[18px]">
                                                                <span className="font-semibold">{globalIndex}. </span>
                                                                {question.question}
                                                            </p>
                                                            {shuffledAnswers[question.id]?.map((option, i) => (
                                                                <label key={i} className="block p-1">
                                                                    <input
                                                                        id={`question-${question.id}`}
                                                                        type="radio"
                                                                        name={`question-${question.id}`}
                                                                        value={option}
                                                                        checked={answers[question.id] === option}
                                                                        onChange={() => handleAnswerChange(question.id, option)}
                                                                    />
                                                                    {option}
                                                                </label>
                                                            ))}
                                                        </div>
                                                    );
                                                }),
                                            ];
                                        }, [])
                                    }
                                </div>
                            </div>

                            <div
                                className="col-span-1 pt-2 p-4"
                                style={{ position: "sticky", top: "0", maxHeight: "100vh", overflowY: "auto" }}
                            >
                                <h4 className="p-2 pt-0">Javoblar</h4>
                                <div className="grid grid-cols-5 sm:grid-cols-10 gap-1 p-2 pt-0">
                                    {Object.values(subjects)
                                        .flat()
                                        .map((question, index) => {
                                            return (
                                                <div
                                                    key={question.id}
                                                    className={`${
                                                        answers[question.id] ? "bg-blue-600 text-white" : "bg-gray-200"
                                                    } col-span-1 text-center p-2 rounded-3xl border-2 cursor-pointer`}
                                                    onClick={() => {
                                                        const targetElement = document.getElementById(`question-${question.id}`);
                                                        if (targetElement) {
                                                            targetElement.scrollIntoView({ behavior: "smooth" });
                                                        } else {
                                                            console.error(`Element #question-${question.id} not found`);
                                                        }
                                                    }}
                                                >
                                                    {index + 1}
                                                </div>
                                            );
                                        })}
                                </div>
                                <button
                                    onClick={handleSubmit}
                                    className={`block mx-auto px-4 py-2 mb-4 rounded mt-4 ${
                                        canSubmit ? "bg-blue-500 text-white" : "bg-gray-300 text-gray-500 cursor-not-allowed"
                                    }`}
                                    disabled={!canSubmit}
                                >
                                    Testni yakunlash
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            ) : (
                (failed && !ijodiy) ?
                   <div className={"pt-44"}>
                       <Zoom>
                           <div className={"bg-cyan-300 p-4 m-4 mt-0 bg-cover  "}
                                style={{ backgroundImage: `url(${bg11})` }}>


                               <h3 className={"text-white xl:text-3xl md:text-xl sm:text-sm"}>Siz testdan yetarli balni to'play olmadingiz. </h3>
                               <h3 className={"text-white xl:text-3xl md:text-xl sm:text-sm"}> Sizning to'plagan balingiz: <span className={"text-3xl text-black"}>{Number((parseFloat(totalScore) || 0).toFixed(1))}</span></h3>
                               <div>
                                   <button
                                       onClick={() => {
                                           localStorage.clear();
                                           setAnswers({});
                                           setSubjects({ subject1: [],
                                               subject2: [],
                                               subject3: [],
                                               subject4: [],
                                               subject5: [],})

                                           fetchTestData(); // Funksiyani chaqirish
                                       }}
                                       className="bg-blue-600 p-2 rounded my-2 text-white hover:shadow-2xl transform"
                                   >
                                       Testni qayta topshirish
                                   </button>

                               </div>
                               <div className='flex-1 min-w-[250px]  '>

                                   <div className='flex items-center gap-2 '>
                                       <CiPhone className='text-white text-2xl' />
                                       <a className='text-white ' href="tel:+998553099999">+998 55 309-99-99</a>
                                   </div>
                                   <div className='flex items-center gap-2 mb-4'>
                                       <CiPhone className='text-white text-2xl' />
                                       <a className='text-white ' href="tel:+998 55 305-55-55">+998 55 305-55-55</a>
                                   </div>
                                   <iframe
                                       src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3064.8958577959097!2d64.42846967583635!3d39.80932777154381!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3f5009003f1c477b%3A0x920d498788a13e58!2sBuxoro%20psixologiya%20va%20xorijiy%20tillar%20instituti!5e0!3m2!1sru!2s!4v1728054121217!5m2!1sru!2s"
                                       width="100%"
                                       height="250"
                                       allowFullScreen=""
                                       loading="lazy"
                                       className='rounded-lg '
                                       referrerPolicy="no-referrer-when-downgrade "
                                   ></iframe>
                               </div>

                           </div>

                       </Zoom>
                   </div>
                        :
                    <div className={"pt-44"}>
                        <Zoom>
                            <div className={""}>
                                {ijodiy ? (
                                    <div className={"bg-cyan-300 p-4 m-4 mt-0 bg-cover  "}
                                         style={{ backgroundImage: `url(${bg11})` }}>
                                        <h3 className={"text-white xl:text-3xl md:text-xl sm:text-sm"}>Ijodiy imtihonni topshirish uchun siz institutga markaziy binosiga tashrif buyurishingiz so'raladi.  </h3>
                                        <h3 className={"text-white xl:text-3xl md:text-xl sm:text-sm"}>  Sizning balingiz <span className={"text-3xl text-black"}>Number((parseFloat(totalScore) || 0).toFixed(1))</span></h3>
                                        <h4 className={"text-white xl:text-3xl md:text-xl sm:text-sm"}>Manzil: Buxoro shahri Sitorayi Mohi-Xosa MFY G'ijduvon ko'chasi 250-uy</h4>

                                        <div className='flex-1 min-w-[250px] border-r pr-4'>

                                            <div className='flex items-center gap-2 '>
                                                <CiPhone className='text-white text-2xl' />
                                                <a className='text-white ' href="tel:+998553099999">+998 55 309-99-99</a>
                                            </div>
                                            <div className='flex items-center gap-2 mb-4'>
                                                <CiPhone className='text-white text-2xl' />
                                                <a className='text-white' href="tel:+998 55 305-55-55">+998 55 305-55-55</a>
                                            </div>
                                            <iframe
                                                src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3064.8958577959097!2d64.42846967583635!3d39.80932777154381!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3f5009003f1c477b%3A0x920d498788a13e58!2sBuxoro%20psixologiya%20va%20xorijiy%20tillar%20instituti!5e0!3m2!1sru!2s!4v1728054121217!5m2!1sru!2s"

                                                height="250"
                                                allowFullScreen=""
                                                loading="lazy"
                                                className='rounded-lg '
                                                referrerPolicy="no-referrer-when-downgrade"
                                            ></iframe>
                                        </div>

                                    </div>
                                ) : (
                                    <div className={"bg-cyan-300 p-4 m-4 mt-0 bg-cover  "}
                                         style={{ backgroundImage: `url(${bg11})` }}>

                                        <h3 className={"text-white xl:text-3xl md:text-xl sm:text-sm"}>Tabriklaymiz siz talabalar safiga qabul qilindingiz! </h3>
                                        <h3 className={"text-white xl:text-3xl md:text-xl sm:text-sm"}>Sizni talabalar safimizda ko'rishdan xursand bo'lamiz. </h3>
                                        <h3 className={"text-white xl:text-3xl md:text-xl sm:text-sm"}> Sizning to'plagan balingiz: <span className={"text-3xl text-black"}>{Number((parseFloat(totalScore) || 0).toFixed(1))}</span></h3>
                                        <div>
                                            <button
                                                onClick={handleDownloadPDF}
                                                className={"bg-blue-600 p-2 rounded text-white hover:shadow-2xl transform"}
                                            >
                                                Shartnomani yuklab olish
                                            </button>
                                        </div>
                                        <div className='flex-1 min-w-[250px]  '>

                                            <div className='flex items-center gap-2 '>
                                                <CiPhone className='text-white text-2xl' />
                                                <a className='text-white ' href="tel:+998553099999">+998 55 309-99-99</a>
                                            </div>
                                            <div className='flex items-center gap-2 mb-4'>
                                                <CiPhone className='text-white text-2xl' />
                                                <a className='text-white ' href="tel:+998 55 305-55-55">+998 55 305-55-55</a>
                                            </div>
                                            <iframe
                                                src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3064.8958577959097!2d64.42846967583635!3d39.80932777154381!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3f5009003f1c477b%3A0x920d498788a13e58!2sBuxoro%20psixologiya%20va%20xorijiy%20tillar%20instituti!5e0!3m2!1sru!2s!4v1728054121217!5m2!1sru!2s"
                                                width="100%"
                                                height="250"
                                                allowFullScreen=""
                                                loading="lazy"
                                                className='rounded-lg '
                                                referrerPolicy="no-referrer-when-downgrade "
                                            ></iframe>
                                        </div>

                                    </div>
                                )}
                            </div>
                        </Zoom>
                    </div>

            )}

            <Footer />
        </div>
    );
}

export default TestAbiturient;