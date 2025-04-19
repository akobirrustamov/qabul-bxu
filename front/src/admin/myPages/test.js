import React, { useEffect, useState } from "react";
import Sidebar from "./Sidebar";
import ApiCall from "../../config";
import "react-responsive-modal/styles.css";
import { Modal } from "react-responsive-modal";

function Appeals() {
    const [appeals, setAppeals] = useState([]);
    const [editModalOpen, setEditModalOpen] = useState(false);
    const [appealType, setAppealType] = useState([]);
    const [educationType, setEducationType] = useState([]);
    const [educationForm, setEducationForm] = useState([]);
    const [educationField, setEducationField] = useState([]);

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

    }, []);

    const fetchAppeals = async () => {
        try {
            const response = await ApiCall(`/api/v1/admin/appeals`, "GET", null, null, true);
            setAppeals(response.data);
        } catch (error) {
            console.error("Error fetching appeals:", error);
        }
    };

    const fetchAppealType = async () => {
        try {
            const response = await ApiCall(`/api/v1/appeal-type`, "GET", null, null, true);
            setAppealType(response.data);

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

    const handleEditClick = (appeal) => {
        fetchEducationForm(appeal.educationField.educationForm.educationType?.id);
        fetchEducationField(appeal.educationField.educationForm?.id);
        setEditData({
            id: appeal.id,
            passportPin: appeal.passportPin || "",
            passportNumber: appeal.passportNumber || "",
            firstName: appeal.firstName || "",
            lastName: appeal.lastName || "",
            fatherName: appeal.fatherName || "",
            appealTypeId: appeal.appealType?.id || "",
            educationTypeId: appeal.educationField.educationForm.educationType?.id || "",
            educationFormId: appeal.educationField.educationForm?.id || "",
            educationFieldId: appeal.educationField?.id || "",
        });
        setEditModalOpen(true);
    };

    const handleInputChange = (e) => {
        const { name, value } = e.target;

        if (name === "passportPin") {
            const numericValue = value.replace(/\D/g, ""); // Remove non-numeric characters
            if (numericValue.length <= 14) {
                setEditData((prev) => ({ ...prev, [name]: numericValue }));
            }
            return;
        }
        // Validate Passport Number (2 capital letters + 9 digits)
        if (name === "passportNumber") {
            const formattedValue = value.toUpperCase(); // Convert to uppercase
            const letters = formattedValue.slice(0, 2).replace(/[^A-Z]/g, ""); // First 2 capital letters
            const numbers = formattedValue.slice(2).replace(/\D/g, ""); // Remaining numeric characters
            const passportNumber = `${letters}${numbers.slice(0, 7)}`; // Combine letters and up to 9 numbers
            setEditData((prev) => ({ ...prev, [name]: passportNumber }));
            return;
        }
        // General fields
        else {
            setEditData((prev) => ({ ...prev, [name]: value }));
            if (name === "educationTypeId") fetchEducationForm(value);
            if (name === "educationFormId") fetchEducationField(value);
        }
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
            alert("Please ensure all fields are correctly filled.");
            return false;
        }
        return true;
    };

    const handleEditSubmit = async () => {
        if (!validateInputs()) return;

        try {
            await ApiCall(`/api/v1/admin/appeals/${editData.id}`, "PUT", editData, null, true);
            setEditModalOpen(false);
            fetchAppeals(); // Refresh appeals
        } catch (error) {
            console.error("Error updating appeal:", error);
        }
    };

    const getEducationForm = async (id) => {
        try {
            const response = await ApiCall(`/api/v1/education-form/${id}`, "GET", null, null, true);
            setEducationForm(response.data);
        } catch (error) {
            console.error("Error fetching education forms:", error);
        }
    };

    const getEducationField = async (id) => {
        try {
            const response = await ApiCall(`/api/v1/education-field/${id}`, "GET", null, null, true);
            setEducationField(response.data);
        } catch (error) {
            console.error("Error fetching education fields:", error);
        }
    };


    return (
        <div>
            <Sidebar />
            <div className="p-10 sm:ml-64">
                <h2 className="text-3xl">Kelib tushgan arizalar</h2>
                <table className="min-w-full mt-4">
                    <thead>
                    <tr>
                        {/* Table Headers */}
                        <th>N%</th>
                        <th>FIO</th>
                        <th>Passport</th>
                        <th>Phone</th>
                        <th>Appeal Type</th>
                        <th>Education Field</th>
                        <th>Agent</th>
                        <th>Date</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    {appeals.map((appeal, index) => (
                        <tr key={index}>
                            <td>{index + 1}</td>
                            <td>{`${appeal.lastName} ${appeal.firstName} ${appeal.fatherName}`}</td>
                            <td>{`${appeal.passportPin}, ${appeal.passportNumber}`}</td>
                            <td>{appeal.phone}</td>
                            <td>{appeal.appealType?.name}</td>
                            <td>{appeal.educationField?.name}</td>
                            <td>{appeal.agent?.name}</td>
                            <td>{new Date(appeal.createdAt).toLocaleString()}</td>
                            <td>{appeal.status}</td>
                            <td>
                                <button onClick={() => handleEditClick(appeal)}>Edit</button>
                            </td>
                        </tr>
                    ))}
                    </tbody>
                </table>


                <Modal
                    open={editModalOpen}
                    onClose={() => setEditModalOpen(false)}
                    animationDuration={700}
                    center
                >
                    <h2>Tahrirlash</h2>
                    <div
                        className="flex flex-col"
                        style={{
                            width: "500px",
                            height: "400px",
                        }}
                    >
                        <form>
                            <div>
                                <div className="m-4">
                                    <label className={"text-gray-500 mt-1 "}>JSHR</label>

                                    <input
                                        type="text"
                                        name="passportPin"
                                        placeholder="Passport Pin (14 digits)"
                                        value={editData.passportPin}
                                        onChange={handleInputChange}
                                        className="border border-gray-300 rounded p-2"
                                        required
                                    />

                                    <label className={"text-gray-500 mt-1 "}>Passport raqami</label>

                                    <input
                                        type="text"
                                        name="passportNumber"
                                        placeholder="Passport Number (e.g., AB123456789)"
                                        value={editData.passportNumber}
                                        onChange={handleInputChange}
                                        className="border border-gray-300 rounded p-2"
                                        required
                                    />

                                    <label className="block">Familiya</label>
                                    <input
                                        type="text"
                                        name="lastName"
                                        value={editData.lastName}
                                        onChange={handleInputChange}
                                        className="border-2 rounded w-full"
                                        required
                                    />
                                </div>
                                <div className="m-4">
                                    <label className="block">Ism</label>
                                    <input
                                        type="text"
                                        name="firstName"
                                        value={editData.firstName}
                                        onChange={handleInputChange}
                                        className="border-2 rounded w-full"
                                        required
                                    />
                                </div>
                                <div className="m-4">
                                    <label className="block">Sharifi</label>
                                    <input
                                        type="text"
                                        name="fatherName"
                                        value={editData.fatherName}
                                        onChange={handleInputChange}
                                        className="border-2 rounded w-full"
                                        required
                                    />
                                </div>
                                <div className="m-4">
                                    <label>Ariza turi</label>
                                    <select
                                        name="appealTypeId"
                                        value={editData.appealTypeId || ""}
                                        onChange={handleInputChange}
                                        className="border-2 rounded w-full"
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
                                <div className="m-4">
                                    <label>Ta'lim turi</label>
                                    <select
                                        name="educationTypeId"
                                        value={editData?.educationTypeId || ""}
                                        onChange={(e) => getEducationForm(e.target.value)}
                                        className="border-2 rounded w-full"
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
                                <div className="m-4">
                                    <label>Ta'lim shakli</label>
                                    <select
                                        name="educationFormId"
                                        value={editData.educationFormId || ""}
                                        onChange={(e) => getEducationField(e.target.value)}
                                        className="border-2 rounded w-full"
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
                                <div className="m-4">
                                    <label>Yo'nalish</label>
                                    <select
                                        name="educationFieldId"
                                        value={editData.educationFieldId || ""}
                                        onChange={handleInputChange}
                                        className="border-2 rounded w-full"
                                        required
                                    >
                                        <option value="">Yo'nalishni tanlang</option>
                                        {educationField.map((item) => (
                                            <option key={item.id} value={item.id}>
                                                {item.name}
                                            </option>
                                        ))}
                                    </select>
                                </div>
                                <div className="m-4">
                                    <button
                                        type="button"
                                        onClick={handleEditSubmit}
                                        className="p-2 bg-green-600 rounded text-white"
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
