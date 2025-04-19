import React, { useState, useEffect } from 'react';
import ApiCall from "../../config"; // Import your API call utility
import Sidebar from "./Sidebar";
import { Modal } from "react-responsive-modal";
import 'react-responsive-modal/styles.css';

const EducationType = () => {
    const [educationTypes, setEducationTypes] = useState([]);
    const [isModalOpen, setIsModalOpen] = useState(false);
    const [formData, setFormData] = useState({ id: null, name: "", isActive: true });
    const [isEditMode, setIsEditMode] = useState(false);

    useEffect(() => {
        fetchEducationTypes();
    }, []);

    const fetchEducationTypes = async () => {
        try {
            const response = await ApiCall('/api/v1/education-type', 'GET', null, null, true);
            setEducationTypes(response.data);
        } catch (error) {
            console.error("Error fetching education types:", error);
        }
    };

    const handleOpenModal = (educationType = { id: null, name: "", isActive: true }) => {
        setFormData(educationType);
        setIsEditMode(!!educationType.id);
        setIsModalOpen(true);
    };

    const handleCloseModal = () => {
        setIsModalOpen(false);
        setFormData({ id: null, name: "", isActive: true });
    };

    const handleInputChange = (e) => {
        const { name, value } = e.target;
        setFormData({ ...formData, [name]: value });
    };

    const handleSave = async () => {
        try {
            if (isEditMode) {
                // Update EducationType
                await ApiCall(`/api/v1/education-type/${formData.id}`, 'PUT', formData, null, true);
            } else {
                // Add new EducationType
                await ApiCall('/api/v1/education-type', 'POST', formData, null, true);
            }
            fetchEducationTypes();
            handleCloseModal();
        } catch (error) {
            console.error("Error saving education type:", error);
        }
    };

    const handleDelete = async (id) => {
        if (window.confirm("Are you sure you want to delete this education type?")) {
            try {
                await ApiCall(`/api/v1/education-type/${id}`, 'DELETE', null, null, true);
                fetchEducationTypes();
            } catch (error) {
                console.error("Error deleting education type:", error);
            }
        }
    };

    return (
        <div>
            <Sidebar />
            <div className="p-10 sm:ml-64">
                <h2 className="text-3xl md:text-4xl xl:text-5xl mb-6">Education Types</h2>

                <button
                    className="bg-blue-500 text-white px-4 py-2 rounded mb-4"
                    onClick={() => handleOpenModal()}
                >
                    Add New
                </button>

                <table className="min-w-full table-auto border-collapse border border-gray-300">
                    <thead>
                    <tr className="bg-gray-200">
                        <th className="border border-gray-300 px-4 py-2">#</th>
                        <th className="border border-gray-300 px-4 py-2">Name</th>
                        <th className="border border-gray-300 px-4 py-2">Active</th>
                        <th className="border border-gray-300 px-4 py-2">Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    {educationTypes?.map((type, index) => (
                        <tr key={type.id}>
                            <td className="border border-gray-300 px-4 py-2">{index + 1}</td>
                            <td className="border border-gray-300 px-4 py-2">{type.name}</td>
                            <td className="border border-gray-300 px-4 py-2">{type.isActive ? "Yes" : "No"}</td>
                            <td className="border border-gray-300 px-4 py-2">
                                <button
                                    className="bg-yellow-500 text-white px-2 py-1 rounded mr-2"
                                    onClick={() => handleOpenModal(type)}
                                >
                                    Edit
                                </button>
                                <button
                                    className="bg-red-500 text-white px-2 py-1 rounded"
                                    onClick={() => handleDelete(type.id)}
                                >
                                    Delete
                                </button>
                            </td>
                        </tr>
                    ))}
                    </tbody>
                </table>
            </div>


            <Modal open={isModalOpen} onClose={handleCloseModal} center>
                <h2>{isEditMode ? "Edit Education Type" : "Add Education Type"}</h2>
                <div className="mt-4">
                    <label className="block mb-2">Name</label>
                    <input
                        type="text"
                        name="name"
                        value={formData.name}
                        onChange={handleInputChange}
                        className="w-full border border-gray-300 rounded px-4 py-2 mb-4"
                        placeholder="Enter education type name"
                    />
                    <label className="block mb-2">Active</label>
                    <select
                        name="isActive"
                        value={formData.isActive}
                        onChange={handleInputChange}
                        className="w-full border border-gray-300 rounded px-4 py-2"
                    >
                        <option value={true}>Yes</option>
                        <option value={false}>No</option>
                    </select>
                </div>
                <div className="mt-4">
                    <button
                        className="bg-blue-500 text-white px-4 py-2 rounded mr-2"
                        onClick={handleSave}
                    >
                        Save
                    </button>
                    <button
                        className="bg-gray-500 text-white px-4 py-2 rounded"
                        onClick={handleCloseModal}
                    >
                        Cancel
                    </button>
                </div>
            </Modal>
        </div>
    );
};

export default EducationType;
