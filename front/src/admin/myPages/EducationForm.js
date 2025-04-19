import React, { useState, useEffect } from "react";
import ApiCall from "../../config";
import Sidebar from "./Sidebar";
import { Modal } from "react-responsive-modal";
import "react-responsive-modal/styles.css";

const EducationForm = () => {
    const [educationForms, setEducationForms] = useState([]);
    const [educationTypes, setEducationTypes] = useState([]);
    const [isModalOpen, setIsModalOpen] = useState(false);
    const [formValues, setFormValues] = useState({
        id: null,
        name: "",
        educationTypeId: "",
        isActive: true,
    });

    useEffect(() => {
        fetchEducationForms();
        fetchEducationTypes();
    }, []);


    const fetchEducationForms = async () => {
        try {
            const response = await ApiCall("/api/v1/education-form", "GET", null, null, true);
            setEducationForms(response.data);
        } catch (error) {
            console.error("Error fetching education forms:", error);
        }
    };

    const fetchEducationTypes = async () => {
        try {
            const response = await ApiCall("/api/v1/education-type", "GET", null, null, true);
            setEducationTypes(response.data);
        } catch (error) {
            console.error("Error fetching education types:", error);
        }
    };

    const handleInputChange = (e) => {
        const { name, value } = e.target;
        setFormValues({ ...formValues, [name]: value });
    };

    const handleFormSubmit = async () => {
        try {
            if (formValues.id) {
                // Update existing form
                await ApiCall(`/api/v1/education-form/${formValues.id}`, "PUT", formValues, null, true);
            } else {
                // Add new form
                await ApiCall("/api/v1/education-form", "POST", formValues, null, true);
            }
            fetchEducationForms();
            setIsModalOpen(false);
            resetFormValues();
        } catch (error) {
            console.error("Error saving education form:", error);
        }
    };

    const handleEdit = (form) => {
        setFormValues({
            id: form.id,
            name: form.name,
            educationTypeId: form.educationType.id,
            isActive: form.isActive,
        });
        setIsModalOpen(true);
    };

    const handleDelete = async (id) => {
        try {
            await ApiCall(`/api/v1/education-form/${id}`, "DELETE", null, null, true);
            fetchEducationForms();
        } catch (error) {
            console.error("Error deleting education form:", error);
        }
    };

    const resetFormValues = () => {
        setFormValues({
            id: null,
            name: "",
            educationTypeId: "",
            isActive: true,
        });
    };

    return (
        <div>
            <Sidebar />
            <div className="p-10 sm:ml-64">
                <div className="flex justify-between items-center">
                    <h2 className="text-xl text-gray-800 md:text-2xl xl:text-3xl">
                        Ta'lim shakllari
                    </h2>
                    <button
                        className="bg-blue-500 text-white px-4 py-2 rounded"
                        onClick={() => setIsModalOpen(true)}
                    >
                        Add New
                    </button>
                </div>

                <div className="mt-6">
                    <table className="min-w-full table-auto border-collapse border border-gray-300">
                        <thead>
                        <tr className="bg-gray-200">
                            <th className="border border-gray-300 px-4 py-2">N%</th>
                            <th className="border border-gray-300 px-4 py-2">Name</th>
                            <th className="border border-gray-300 px-4 py-2">Education Type</th>
                            <th className="border border-gray-300 px-4 py-2">Is Active</th>
                            <th className="border border-gray-300 px-4 py-2">Actions</th>
                        </tr>
                        </thead>
                        <tbody>
                        {educationForms.map((form, index) => (
                            <tr key={form.id}>
                                <td className="border border-gray-300 px-4 py-2">{index + 1}</td>
                                <td className="border border-gray-300 px-4 py-2">{form.name}</td>
                                <td className="border border-gray-300 px-4 py-2">
                                    {form.educationType.name}
                                </td>
                                <td className="border border-gray-300 px-4 py-2">
                                    {form.isActive ? "Yes" : "No"}
                                </td>
                                <td className="border border-gray-300 px-4 py-2">
                                    <button
                                        className="bg-yellow-500 text-white px-2 py-1 rounded mr-2"
                                        onClick={() => handleEdit(form)}
                                    >
                                        Edit
                                    </button>
                                    <button
                                        className="bg-red-500 text-white px-2 py-1 rounded"
                                        onClick={() => handleDelete(form.id)}
                                    >
                                        Delete
                                    </button>
                                </td>
                            </tr>
                        ))}
                        </tbody>
                    </table>
                </div>
            </div>


            <Modal open={isModalOpen} onClose={() => setIsModalOpen(false)} center >
                <h2 className="text-xl mb-4">Add / Edit Education Form</h2>
                <div className="flex flex-col space-y-4">
                    <input
                        type="text"
                        name="name"
                        value={formValues.name}
                        onChange={handleInputChange}
                        placeholder="Name"
                        className="border border-gray-300 px-4 py-2 rounded"
                    />
                    <select
                        name="educationTypeId"
                        value={formValues.educationTypeId}
                        onChange={handleInputChange}
                        className="border border-gray-300 px-4 py-2 rounded"
                    >
                        <option value="" disabled>
                            Select Education Type
                        </option>
                        {educationTypes.map((type) => (
                            <option key={type.id} value={type.id}>
                                {type.name}
                            </option>
                        ))}
                    </select>
                    <div className="flex items-center space-x-2">
                        <label>Is Active</label>
                        <input
                            type="checkbox"
                            name="isActive"
                            checked={formValues.isActive}
                            onChange={(e) =>
                                setFormValues({ ...formValues, isActive: e.target.checked })
                            }
                        />
                    </div>
                    <button
                        className="bg-blue-500 text-white px-4 py-2 rounded"
                        onClick={handleFormSubmit}
                    >
                        Save
                    </button>
                </div>
            </Modal>
        </div>
    );
};

export default EducationForm;
