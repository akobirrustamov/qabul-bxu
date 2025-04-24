import React, { useEffect, useState } from 'react';
import Sidebar from "./Sidebar";
import ApiCall, {baseUrl} from "../../config";
import 'react-responsive-modal/styles.css';
import {useNavigate} from "react-router-dom";
import {Modal} from "react-responsive-modal";

function Appeals() {
    const [appeals, setAppeals] = useState([]);
    const [editModalOpen, setEditModalOpen] = useState(false);
    const [editData, setEditData] = useState({
        passportPin: "",
        passportNumber: "",
        firstName: "",
        lastName: "",
        fatherName: "",
    });
    const [appealType, setAppealType] = useState([]);
    const [educationType, setEducationType] = useState([]);
    const [educationForm, setEducationForm] = useState([]);
    const [educationField, setEducationField] = useState([]);

    const [pagination, setPagination] = useState({
        pageNumber: 0,
        totalPages: 1,
        size: 50,
    })

    useEffect(() => {
        // fetchAppeals()
        fetchAppeals()
        fetchAppealType();
        fetchEducationType();
    }, []);

    const fetchAppeals = async ()=>{
        const token = localStorage.getItem("access_token");
        try {
            const response = await ApiCall('/api/v1/agent/appeals/'+token, 'GET', null, null, true);
            setAppeals(response.data);
        } catch (error) {
            console.error("Error fetching news:", error);
        }
    }

    const fetchEducationForm = async (id) => {
        try {
            const response = await ApiCall(`/api/v1/education-form/${id}`, "GET", null, null, true);
            setEducationForm(response.data);
        } catch (error) {
            console.error("Error fetching education forms:", error);
        }
    };

    const fetchEducationField = async (id) => {
        try {
            const response = await ApiCall(`/api/v1/education-field/${id}`, "GET", null, null, true);
            setEducationField(response.data);

        } catch (error) {
            console.error("Error fetching education fields:", error);
        }
    };

    const handleEditClick = (appeal) => {
        const educationTypeId = appeal.educationField?.educationForm?.educationType?.id || "";
        const educationFormId = appeal.educationField?.educationForm?.id || "";
        const educationFieldId = appeal.educationField?.id || "";

        // Fetch dependent dropdowns
        if (educationTypeId) fetchEducationForm(educationTypeId);
        if (educationFormId) fetchEducationField(educationFormId);

        // Set edit data
        setEditData({
            id: appeal.id,
            passportPin: appeal.passportPin || "",
            passportNumber: appeal.passportNumber || "",
            firstName: appeal.firstName || "",
            lastName: appeal.lastName || "",
            fatherName: appeal.fatherName || "",
            appealTypeId: appeal.appealType?.id || "",
            educationTypeId,
            educationFormId,
            educationFieldId,
        });

        // Open the modal
        setEditModalOpen(true);
    };

    const handleDownloadPDF = async (phone) => {
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

            // Cleanup
            link.remove();
            window.URL.revokeObjectURL(downloadUrl);

            console.log("PDF downloaded successfully");
        } catch (error) {
            console.error("Error downloading PDF:", error);
        }
    };
    const handlePageChange = async (newPage) => {
        if (newPage >= 0 && newPage < pagination.totalPages) {
            setPagination((prev) => ({...prev, pageNumber: newPage}));

            await fetchAppeals()
        }

    };

    const renderPaginationButtons = () => {
        const buttons = [];
        const totalPages = pagination.totalPages;

        // Always show the first page
        buttons.push(
            <button
                key={1}
                onClick={() => handlePageChange(0)}
                className={`px-4 py-2 rounded-md ${
                    pagination.pageNumber === 0
                        ? "bg-blue-500 text-white"
                        : "bg-gray-200 hover:bg-gray-300"
                }`}
            >
                1
            </button>
        );

        // Show ellipsis if there are pages before the current page
        if (pagination.pageNumber > 2) {
            buttons.push(<span key="ellipsis-start">...</span>);
        }

        // Show current page and surrounding pages
        for (
            let i = Math.max(1, pagination.pageNumber - 1);
            i <= Math.min(totalPages - 2, pagination.pageNumber + 1);
            i++
        ) {
            buttons.push(
                <button
                    key={i + 1}
                    onClick={() => handlePageChange(i)}
                    className={`px-4 py-2 rounded-md ${
                        pagination.pageNumber === i
                            ? "bg-blue-500 text-white"
                            : "bg-gray-200 hover:bg-gray-300"
                    }`}
                >
                    {i + 1}
                </button>
            );
        }

        // Show ellipsis if there are pages after the current page
        if (pagination.pageNumber < totalPages - 3) {
            buttons.push(<span key="ellipsis-end">...</span>);
        }

        // Always show the last page
        if (totalPages > 1) {
            buttons.push(
                <button
                    key={totalPages}
                    onClick={() => handlePageChange(totalPages - 1)}
                    className={`px-4 py-2 rounded-md ${
                        pagination.pageNumber === totalPages - 1
                            ? "bg-blue-500 text-white"
                            : "bg-gray-200 hover:bg-gray-300"
                    }`}
                >
                    {totalPages}
                </button>
            );
        }

        return buttons;
    };


    const handleInputChange = (e) => {
        const { name, value } = e.target;

        // Passport Pin validation (14 numeric characters)
        if (name === "passportPin") {
            const numericValue = value.replace(/\D/g, ""); // Remove non-numeric characters
            if (numericValue.length <= 14) {
                setEditData((prev) => ({ ...prev, [name]: numericValue }));
            }
            return;
        }

        // Passport Number validation (2 capital letters + 9 numbers)
        if (name === "passportNumber") {
            const formattedValue = value.toUpperCase(); // Convert to uppercase
            const letters = formattedValue.slice(0, 2).replace(/[^A-Z]/g, ""); // First 2 capital letters
            const numbers = formattedValue.slice(2).replace(/\D/g, ""); // Remaining numeric characters
            const passportNumber = `${letters}${numbers.slice(0, 7)}`; // Combine letters and up to 9 numbers
            setEditData((prev) => ({ ...prev, [name]: passportNumber }));
            return;
        }

        // General case for other fields
        setEditData((prev) => ({ ...prev, [name]: value }));
    };
    const validateInputs = () => {
        if( editData.passportPin.length>0 || editData.passportNumber.length>0){
            if (
                editData.passportPin.length !== 14 ||
                !/^[A-Z]{2}\d{7}$/.test(editData.passportNumber) || // 2 capital letters + 9 digits
                !editData.firstName.trim() ||
                !editData.lastName.trim()

            ) {
                alert("Please ensure all fields are filled out correctly.");
                return false;
            }

        }else {
            if (
                !editData.firstName.trim() ||
                !editData.lastName.trim()

            ) {
                alert("Please ensure all fields are filled out correctly.");
                return false;
            }
        }



        return true;
    };




    const fetchAppealType = async () => {
        try {
            const response = await ApiCall(`/api/v1/appeal-type`, "GET", null, null, true);
            setAppealType(response.data || []);
        } catch (error) {
            console.error("Error fetching appeal types:", error);
        }
    };

    const fetchEducationType = async () => {
        try {
            const response = await ApiCall(`/api/v1/education-type`, "GET", null, null, true);
            setEducationType(response.data);
        } catch (error) {
            console.error("Error fetching education types:", error);
        }
    };


    const handleEditSubmit = async () => {
        if (!validateInputs()) return;
        const token = localStorage.getItem("access_token");

        try {
            await ApiCall(`/api/v1/admin/appeals/${editData.id}/${token}`, 'PUT', editData, null, true);
            setEditModalOpen(false);
            fetchAppeals(); // Refresh the appeals list
        } catch (error) {
            console.error("Error updating appeal:", error);
        }
    };


    return (
        <div>
            <Sidebar />
            <div className="p-10 sm:ml-64">
                <div className="flex justify-between items-center mb-4">
                    <h2 className="text-3xl md:text-4xl xl:text-5xl">Kelib tushgan arizalar</h2>
                </div>


                <table className="min-w-full mt-4 border-collapse border border-gray-300">
                    <thead>
                    <tr className="bg-gray-100">
                        <th className="border border-gray-300 px-1 py-1 text-[14px]">N%</th>
                        <th className="border border-gray-300 px-1 py-1 text-[14px]">FIO</th>
                        <th className="border border-gray-300 px-1 py-1 text-[14px]">Passport</th>
                        <th className="border border-gray-300 px-1 py-1 text-[14px]">Telefon</th>
                        <th className="border border-gray-300 px-1 py-1 text-[14px]">Ariza turi</th>
                        <th className="border border-gray-300 px-1 py-1 text-[14px]">Ta'lim turi</th>
                        <th className="border border-gray-300 px-1 py-1 text-[14px]">Ta'lim shakli</th>
                        <th className="border border-gray-300 px-1 py-1 text-[14px]">Yonalishi</th>
                        <th className="border border-gray-300 px-1 py-1 text-[14px]">Agent</th>
                        <th className="border border-gray-300 px-1 py-1 text-[14px]">Sana</th>
                        <th className="border border-gray-300 px-1 py-1 text-[14px]">Status</th>
                        <th className="border border-gray-300 px-1 py-1 text-[14px]">Ball</th>
                        <th className="border border-gray-300 px-1 py-1 text-[14px]"></th>
                    </tr>
                    </thead>
                    <tbody>
                    {appeals.map((appeal, index) => (
                        <tr key={index} className="group border-t border-gray-200 hover:border-blue-500 hover:bg-blue-50 hover:border-l-green-400 transition-all">
                            <td className="border border-gray-200 px-1 py-1 text-[14px]">{index + 1}</td>
                            <td className="border border-gray-200 px-1 py-1 text-[12px]">{`${appeal.lastName} ${appeal.firstName} ${appeal.fatherName}`}</td>
                            <td
                                className={`border border-gray-200 px-1 py-1 text-[14px] ${
                                    (!appeal.passportPin && !appeal.passportNumber) ? 'bg-red-400' : ''
                                }`}
                            >
                                {`${appeal.passportPin || ''} ${appeal.passportNumber || ''}`}
                            </td>
                            <td className="border border-gray-200 px-1 py-1 text-[14px]">
                                {appeal.phone.trim()}
                            </td>
                            <td className="border border-gray-200 px-1 py-1 text-[14px]">{appeal.appealType?.name}</td>
                            <td className="border border-gray-200 px-1 py-1 text-[14px]">{appeal.educationField?.educationForm?.educationType?.name}</td>
                            <td className="border border-gray-200 px-1 py-1 text-[14px]">{appeal.educationField?.educationForm?.name}</td>
                            <td className="border border-gray-200 px-1 py-1 text-[14px]">{appeal.educationField?.name}</td>
                            <td className="border border-gray-200 px-1 py-1 text-[14px]">{appeal.agent?.name}</td>
                            <td className="border border-gray-200 px-1 py-1 text-[14px]">
                                {new Date(appeal.createdAt).toLocaleString()}
                            </td>
                            <td className="border border-gray-200 px-1 py-1 text-[10px]">
                                {appeal.status === 1 && "Telefon raqam kiritgan"}
                                {appeal.status === 2 && "Ma'lumot kiritgan"}
                                {appeal.status === 3 && "Test yechgan"}
                                {appeal.status === 4 && "Shartnoma olgan"}
                            </td>
                            <td className="border border-gray-200 px-1 py-1 text-[14px]">{appeal.ball}</td>

                            <td className="border border-gray-200 px-1 py-1 text-[14px] d-flex gap-1">
                                <button
                                    className="text-white bg-blue-600 rounded p-1 hover:underline"
                                    onClick={() => handleEditClick(appeal)}
                                >
                                    <svg className="w-6 h-6 text-gray-800 dark:text-white" aria-hidden="true"
                                         xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none"
                                         viewBox="0 0 24 24">
                                        <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"
                                              stroke-width="2"
                                              d="M10.779 17.779 4.36 19.918 6.5 13.5m4.279 4.279 8.364-8.643a3.027 3.027 0 0 0-2.14-5.165 3.03 3.03 0 0 0-2.14.886L6.5 13.5m4.279 4.279L6.499 13.5m2.14 2.14 6.213-6.504M12.75 7.04 17 11.28"/>
                                    </svg>
                                </button>
                                {appeal?.ball>40&&
                                    <button
                                        className="text-white bg-green-600 rounded p-1 hover:underline"
                                        onClick={() => handleDownloadPDF(appeal.phone)}
                                    >

                                        <svg className="w-6 h-6 text-gray-800 dark:text-white" aria-hidden="true"
                                             xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none"
                                             viewBox="0 0 24 24">
                                            <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"
                                                  stroke-width="2"
                                                  d="M15 4h3a1 1 0 0 1 1 1v15a1 1 0 0 1-1 1H6a1 1 0 0 1-1-1V5a1 1 0 0 1 1-1h3m0 3h6m-6 5h6m-6 4h6M10 3v4h4V3h-4Z"/>
                                        </svg>

                                    </button>
                                }
                            </td>

                        </tr>
                    ))}
                    </tbody>
                </table>

                <div className="mt-4 flex justify-center gap-2">
                    <button
                        onClick={() => handlePageChange(pagination.pageNumber - 1)}
                        disabled={pagination.pageNumber === 0}
                        className="bg-blue-500 text-white px-4 py-2 rounded-md hover:bg-blue-600 disabled:bg-gray-300"
                    >
                        <svg className="w-6 h-6 text-gray-800 dark:text-white" aria-hidden="true"
                             xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" viewBox="0 0 24 24">
                            <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                  d="M8 6v12m8-12v12l-8-6 8-6Z"/>
                        </svg>

                    </button>
                    {renderPaginationButtons()}
                    <button
                        onClick={() => handlePageChange(pagination.pageNumber + 1)}
                        disabled={pagination.pageNumber === pagination.totalPages - 1}
                        className="bg-blue-500 text-white px-4 py-2 rounded-md hover:bg-blue-600 disabled:bg-gray-300"
                    >
                        <svg className="w-6 h-6 text-gray-800 dark:text-white" aria-hidden="true"
                             xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" viewBox="0 0 24 24">
                            <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                  d="M16 6v12M8 6v12l8-6-8-6Z"/>
                        </svg>

                    </button>
                </div>

                {/* Edit Modal */}
                <Modal
                    open={editModalOpen}
                    onClose={() => setEditModalOpen(false)}
                    animationDuration={600}
                    center

                >
                    <h2 className="text-lg font-semibold text-gray-800 mb-4">Tahrirlash</h2>
                    <div
                        className="flex flex-col bg-white rounded-lg shadow-lg p-6"
                        style={{
                            width: "500px",
                            height: "auto",
                        }}
                    >
                        <form>
                            <div className="space-y-4">
                                <div>
                                    <label className="text-gray-600">JSHR</label>
                                    <input
                                        type="text"
                                        name="passportPin"
                                        placeholder="Passport Pin (14 digits)"
                                        value={editData.passportPin || ""}
                                        onChange={handleInputChange}
                                        className="border border-gray-300 rounded-md p-1 w-full focus:outline-none focus:ring-2 focus:ring-green-500"
                                        required
                                    />
                                </div>

                                <div>
                                    <label className="text-gray-600">Passport raqami</label>
                                    <input
                                        type="text"
                                        name="passportNumber"
                                        placeholder="Passport Number (e.g., AB123456789)"
                                        value={editData.passportNumber || ""}
                                        onChange={handleInputChange}
                                        className="border border-gray-300 rounded-md p-1 w-full focus:outline-none focus:ring-2 focus:ring-green-500"
                                        required
                                    />
                                </div>

                                <div>
                                    <label className="text-gray-600">Familiya</label>
                                    <input
                                        type="text"
                                        name="lastName"
                                        value={editData.lastName || ""}
                                        onChange={handleInputChange}
                                        className="border border-gray-300 rounded-md p-1 w-full focus:outline-none focus:ring-2 focus:ring-green-500"
                                        required
                                    />
                                </div>

                                <div>
                                    <label className="text-gray-600">Ism</label>
                                    <input
                                        type="text"
                                        name="firstName"
                                        value={editData.firstName || ""}
                                        onChange={handleInputChange}
                                        className="border border-gray-300 rounded-md p-1 w-full focus:outline-none focus:ring-2 focus:ring-green-500"
                                        required
                                    />
                                </div>

                                <div>
                                    <label className="text-gray-600">Sharifi</label>
                                    <input
                                        type="text"
                                        name="fatherName"
                                        value={editData.fatherName || ""}
                                        onChange={handleInputChange}
                                        className="border border-gray-300 rounded-md p-1 w-full focus:outline-none focus:ring-2 focus:ring-green-500"
                                        required
                                    />
                                </div>

                                <div>
                                    <label className="text-gray-600">Ariza turi</label>
                                    <select
                                        name="appealTypeId"
                                        value={editData.appealTypeId || ""}
                                        onChange={handleInputChange}
                                        className="border border-gray-300 rounded-md p-2 w-full focus:outline-none focus:ring-2 focus:ring-green-500"
                                        required
                                    >
                                        <option value="">Ariza turini tanlang</option>
                                        {appealType?.map((item) => (
                                            <option key={item.id} value={item.id}>
                                                {item.name}
                                            </option>
                                        ))}
                                    </select>
                                </div>

                                <div>
                                    <label className="text-gray-600">Ta'lim turi</label>
                                    <select
                                        name="educationTypeId"
                                        value={editData.educationTypeId || ""}
                                        onChange={(e) => {
                                            handleInputChange(e);
                                            fetchEducationForm(e.target.value);
                                        }}
                                        className="border border-gray-300 rounded-md p-2 w-full focus:outline-none focus:ring-2 focus:ring-green-500"
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

                                <div>
                                    <label className="text-gray-600">Ta'lim shakli</label>
                                    <select
                                        name="educationFormId"
                                        value={editData.educationFormId || ""}
                                        onChange={(e) => {
                                            handleInputChange(e);
                                            fetchEducationField(e.target.value);
                                        }}
                                        className="border border-gray-300 rounded-md p-2 w-full focus:outline-none focus:ring-2 focus:ring-green-500"
                                        required
                                    >
                                        <option value="">Ta'lim shaklini tanlang</option>
                                        {educationForm.map((item) => (
                                            <option key={item.id} value={item.id}>
                                                {item.name}
                                            </option>
                                        ))}
                                    </select>
                                </div>

                                <div>
                                    <label className="text-gray-600">Yo'nalish</label>
                                    <select
                                        name="educationFieldId"
                                        value={editData.educationFieldId || ""}
                                        onChange={handleInputChange}
                                        className="border border-gray-300 rounded-md p-2 w-full focus:outline-none focus:ring-2 focus:ring-green-500"
                                        required
                                    >
                                        <option value="">Yo'nalishni tanlang</option>
                                        {educationField?.length > 0
                                            ? educationField.map((item) => (
                                                <option key={item.id} value={item.id}>
                                                    {item.name}
                                                </option>
                                            ))
                                            : <option value="">Ma'lumot mavjud emas</option>}
                                    </select>
                                </div>

                                <div>
                                    <button
                                        type="button"
                                        onClick={handleEditSubmit}
                                        className="w-full p-3 bg-green-600 text-white rounded-md hover:bg-green-700 transition duration-200"
                                    >
                                        Saqlash
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>
                </Modal>
            </div>
        </div>
    );
}

export default Appeals;
