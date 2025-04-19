import React, { useEffect, useState } from "react";
import Sidebar from "./Sidebar";
import ApiCall, { baseUrl } from "../../config";
import "react-responsive-modal/styles.css";
import { Modal } from "react-responsive-modal";

function Appeals() {
    const [appeals, setAppeals] = useState([]);
    const [editModalOpen, setEditModalOpen] = useState(false);
    const [appealType, setAppealType] = useState([]);
    const [educationType, setEducationType] = useState([]);
    const [educationForm, setEducationForm] = useState([]);
    const [educationField, setEducationField] = useState([]);
    const [agents, setAgents] = useState([]);
    const [showFilter, setShowFilter] = useState(false)
    const [filters, setFilters] = useState({
        firstName: "",
        lastName: "",
        fatherName: "",
        passportNumber: "",
        passportPin: "",
        phone: "",
        appealTypeId: "",
        educationTypeId: "",
        educationFormId: "",
        educationFieldId: "",
        agentId: "",
        createdAt: "",
    });

    const [editData, setEditData] = useState({
        id: null,
        passportPin: "",
        passportNumber: "",
        firstName: "",
        lastName: "",
        fatherName: "",
        appealTypeId: "",
        educationTypeId: "",
        educationFormId: "",
        educationFieldId: "",
    });

    useEffect(() => {
        fetchAppeals();
        fetchAppealType();
        fetchEducationType();
        fetchAgents();
    }, []);


    const [pagination, setPagination] = useState({
        pageNumber: 0,
        totalPages: 1,
        size: 50,
    })
    const fetchAppeals = async () => {
        try {
            const queryParams = new URLSearchParams({
                ...filters,
                page: pagination.pageNumber,
                size: pagination.size,
            }).toString();
            const response = await ApiCall(`/api/v1/admin/appeals?${queryParams}`, "GET", null, null, true);
            setAppeals(response.data.content);
            setPagination((prev) => ({
                ...prev,
                totalPages: response.data.totalPages,
            }));
            // alert(JSON.stringify(response.data))
        } catch (error) {
            console.error("Error fetching appeals:", error);
        }
    };


    const fetchAppealsExcel = async () => {
        try {
            const queryParams = new URLSearchParams({
                ...filters,
            }).toString();

            const response = await fetch(`${baseUrl}/api/v1/admin/appeals/excel?${queryParams}`, {
                method: 'GET',
            });

            if (!response.ok) {
                throw new Error("Failed to download file");
            }

            const contentType = response.headers.get('Content-Type');
            if (!contentType || !contentType.includes('application/vnd.openxmlformats-officedocument.spreadsheetml.sheet')) {
                throw new Error("The response is not a valid Excel file.");
            }

            const blob = await response.blob();
            if (!blob.size) {
                throw new Error("The Excel file is empty.");
            }

            const downloadUrl = window.URL.createObjectURL(blob);
            const link = document.createElement('a');
            link.href = downloadUrl;
            link.download = `Appeals.xlsx`; // Set the desired file name
            document.body.appendChild(link);
            link.click();

            // Cleanup
            link.remove();
            window.URL.revokeObjectURL(downloadUrl);

            console.log("Excel file downloaded successfully");
        } catch (error) {
            console.error("Error downloading Excel file:", error);
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

    const fetchAgents = async () => {
        try {
            const response = await ApiCall('/api/v1/agent', 'GET', null, null, true);
            setAgents(response.data);
        } catch (error) {
            console.error("Error fetching agents:", error);
        }
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

    const handleFilterChange = (e) => {
        const { name, value } = e.target;
        setFilters((prev) => ({ ...prev, [name]: value }));
        if (name === "educationTypeId") fetchEducationForm(value);
        if (name === "educationFormId") fetchEducationField(value);
    };

    const handleApplyFilters = () => {
        fetchAppeals();
    };

    const handleResetFilters = () => {
        setFilters({
            firstName: "",
            lastName: "",
            fatherName: "",
            passportNumber: "",
            passportPin: "",
            phone: "",
            appealTypeId: "",
            educationTypeId: "",
            educationFormId: "",
            educationFieldId: "",
            agentId: "",
            createdAt: "",
        });
        fetchAppeals();
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
    const handleInputChange = async (e) => {
        const { name, value } = e.target;

        // Validate Passport Pin (14 digits)
        if (name === "passportPin") {
            const numericValue = value.replace(/\D/g, ""); // Remove non-numeric characters
            if (numericValue.length <= 14) {
                setEditData((prev) => ({ ...prev, [name]: numericValue }));
            }
            return;
        }
        if (name === "passportNumber") {
            const formattedValue = value.toUpperCase(); // Convert to uppercase
            const letters = formattedValue.slice(0, 2).replace(/[^A-Z]/g, ""); // First 2 capital letters
            const numbers = formattedValue.slice(2).replace(/\D/g, ""); // Remaining numeric characters
            const passportNumber = `${letters}${numbers.slice(0, 7)}`; // Combine letters and up to 7 numbers
            setEditData((prev) => ({ ...prev, [name]: passportNumber }));
            return;
        }
        setEditData((prev) => ({ ...prev, [name]: value }));
        if (name === "educationTypeId") fetchEducationForm(value);
        if (name === "educationFormId") fetchEducationField(value);
    };
    const validateInputs = () => {
        if (
            editData.passportPin.length !== 14 ||
            !/^[A-Z]{2}\d{7}$/.test(editData.passportNumber) ||
            !editData.firstName.trim() ||
            !editData.lastName.trim() ||
            !editData.fatherName.trim() ||
            !editData.appealTypeId ||
            !editData.educationTypeId ||
            !editData.educationFormId ||
            !editData.educationFieldId
        ) {
            return false;
        }
        return true;
    };
    const handleEditSubmit = async () => {
        const token = localStorage.getItem("access_token");

        if (!validateInputs()) return;

        try {
            await ApiCall(`/api/v1/admin/appeals/${editData.id}/${token}`, "PUT", editData, null, true);
            setEditModalOpen(false);
            fetchAppeals(); // Refresh appeals
        } catch (error) {
            console.error("Error updating appeal:", error);
        }
    };
    return (
        <div>
            <Sidebar />
            <div className="p-10 sm:ml-64">
                <h2 className="text-3xl">Kelib tushgan arizalar</h2>

                {/* Filter Section */}
                <div className=" bg-white p-4 rounded-lg shadow-md">
                    {showFilter &&
                        <div className="grid grid-cols-1 md:grid-cols-3 lg:grid-cols-4 gap-4">
                            {/*<div>*/}
                            {/*    <label className="block text-gray-600">Familiya</label>*/}
                            {/*    <input*/}
                            {/*        type="text"*/}
                            {/*        name="lastName"*/}
                            {/*        value={filters.lastName}*/}
                            {/*        onChange={handleFilterChange}*/}
                            {/*        className="border border-gray-300 rounded-md p-1 w-full"*/}
                            {/*    />*/}
                            {/*</div>*/}
                            <div>
                                <label className="block text-gray-600">FIO</label>
                                <input
                                    type="text"
                                    name="firstName"
                                    value={filters.firstName}
                                    onChange={handleFilterChange}
                                    className="border border-gray-300 rounded-md p-1 w-full"
                                />
                            </div>
                            {/*<div>*/}
                            {/*    <label className="block text-gray-600">Sharifi</label>*/}
                            {/*    <input*/}
                            {/*        type="text"*/}
                            {/*        name="fatherName"*/}
                            {/*        value={filters.fatherName}*/}
                            {/*        onChange={handleFilterChange}*/}
                            {/*        className="border border-gray-300 rounded-md p-1 w-full"*/}
                            {/*    />*/}
                            {/*</div>*/}
                            <div>
                                <label className="block text-gray-600">Passport raqami</label>
                                <input
                                    type="text"
                                    name="passportNumber"
                                    value={filters.passportNumber}
                                    onChange={handleFilterChange}
                                    className="border border-gray-300 rounded-md p-1 w-full"
                                />
                            </div>
                            <div>
                                <label className="block text-gray-600">JSHR</label>
                                <input
                                    type="text"
                                    name="passportPin"
                                    value={filters.passportPin}
                                    onChange={handleFilterChange}
                                    className="border border-gray-300 rounded-md p-1 w-full"
                                />
                            </div>
                            <div>
                                <label className="block text-gray-600">Telefon</label>
                                <input
                                    type="text"
                                    name="phone"
                                    value={filters.phone}
                                    onChange={handleFilterChange}
                                    className="border border-gray-300 rounded-md p-1 w-full"
                                />
                            </div>
                            <div>
                                <label className="block text-gray-600">Ariza turi</label>
                                <select
                                    name="appealTypeId"
                                    value={filters.appealTypeId}
                                    onChange={handleFilterChange}
                                    className="border border-gray-300 rounded-md p-1 w-full"
                                >
                                    <option value="">Hammasi</option>
                                    {appealType.map((item) => (
                                        <option key={item.id} value={item.id}>
                                            {item.name}
                                        </option>
                                    ))}
                                </select>

                            </div>
                            <div>
                                <label className="block text-gray-600">Ta'lim turi</label>
                                <select
                                    name="educationTypeId"
                                    value={filters.educationTypeId}
                                    onChange={handleFilterChange}
                                    className="border border-gray-300 rounded-md p-1 w-full"
                                >
                                    <option value="">Hammasi</option>
                                    {educationType.map((item) => (
                                        <option key={item.id} value={item.id}>
                                            {item.name}
                                        </option>
                                    ))}
                                </select>
                            </div>
                            <div>
                                <label className="block text-gray-600">Ta'lim shakli</label>
                                <select
                                    name="educationFormId"
                                    value={filters.educationFormId}
                                    onChange={handleFilterChange}
                                    className="border border-gray-300 rounded-md p-1 w-full"
                                >
                                    <option value="">Hammasi</option>
                                    {educationForm.map((item) => (
                                        <option key={item.id} value={item.id}>
                                            {item.name}
                                        </option>
                                    ))}
                                </select>
                            </div>
                            <div>
                                <label className="block text-gray-600">Yo'nalish</label>
                                <select
                                    name="educationFieldId"
                                    value={filters.educationFieldId}
                                    onChange={handleFilterChange}
                                    className="border border-gray-300 rounded-md p-1 w-full"
                                >
                                    <option value="">Hammasi</option>
                                    {educationField.map((item) => (
                                        <option key={item.id} value={item.id}>
                                            {item.name}
                                        </option>
                                    ))}
                                </select>
                            </div>
                            <div>
                                <label className="block text-gray-600">Agent</label>
                                <select
                                    name="agentId"
                                    value={filters.agentId}
                                    onChange={handleFilterChange}
                                    className="border border-gray-300 rounded-md p-1 w-full"
                                >
                                    <option value="">Hammasi</option>
                                    {agents.map((item) => (
                                        <option key={item.agent.id} value={item.agent.id}>
                                            {item.agent.name}
                                        </option>
                                    ))}
                                </select>
                            </div>

                            <div>
                                <label className="block text-gray-600">Sana</label>
                                <input
                                    type="date"
                                    name="createdAt"
                                    value={filters.createdAt}
                                    onChange={handleFilterChange}
                                    className="border border-gray-300 rounded-md p-1 w-full"
                                />
                            </div>
                        </div>


                    }
                    <div className=" flex justify-content-between">
                        <div className={"flex gap-2"}>
                            <button
                                onClick={handleApplyFilters}
                                className="bg-blue-500 text-white px-2 py-1 rounded-md hover:bg-blue-600"
                            >
                                Filtrlash
                            </button>
                            <button
                                onClick={handleResetFilters}
                                className="bg-gray-500 text-white px-2 py-1 rounded-md hover:bg-gray-600"
                            >
                                Tozalash
                            </button>
                            <button onClick={fetchAppealsExcel}
                                className="bg-green-500 text-white px-2 py-1 rounded-md hover:bg-green-600 flex gap-2">
                                <svg className="w-6 h-6 text-gray-800 dark:text-white" aria-hidden="true"
                                     xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none"
                                     viewBox="0 0 24 24">
                                    <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"
                                          stroke-width="2"
                                          d="M4 15v2a3 3 0 0 0 3 3h10a3 3 0 0 0 3-3v-2m-8 1V4m0 12-4-4m4 4 4-4"/>
                                </svg>Excel
                            </button>
                        </div>
                        <div>

                            <button onClick={() => setShowFilter(!showFilter)}
                                    className="bg-red-500 text-white px-2 py-1 rounded-md hover:bg-red-600">
                                {showFilter ?
                                    <svg className="w-6 h-6 text-gray-800 dark:text-white" aria-hidden="true"
                                         xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none"
                                         viewBox="0 0 24 24">
                                        <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"
                                              stroke-width="2" d="m5 15 7-7 7 7"/>
                                    </svg>
                                    :
                                    <svg className="w-6 h-6 text-gray-800 dark:text-white" aria-hidden="true"
                                         xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none"
                                         viewBox="0 0 24 24">
                                        <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"
                                              stroke-width="2" d="m19 9-7 7-7-7"/>
                                    </svg>


                                }


                            </button>


                        </div>
                    </div>
                </div>

                {/* Table Section */}
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