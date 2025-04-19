import React, { useEffect, useState } from 'react';
import Sidebar from "./Sidebar";
import { Modal } from "react-responsive-modal";
import ApiCall from "../../config";
import 'react-responsive-modal/styles.css';

function OperatorsAndAgents() {
        const [agents, setAgents] = useState([]);
    const [operators, setOperators] = useState([]);
    const [isModalOpen, setIsModalOpen] = useState(false);
    const [isEditingAgent, setIsEditingAgent] = useState(false);
    const [editingId, setEditingId] = useState(null);
    const [modalType, setModalType] = useState("agent");
    const [formData, setFormData] = useState({ name: "", login: "", password: "" });
    const [isConfirmationModalOpen, setIsConfirmationModalOpen] = useState(false);
    const [confirmationDetails, setConfirmationDetails] = useState({});

        useEffect(() => {
            fetchAgents();
            fetchOperators();
        }, []);

    const fetchAgents = async () => {
        try {
            const response = await ApiCall('/api/v1/agent', 'GET', null, null, true);
            setAgents(response.data);
        } catch (error) {
            console.error("Error fetching agents:", error);
        }
    };

    const fetchOperators = async () => {
        try {
            const response = await ApiCall('/api/v1/operator', 'GET', null, null, true);
            setOperators(response.data);
        } catch (error) {
            console.error("Error fetching operators:", error);
        }
    };

    const handleInputChange = (e) => {
        const { name, value } = e.target;
        setFormData({ ...formData, [name]: value });
    };

    const handleSave = async () => {
        try {
            const url = modalType === "agent" ? "/api/v1/agent" : "/api/v1/operator";
            const updateUrl = `${url}/${editingId}`;

            if (editingId) {
                // Update existing record
                await ApiCall(updateUrl, 'PUT', formData, null, true);
            } else {
                // Create new record
                await ApiCall(url, 'POST', formData, null, true);
            }

            setIsModalOpen(false);
            setFormData({ name: "", login: "", password: "" });
            setEditingId(null);


               await fetchAgents();

               await fetchOperators();

        } catch (error) {
            console.error("Error saving record:", error);
        }
    };

    const handleEdit = (record, type) => {
        setModalType(type);
        setFormData({ name: record.name, login: record.phone || record.login, password: "" });
        setEditingId(record.id);
        setIsModalOpen(true);
    };

    const handleDelete = async (id, type) => {
        try {
            const url = type === "agent" ? `/api/v1/agent/${id}` : `/api/v1/operator/${id}`;
            await ApiCall(url, 'DELETE', null, null, true);

            if (type === "agent") {
                fetchAgents();
            } else {
                fetchOperators();
            }
        } catch (error) {
            console.error("Error deleting record:", error);
        }
    };

    const openAddModal = (type) => {
        setModalType(type);
        setFormData({ name: "", login: "", password: "" });
        setEditingId(null);
        setIsModalOpen(true);
    };

    const handleStatusStaff = async (id, isChecked, type, name) => {
        setConfirmationDetails({ id, isChecked, type, name });
        setIsConfirmationModalOpen(true);
    };

    const confirmStatusChange = async (confirm) => {
        if (!confirm) {
            setIsConfirmationModalOpen(false);
            return;
        }

        try {
            const { id, isChecked, type } = confirmationDetails;
            const url = type === "agent"
                ? `/api/v1/admin/status/${id}`
                : `/api/v1/admin/status/${id}`;

            const payload = { active: isChecked };
            await ApiCall(url, 'PUT', payload, null, true);

            if (type === "agent") {
                fetchAgents();
            } else {
                fetchOperators();
            }
        } catch (error) {
            console.error(`Error updating status for ${confirmationDetails.name}:`, error);
        } finally {
            setIsConfirmationModalOpen(false); // Close the confirmation modal
        }
    };





    const isBotAgent = (phone) => /^[0-9]+$/.test(phone);

    const botAgents = agents.filter(agent => isBotAgent(agent?.agent?.phone));
    const siteAgents = agents.filter(agent => !isBotAgent(agent?.agent?.phone));

    const renderAgentTable = (title, agentList) => (
        <div className="mb-10">
            <h3 className="text-xl font-semibold mb-2">{title}</h3>
            <table className="min-w-full table-auto border-collapse border border-gray-300">
                <thead>
                <tr className="bg-gray-200">
                    <th className="border border-gray-300 px-4 py-2">N%</th>
                    <th className="border border-gray-300 px-4 py-2">Ism</th>
                    <th className="border border-gray-300 px-4 py-2">Telefon(Login)</th>
                    <th className="border border-gray-300 px-4 py-2">Havola</th>
                    <th className="border border-gray-300 px-4 py-2">Amallar</th>
                </tr>
                </thead>
                <tbody>
                {agentList.map((agent, index) => (
                    <tr key={agent.id} className="hover:bg-gray-100">
                        <td className="border border-gray-300 px-4 py-2 text-center">{index + 1}</td>
                        <td className="border border-gray-300 px-4 py-2">{agent?.agent?.name}</td>
                        <td className="border border-gray-300 px-4 py-2">{agent?.agent?.phone}</td>
                        <td className="border border-gray-300 px-4 py-2">https://qabul.bxu.uz/{agent.agentNumber}</td>
                        <td className="border border-gray-300 px-4 py-2 flex gap-2 justify-center">
                            <button
                                className="bg-yellow-500 text-white px-3 py-1 rounded hover:bg-yellow-600"
                                onClick={() => handleEdit(agent?.agent)}
                            >
                                Tahrirlash
                            </button>
                            {/*<button
                            className="bg-red-500 text-white px-3 py-1 rounded hover:bg-red-600"
                            onClick={() => handleDeleteAgent(agent.agent.id)}
                        >
                            O'chirish
                        </button>*/}
                        </td>
                    </tr>
                ))}
                </tbody>
            </table>
        </div>
    );




    return (
        <div>
            <Sidebar />
            <div className="p-10 sm:ml-64">
                {/* Agents Section */}
                <div>
                    <div className="flex justify-between items-center mb-4">
                        <h2 className="text-3xl md:text-4xl xl:text-5xl">Agents</h2>
                        <button
                            className="bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600"
                            onClick={() => openAddModal("agent")}
                        >
                            Add Agent
                        </button>
                    </div>

                    <div className="mt-4">
                        {renderAgentTable("🧑‍💻 Sayt orqali tayinlangan agentlar", siteAgents)}
                        {renderAgentTable("🤖 Bot orqali tayinlangan agentlar", botAgents)}
                    </div>
                </div>

                {/* Operators Section */}
                <div className="mt-10">
                    <div className="flex justify-between items-center mb-4">
                        <h2 className="text-3xl md:text-4xl xl:text-5xl">Operators</h2>
                        <button
                            className="bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600"
                            onClick={() => openAddModal("operator")}
                        >
                            Add Operator
                        </button>
                    </div>

                    <table className="min-w-full table-auto border-collapse border border-gray-300">
                        <thead>
                        <tr className="bg-gray-200">
                            <th className="border border-gray-300 px-4 py-2">#</th>
                            <th className="border border-gray-300 px-4 py-2">Name</th>
                            <th className="border border-gray-300 px-4 py-2">Phone</th>
                            <th className="border border-gray-300 px-4 py-2">Malumot kiritish</th>
                            <th className="border border-gray-300 px-4 py-2">Actions</th>
                        </tr>
                        </thead>
                        <tbody>
                        {operators.map((operator, index) => (
                            <tr key={operator.id} className="hover:bg-gray-100">
                                <td className="border border-gray-300 px-4 py-2 text-center">{index + 1}</td>
                                <td className="border border-gray-300 px-4 py-2">{operator.name}</td>
                                <td className="border border-gray-300 px-4 py-2">{operator.phone}</td>
                                <td className="border border-gray-300 px-4 py-2">
                                    <input
                                        type="checkbox"
                                        checked={operator.roles.some(item => item.name === "ROLE_DATA_MANAGER")}
                                        onChange={(e) => handleStatusStaff(operator.id, e.target.checked, "operator", operator.name)}
                                    />
                                </td>
                                <td className="border border-gray-300 px-4 py-2 flex gap-2 justify-center">
                                    <button
                                        className="bg-yellow-500 text-white px-3 py-1 rounded hover:bg-yellow-600"
                                        onClick={() => handleEdit(operator, "operator")}
                                    >
                                        Edit
                                    </button>
                                    <button
                                        className="bg-red-500 text-white px-3 py-1 rounded hover:bg-red-600"
                                        onClick={() => handleDelete(operator.id, "operator")}
                                    >
                                        Delete
                                    </button>
                                </td>
                            </tr>
                        ))}
                        </tbody>
                    </table>
                </div>


                <Modal open={isModalOpen} onClose={() => setIsModalOpen(false)} center>
                    <div>
                        <h2 className="text-xl mb-4">{isEditingAgent ? "Edit" : "Add"} {modalType === "agent" ? "Agent" : "Operator"}</h2>
                        <div className="mb-4">
                            <label className="block mb-2">Name</label>
                            <input
                                type="text"
                                name="name"
                                value={formData.name}
                                onChange={handleInputChange}
                                className="w-full border border-gray-300 p-2"
                            />
                        </div>
                        <div className="mb-4">
                            <label className="block mb-2">Login</label>
                            <input
                                type="text"
                                name="login"
                                value={formData.login}
                                onChange={handleInputChange}
                                className="w-full border border-gray-300 p-2"
                            />
                        </div>
                        <div className="mb-4">
                            <label className="block mb-2">Password</label>
                            <input
                                type="password"
                                name="password"
                                value={formData.password}
                                onChange={handleInputChange}
                                className="w-full border border-gray-300 p-2"
                            />
                        </div>
                        <button
                            className="bg-blue-500 text-white px-6 py-2 rounded hover:bg-blue-600"
                            onClick={handleSave}
                        >
                            Save
                        </button>
                    </div>
                </Modal>


                <Modal open={isConfirmationModalOpen} onClose={() => setIsConfirmationModalOpen(false)} center>
                    <div>
                        <h2 className="text-xl mb-4 pr-4"> {confirmationDetails?.name?.toUpperCase()} ning statusini rostdan  ham o'zgartirmoqchimisiz?</h2>
                        <div className="flex justify-between gap-4">
                            <button
                                className="bg-red-500 text-white px-6 py-2 rounded hover:bg-red-600"
                                onClick={() => confirmStatusChange(false)}
                            >
                                No
                            </button>
                            <button
                                className="bg-green-500 text-white px-6 py-2 rounded hover:bg-green-600"
                                onClick={() => confirmStatusChange(true)}
                            >
                                Yes
                            </button>
                        </div>
                    </div>
                </Modal>
            </div>
        </div>
    );
}

export default OperatorsAndAgents;
