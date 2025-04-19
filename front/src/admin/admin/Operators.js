import React, { useEffect, useState } from 'react';
import Sidebar from "./Sidebar";
import { Modal } from "react-responsive-modal";
import ApiCall from "../../config";
import 'react-responsive-modal/styles.css';

function Operators() {
    const [agents, setAgents] = useState([]);
    const [isModalOpen, setIsModalOpen] = useState(false);
    const [agentData, setAgentData] = useState({ name: "", login: "", password: "" });
    const [editingAgentId, setEditingAgentId] = useState(null);

    useEffect(() => {
        fetchAgents();
    }, []);

    const fetchAgents = async () => {
        try {
            const response = await ApiCall('/api/v1/operator', 'GET', null, null, true);
            setAgents(response.data);
        } catch (error) {
            console.error("Error fetching agents:", error);
        }
    };

    const handleInputChange = (e) => {
        const { name, value } = e.target;
        setAgentData({ ...agentData, [name]: value });
    };

    const handleAddOrUpdateAgent = async () => {
        try {
            if (editingAgentId) {
                await ApiCall(`/api/v1/operator/${editingAgentId}`, 'PUT', agentData, null, true);
            } else {
                await ApiCall('/api/v1/operator', 'POST', agentData, null, true);
            }
            setIsModalOpen(false);
            setAgentData({ name: "", login: "", password: "" });
            setEditingAgentId(null);
            fetchAgents();
        } catch (error) {
            console.error("Error saving agent:", error);
        }
    };

    const handleEditAgent = (agent) => {
        setAgentData({ name: agent.name, login: agent.phone, password: "" });
        setEditingAgentId(agent.id);
        setIsModalOpen(true);
    };

    const handleDeleteAgent = async (id) => {
        try {
            await ApiCall(`/api/v1/operator/${id}`, 'DELETE', null, null, true);
            fetchAgents();
        } catch (error) {
            console.error("Error deleting agent:", error);
        }
    };

    return (
        <div>
            <Sidebar />
            <div className="p-10 sm:ml-64">
                <div className="flex justify-between items-center mb-4">
                    <h2 className="text-3xl md:text-4xl xl:text-5xl">Operatorlar</h2>
                    <button
                        className="bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600"
                        onClick={() => setIsModalOpen(true)}
                    >
                        Yangi agent qo'shish
                    </button>
                </div>

                <div className="mt-4">
                    <table className="min-w-full table-auto border-collapse border border-gray-300">
                        <thead>
                        <tr className="bg-gray-200">
                            <th className="border border-gray-300 px-4 py-2">N%</th>
                            <th className="border border-gray-300 px-4 py-2">Ism</th>
                            <th className="border border-gray-300 px-4 py-2">Telefon(Login)</th>
                            <th className="border border-gray-300 px-4 py-2">Amallar</th>
                        </tr>
                        </thead>
                        <tbody>
                        {agents.map((agent, index) => (
                            <tr key={agent.id} className="hover:bg-gray-100">
                                <td className="border border-gray-300 px-4 py-2 text-center">{index + 1}</td>
                                <td className="border border-gray-300 px-4 py-2">{agent.name}</td>
                                <td className="border border-gray-300 px-4 py-2">{agent.phone}</td>
                                <td className="border border-gray-300 px-4 py-2 flex gap-2 justify-center">
                                    <button
                                        className="bg-yellow-500 text-white px-3 py-1 rounded hover:bg-yellow-600"
                                        onClick={() => handleEditAgent(agent)}
                                    >
                                        Tahrirlash
                                    </button>
                                    <button
                                        className="bg-red-500 text-white px-3 py-1 rounded hover:bg-red-600"
                                        onClick={() => handleDeleteAgent(agent.id)}
                                    >
                                        O'chirish
                                    </button>
                                </td>
                            </tr>
                        ))}
                        </tbody>
                    </table>
                </div>

                <Modal open={isModalOpen} onClose={() => setIsModalOpen(false)} center>
                    <h2 className="text-2xl mb-4">{editingAgentId ? "Agentni tahrirlash" : "Yangi agent qo'shish"}</h2>
                    <div className="flex flex-col gap-4">
                        <input
                            type="text"
                            name="name"
                            placeholder="Ism"
                            value={agentData.name}
                            onChange={handleInputChange}
                            className="border border-gray-300 rounded px-4 py-2"
                        />
                        <input
                            type="text"
                            name="login"
                            placeholder="Telefon(Login)"
                            value={agentData.login}
                            onChange={handleInputChange}
                            className="border border-gray-300 rounded px-4 py-2"
                        />
                        <input
                            type="password"
                            name="password"
                            placeholder="Parol"
                            value={agentData.password}
                            onChange={handleInputChange}
                            className="border border-gray-300 rounded px-4 py-2"
                        />
                        <button
                            className="bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600"
                            onClick={handleAddOrUpdateAgent}
                        >
                            Saqlash
                        </button>
                    </div>
                </Modal>
            </div>
        </div>
    );
}

export default Operators;
