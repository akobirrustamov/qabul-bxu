import React, { useState, useEffect } from "react";
import Sidebar from "./Sidebar";
import ApiCall, { baseUrl } from "../../config";
import { Modal } from "react-responsive-modal";
import "react-responsive-modal/styles.css";
import {Link} from "react-router-dom";

function MyQRCode() {
    const [agents, setAgents] = useState([]);
    const [qrCodes, setQrCodes] = useState([]);
    const [isModalOpen, setIsModalOpen] = useState(false);
    const [formData, setFormData] = useState({
        agentID: "",
        type: 1, // 1 for Gold, 2 for Silver
        count: 1
    });
    const [isLoading, setIsLoading] = useState(false);

    useEffect(() => {
        fetchAgents();
        fetchQRCodes();
    }, []);

    const fetchAgents = async () => {
        try {
            const response = await ApiCall('/api/v1/agent', 'GET', null, null, true);
            // Extract the agent objects from the response
            const agentList = response.data.map(item => item.agent);
            setAgents(agentList);
        } catch (error) {
            console.error("Error fetching agents:", error);
        }
    };

    const fetchQRCodes = async () => {
        try {
            const response = await ApiCall('/api/v1/qr-code', 'GET', null, null, true);
            setQrCodes(response.data);
        } catch (error) {
            console.error("Error fetching QR codes:", error);
        }
    };

    const handleInputChange = (e) => {
        const { name, value } = e.target;
        setFormData(prev => ({
            ...prev,
            [name]: name === 'count' ? parseInt(value) || 0 : value
        }));
    };

    const handleSave = async () => {
        if (!formData.agentID || formData.count < 1) {
            alert("Please select an agent and enter a valid count");
            return;
        }

        setIsLoading(true);
        try {
            const response = await ApiCall('/api/v1/qr-code/new', 'POST', formData, null, true);
            alert(response.message || "QR codes generated successfully");
            setIsModalOpen(false);
            fetchQRCodes();
        } catch (error) {
            console.error("Error generating QR codes:", error);
            alert("Failed to generate QR codes");
        } finally {
            setIsLoading(false);
        }
    };

    const getTypeName = (type) => {
        return type === 1 ? "Gold" : "Silver";
    };

    const handleDownload = async (item) => {

        try {
            // Fetch the PDF from the server
            const response = await fetch(`${baseUrl}/api/v1/file/getFile/${item?.id}`, {
                method: 'GET',
                headers: {
                    'Content-Type': 'application/png',
                },
            });

            if (!response.ok) {
                throw new Error("Failed to download file");
            }

            // Convert response to blob
            const blob = await response.blob();

            // Create a temporary link to trigger download
            const downloadUrl = window.URL.createObjectURL(blob);
            const link = document.createElement('a');
            link.href = downloadUrl;
            link.download = `${item.name}`; // Change the name as desired
            document.body.appendChild(link);
            link.click();

            // Cleanup the link
            link.remove();
            window.URL.revokeObjectURL(downloadUrl);
        } catch (error) {
            console.error("Error downloading file:", error);
        }
    };

    return (
        <div className="p-6">
            <Sidebar />
            <div className="p-10 sm:ml-64">
                <div className="flex justify-between items-center mb-6">
                    <h1 className="text-2xl font-bold">QR Codes</h1>
                    <button
                        onClick={() => setIsModalOpen(true)}
                        className="bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600"
                    >
                        Create QR Code
                    </button>
                </div>

                <div className="overflow-x-auto">
                    <table className="min-w-full bg-white border border-gray-200">
                        <thead>
                        <tr className="bg-gray-100">
                            <th className="py-2 px-4 border-b">Serial Number</th>
                            <th className="py-2 px-4 border-b">Agent</th>
                            <th className="py-2 px-4 border-b">Type</th>
                            <th className="py-2 px-4 border-b">Created At</th>
                            <th className="py-2 px-4 border-b">Status</th>
                            <th className="py-2 px-4 border-b">Actions</th>
                        </tr>
                        </thead>
                        <tbody>
                        {qrCodes.length > 0 ? (
                            qrCodes.map((qrCode) => (
                                <tr key={qrCode.id} className="hover:bg-gray-50">
                                    <td className="py-2 px-4 border-b text-center">
                                        <Link to={`/card/${qrCode.id}`}>
                                            {qrCode.serialNumber}

                                        </Link>
                                    </td>
                                    <td className="py-2 px-4 border-b text-center">
                                        {qrCode.agent?.name}
                                    </td>
                                    <td className="py-2 px-4 border-b text-center">
                                            <span className={`px-2 py-1 rounded-full text-xs ${
                                                qrCode.type === 1
                                                    ? "bg-yellow-100 text-yellow-800"
                                                    : "bg-gray-100 text-gray-800"
                                            }`}>
                                                {getTypeName(qrCode.type)}
                                            </span>
                                    </td>
                                    <td className="py-2 px-4 border-b text-center">
                                        {new Date(qrCode.createdAt).toLocaleString()}
                                    </td>
                                    <td className="py-2 px-4 border-b text-center">
                                            <span className={`px-2 py-1 rounded-full text-xs ${
                                                qrCode.status
                                                    ? "bg-green-100 text-green-800"
                                                    : "bg-red-100 text-red-800"
                                            }`}>
                                                {qrCode.status ? "Active" : "Inactive"}
                                            </span>
                                    </td>
                                    <td className="py-2 px-4 border-b text-center">
                                        <button
                                            className="text-blue-500 hover:text-blue-700 mr-2" onClick={()=>handleDownload(qrCode.attachment)}>Download
                                        </button>
                                    </td>
                                </tr>
                            ))
                        ) : (
                            <tr>
                                <td colSpan="6" className="py-4 text-center text-gray-500">
                                    No QR codes found
                                </td>
                            </tr>
                        )}
                        </tbody>
                    </table>
                </div>
            </div>

            <Modal open={isModalOpen} onClose={() => setIsModalOpen(false)} center>
                <div className="p-4 w-full max-w-md">
                    <h2 className="text-xl font-semibold mb-4">Create QR Code</h2>

                    <div className="mb-4">
                        <label className="block text-gray-700 mb-2">Agent</label>
                        <select
                            name="agentID"
                            value={formData.agentID}
                            onChange={handleInputChange}
                            className="w-full p-2 border border-gray-300 rounded"
                            required
                        >
                            <option value="">Select Agent</option>
                            {agents.map(agent => (
                                <option key={agent.id} value={agent.id}>
                                    {agent.name}
                                </option>
                            ))}
                        </select>
                    </div>

                    <div className="mb-4">
                        <label className="block text-gray-700 mb-2">Type</label>
                        <select
                            name="type"
                            value={formData.type}
                            onChange={handleInputChange}
                            className="w-full p-2 border border-gray-300 rounded"
                        >
                            <option value={1}>Gold</option>
                            <option value={2}>Silver</option>
                        </select>
                    </div>

                    <div className="mb-6">
                        <label className="block text-gray-700 mb-2">Count</label>
                        <input
                            type="number"
                            name="count"
                            min="1"
                            max="100"
                            value={formData.count}
                            onChange={handleInputChange}
                            className="w-full p-2 border border-gray-300 rounded"
                            required
                        />
                    </div>

                    <div className="flex justify-end">
                        <button
                            className="bg-gray-300 text-gray-700 px-4 py-2 rounded mr-2 hover:bg-gray-400"
                            onClick={() => setIsModalOpen(false)}
                        >
                            Cancel
                        </button>
                        <button
                            className="bg-blue-500 text-white px-6 py-2 rounded hover:bg-blue-600 disabled:opacity-50"
                            onClick={handleSave}
                            disabled={isLoading}
                        >
                            {isLoading ? "Creating..." : "Create"}
                        </button>
                    </div>
                </div>
            </Modal>
        </div>
    );
}

export default MyQRCode;