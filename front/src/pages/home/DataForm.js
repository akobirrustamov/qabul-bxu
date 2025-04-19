import React, { useEffect, useState } from "react";
import {useLocation, useNavigate} from "react-router-dom";
import Header from "../header/Header";
import Footer from "../footer/Footer";
import bg from "./images/back.jpg";
import ApiCall, {baseUrl} from "../../config";
import Zoom from "react-reveal/Zoom";
import {CiPhone} from "react-icons/ci";

function DataForm() {
    const navigate = useNavigate()
    const location = useLocation();
    const phone = location.state?.phone || ""; // Extract phone from state
    const [showForm, setShowForm] = useState(true); // State to toggle form and data
    const [formData, setFormData] = useState(null); // State to store fetched data
    const [appealType, setAppealType] = useState([]);
    const [educationType, setEducationType] = useState([]);
    const [educationForm, setEducationForm] = useState([]);
    const [educationField, setEducationField] = useState([]);

    const [abuturient, setAbuturient] = useState({
        firstName: "",
        lastName: "",
        fatherName: "",
        phone: phone || "",
        additionalPhone: "",
        language: true,
        appealTypeId: "",
        educationTypeId: "",
        educationFormId: "",
        educationFieldId: "",
        createdAt: new Date().toISOString(),
    });

    useEffect(() => {
            getPhoneData();
            getAppealType();
            getEducationType();
    }, []);

    const getPhoneData = async () => {

        try {
            const response = await ApiCall(`/api/v1/abuturient/${phone}`, "GET", null, null, true);
            if (response.data === null) {
                setShowForm(true);

            } else if (response.data) {
                setFormData(response.data);
                setShowForm(false);
            }
        } catch (error) {
            console.error("Error fetching data:", error);
        }
    };

    const getAppealType = async () => {
        try {
            const response = await ApiCall(`/api/v1/appeal-type`, "GET", null, null, true);
            setAppealType(response.data);
        } catch (error) {
            console.error("Error fetching appeal types:", error);
        }
    };

    const getEducationType = async () => {
        try {
            const response = await ApiCall(`/api/v1/education-type`, "GET", null, null, true);
            setEducationType(response.data);
        } catch (error) {
            console.error("Error fetching education types:", error);
        }
    };

    const getEducationForm = async (id) => {
        setAbuturient({ ...abuturient, educationTypeId: id });
        try {
            const response = await ApiCall(`/api/v1/education-form/${id}`, "GET", null, null, true);
            setEducationForm(response.data);
        } catch (error) {
            console.error("Error fetching education forms:", error);
        }
    };

    const getEducationField = async (id) => {
        setAbuturient({ ...abuturient, educationFormId: id });
        try {
            const response = await ApiCall(`/api/v1/education-field/${id}`, "GET", null, null, true);
            setEducationField(response.data);
        } catch (error) {
            console.error("Error fetching education fields:", error);
        }
    };

    const handleSave = async (e) => {
        e.preventDefault();
        if (
            !abuturient.firstName ||
            !abuturient.lastName ||
            !abuturient.phone ||
            !abuturient.appealTypeId ||
            !abuturient.educationTypeId ||
            !abuturient.educationFormId ||
            !abuturient.educationFieldId
        ) {
            alert("Barcha maydonlarni to'ldiring!");
            return;
        }

        try {
            const response = await ApiCall(`/api/v1/abuturient`, "PUT", abuturient, null, true);
            setFormData(response.data);

            setShowForm(false);
        } catch (error) {
            console.error("Error saving data:", error);
            alert("Xatolik yuz berdi. Ma'lumotni saqlashning iloji bo'lmadi.");
        }
    };

    const handleInputChange = (e) => {
        const { name, value } = e.target;
        setAbuturient({ ...abuturient, [name]: value });
    };

    const handleNavigate = () => {
        localStorage.clear()
        navigate("/test", { state: { phone } });
    };

    const handleDownloadPDF = async () => {
        try {
            // Fetch the PDF from the server using the phone number
            const response = await fetch(`${baseUrl}/api/v1/abuturient/contract/${phone}`, {
                method: 'GET',
            });

            // Check if the response is OK and the content type is PDF
            if (!response.ok) {
                throw new Error("Failed to download file");
            }

            const contentType = response.headers.get('Content-Type');
            if (!contentType || !contentType.includes('application/pdf')) {
                throw new Error("The response is not a valid PDF file.");
            }

            // Convert response to blob
            const blob = await response.blob();
            if (!blob.size) {
                throw new Error("The PDF file is empty.");
            }

            // Create a temporary link to trigger download
            const downloadUrl = window.URL.createObjectURL(blob);
            const link = document.createElement('a');
            link.href = downloadUrl;
            link.download = `Contract_${phone}.pdf`; // Set the file name for download
            document.body.appendChild(link);
            link.click();

            // Cleanup the link
            link.remove();
            window.URL.revokeObjectURL(downloadUrl);

            console.log("PDF downloaded successfully");
        } catch (error) {
            console.error("Error downloading PDF:", error);
        }
    };


    return (
        <div>
            <Header />
            <div className="header-problem my-bg-second "></div>
            <div className="h-full ">
                <div
                    className="bg-fixed bg-cover bg-center "
                    style={{ backgroundImage: `url(${bg})` }}
                >
                    <section
                        className="overlay bg-black bg-opacity-50 pt-24"
                        data-stellar-background-ratio="0.5"
                    >
                        <div className="container">
                            <div className="row">
                                <div className=""></div>
                                <div className="col-lg-12 col-md-12 col-12 text-center text-white my-10">
                                    <h1 className="text-lg sm:text-xl md:text-2xl font-bold my-4">
                                        Telefon raqami: {phone}
                                    </h1>

                                   <div className={"mt-8"}>
                                       {showForm ? (
                                           <Zoom>
                                               <div className="bg-white p-8 rounded-lg shadow-lg w-full max-w-4xl mx-auto text-dark">
                                                   <h2 className="text-2xl font-bold mb-6 text-center">Ro'yxatdan o'tish</h2>
                                                   <form onSubmit={handleSave} className="space-y-6">
                                                       <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                                                           {/* First Name */}
                                                           <div>
                                                               <label className="block text-sm font-medium text-gray-700">Ism</label>
                                                               <input
                                                                   type="text"
                                                                   name="firstName"
                                                                   value={abuturient.firstName}
                                                                   onChange={handleInputChange}
                                                                   className="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500"
                                                                   required
                                                               />
                                                           </div>

                                                           {/* Last Name */}
                                                           <div>
                                                               <label className="block text-sm font-medium text-gray-700">Familiya</label>
                                                               <input
                                                                   type="text"
                                                                   name="lastName"
                                                                   value={abuturient.lastName}
                                                                   onChange={handleInputChange}
                                                                   className="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500"
                                                                   required
                                                               />
                                                           </div>

                                                           {/* Father's Name */}
                                                           <div>
                                                               <label className="block text-sm font-medium text-gray-700">Sharifi</label>
                                                               <input
                                                                   type="text"
                                                                   name="fatherName"
                                                                   value={abuturient.fatherName}
                                                                   onChange={handleInputChange}
                                                                   className="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500"

                                                               />
                                                           </div>

                                                           {/* Phone */}
                                                           <div>
                                                               <label className="block text-sm font-medium text-gray-700">Telefon raqami</label>
                                                               <input
                                                                   type="text"
                                                                   name="phone"
                                                                   disabled={true}
                                                                   value={abuturient.phone}
                                                                   onChange={handleInputChange}
                                                                   className="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500"
                                                                   required
                                                               />
                                                           </div>

                                                           {/* Appeal Type */}
                                                           <div>
                                                               <label className="block text-sm font-medium text-gray-700">Ariza turi</label>
                                                               <select
                                                                   name="appealTypeId"
                                                                   value={abuturient.appealTypeId}
                                                                   onChange={handleInputChange}
                                                                   className="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500"
                                                                   required
                                                               >
                                                                   <option value="">Ariza turini tanlang</option>
                                                                   {appealType.map((item) => (
                                                                       <option key={item.id} value={item.id}>
                                                                           {item.name}
                                                                       </option>
                                                                   ))}
                                                               </select>
                                                           </div>

                                                           {/* Education Type */}
                                                           <div>
                                                               <label className="block text-sm font-medium text-gray-700">Ta'lim turi</label>
                                                               <select
                                                                   name="educationTypeId"
                                                                   value={abuturient.educationTypeId}
                                                                   onChange={(e) => {
                                                                       setAbuturient({ ...abuturient, educationTypeId: e.target.value });
                                                                       getEducationForm(e.target.value); // Fetch education forms
                                                                   }}
                                                                   className="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500"
                                                                   required
                                                               >
                                                                   <option value="">Ta'lim turini tanlang</option>
                                                                   {educationType.map((item) => (
                                                                       <option key={item.id} value={item.id}>
                                                                           {item.name}
                                                                       </option>
                                                                   ))}
                                                               </select>
                                                           </div>

                                                           {/* Education Form */}
                                                           <div>
                                                               <label className="block text-sm font-medium text-gray-700">Ta'lim shakli</label>
                                                               <select
                                                                   name="educationFormId"
                                                                   value={abuturient.educationFormId}
                                                                   onChange={(e) => {
                                                                       setAbuturient({ ...abuturient, educationFormId: e.target.value });
                                                                       getEducationField(e.target.value); // Fetch education fields
                                                                   }}
                                                                   className="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500"
                                                                   disabled={!abuturient.educationTypeId} // Disable if educationTypeId is not selected
                                                                   required
                                                               >
                                                                   <option value="">
                                                                       {abuturient.educationTypeId ? "Ta'lim shaklini tanlang" : "Avval ta'lim turini tanlang"}
                                                                   </option>
                                                                   {educationForm.map((item) => (
                                                                       <option key={item.id} value={item.id}>
                                                                           {item.name}
                                                                       </option>
                                                                   ))}
                                                               </select>
                                                           </div>

                                                           {/* Education Field */}
                                                           <div>
                                                               <label className="block text-sm font-medium text-gray-700">Yo'nalish</label>
                                                               <select
                                                                   name="educationFieldId"
                                                                   value={abuturient.educationFieldId}
                                                                   onChange={handleInputChange}
                                                                   className="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500"
                                                                   disabled={!abuturient.educationFormId} // Disable if educationFormId is not selected
                                                                   required
                                                               >
                                                                   <option value="">
                                                                       {abuturient.educationFormId ? "Yo'nalishni tanlang" : "Avval ta'lim shaklini tanlang"}
                                                                   </option>
                                                                   {educationField.map((item) => (
                                                                       <option key={item.id} value={item.id}>
                                                                           {item.name}
                                                                       </option>
                                                                   ))}
                                                               </select>
                                                           </div>
                                                       </div>

                                                       {/* Save Button */}
                                                       <div className="text-center">
                                                           <button
                                                               type="submit"
                                                               className="bg-blue-700 text-white px-6 py-2 rounded-lg hover:bg-blue-800 transition duration-300"
                                                           >
                                                               Saqlash
                                                           </button>
                                                       </div>
                                                   </form>
                                               </div>
                                           </Zoom>

                                       ) : (
                                           <div className="bg-white p-6 rounded-lg shadow-lg w-full max-w-2xl mx-auto text-dark">
                                               <h2 className="text-2xl font-bold mb-6 text-center flex items-center justify-center">
                                                   <svg className="w-6 h-6 mr-2 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                                                       <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                                                   </svg>
                                                   Mavjud ma'lumotlar
                                               </h2>
                                               <div className="space-y-4">
                                                   {/* First Name */}
                                                   <div className="flex items-center space-x-4">
                                                       <svg className="w-5 h-5 text-gray-600" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                                                           <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z" />
                                                       </svg>
                                                       <p className={"my-1"}><strong>FIO:</strong> {formData?.lastName || "Noma'lum"} {formData?.firstName || "Noma'lum"} {formData?.fatherName ||""}</p>
                                                   </div>


                                                   {/* Phone */}
                                                   <div className="flex items-center space-x-4">
                                                       <svg className="w-5 h-5 text-gray-600" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                                                           <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M3 5a2 2 0 012-2h3.28a1 1 0 01.948.684l1.498 4.493a1 1 0 01-.502 1.21l-2.257 1.13a11.042 11.042 0 005.516 5.516l1.13-2.257a1 1 0 011.21-.502l4.493 1.498a1 1 0 01.684.949V19a2 2 0 01-2 2h-1C9.716 21 3 14.284 3 6V5z" />
                                                       </svg>
                                                       <p className={"my-1"}><strong>Telefon:</strong> {formData?.phone}</p>
                                                   </div>

                                                   {/* turi */}
                                                   <div className="flex items-center space-x-4">
                                                       <svg className="w-5 h-5 text-gray-600" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                                                           <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z" />
                                                       </svg>
                                                       <p className={"my-1"}><strong>Ta'lim turi:</strong> {formData?.educationField?.educationForm?.educationType.name || "Noma'lum"}</p>
                                                   </div>

                                                   {/* shakli */}
                                                   <div className="flex items-center space-x-4">
                                                       <svg className="w-5 h-5 text-gray-600" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                                                           <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z" />
                                                       </svg>
                                                       <p className={"my-1"}><strong>Ta'lim shakli:</strong> {formData?.educationField?.educationForm?.name || "Noma'lum"}</p>
                                                   </div>

                                                   {/* Yo'nalish */}
                                                   <div className="flex items-center space-x-4">
                                                       <svg className="w-5 h-5 text-gray-600" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                                                           <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z" />
                                                       </svg>
                                                       <p className={"my-1"}><strong>Yo'nalishi:</strong> {formData?.educationField?.name || "Noma'lum"}</p>
                                                   </div>

                                                   {/* Ariza turi */}
                                                   <div className="flex items-center space-x-4">
                                                       <svg className="w-5 h-5 text-gray-600" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                                                           <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2" />
                                                       </svg>
                                                       <p className={"my-1"}><strong>Ariza turi:</strong> {formData?.appealType?.name || "Noma'lum"}</p>
                                                   </div>

                                                   {/* Test Status and Actions */}
                                                   <div className="mt-6">
                                                       {formData?.status >= 3 ? (
                                                           <div className="text-center">
                                                               <div className="flex items-center justify-center space-x-2 mb-4">
                                                                   <svg className="w-6 h-6 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                                                                       <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M5 13l4 4L19 7" />
                                                                   </svg>
                                                                   <p className="text-lg font-semibold">Siz testdan o'tgansiz</p>
                                                               </div>
                                                               {formData.getContract&& <button
                                                                   onClick={handleDownloadPDF}
                                                                   className="bg-blue-600 text-white px-4 py-2 rounded-lg hover:bg-blue-700 transition duration-300 flex items-center justify-center space-x-2"
                                                               >
                                                                   <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                                                                       <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M4 16v1a3 3 0 003 3h10a3 3 0 003-3v-1m-4-4l-4 4m0 0l-4-4m4 4V4" />
                                                                   </svg>
                                                                   <span>Shartnomani yuklab olish</span>
                                                               </button>}
                                                           </div>
                                                       ) : (

                                                           formData?.educationField?.educationForm?.educationType.id===2?
                                                               <div>
                                                                   <div className={"bg-cyan-300 p-4 m-4 "}>
                                                                       <h3>Ijodiy imtihonni topshirish uchun siz institutga markaziy binosiga tashrif buyurishingiz so'raladi.  </h3>

                                                                       <h4>Manzil: Buxoro shahri Sitorayi Mohi-Xosa MFY G'ijduvon ko'chasi 250-uy</h4>

                                                                       <div className='flex-1 min-w-[250px] border-r pr-4'>

                                                                           <div className='flex items-center gap-2 '>
                                                                               <CiPhone className='text-dark text-2xl' />
                                                                               <a className='text-dark ' href="tel:+998553099999">+998 55 309-99-99</a>
                                                                           </div>
                                                                           <div className='flex items-center gap-2 mb-4'>
                                                                               <CiPhone className='text-dark text-2xl' />
                                                                               <a className='text-dark ' href="tel:+998 55 305-55-55">+998 55 305-55-55</a>
                                                                           </div>
                                                                           <iframe
                                                                               src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3064.8958577959097!2d64.42846967583635!3d39.80932777154381!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3f5009003f1c477b%3A0x920d498788a13e58!2sBuxoro%20psixologiya%20va%20xorijiy%20tillar%20instituti!5e0!3m2!1sru!2s!4v1728054121217!5m2!1sru!2s"
                                                                               width="100%"
                                                                               height="250"
                                                                               allowFullScreen=""
                                                                               loading="lazy"
                                                                               className='rounded-lg'
                                                                               referrerPolicy="no-referrer-when-downgrade"
                                                                           ></iframe>
                                                                       </div>

                                                                   </div>
                                                               </div>
                                                               :


                                                               <div className="text-center">
                                                                   <button
                                                                       onClick={handleNavigate}
                                                                       className="bg-blue-700 text-white px-4 py-2 rounded-lg hover:bg-blue-800 transition duration-300 flex items-center justify-center space-x-2"
                                                                   >
                                                                       <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                                                                           <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2m-6 9l2 2 4-4" />
                                                                       </svg>
                                                                       <span >Test topshirish</span>
                                                                   </button>
                                                               </div>



                                                       )}
                                                   </div>
                                               </div>
                                           </div>
                                       )}
                                   </div>
                                </div>
                            </div>
                        </div>
                    </section>
                </div>
            </div>
            <Footer/>
        </div>
    );
}

export default DataForm;
