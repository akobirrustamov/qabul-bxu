import React, { useState, useEffect } from 'react';
import ApiCall from "../../config";
import Sidebar from "./Sidebar";
import {
    LineChart,
    Line,
    CartesianGrid,
    XAxis,
    YAxis,
    Tooltip,
    ResponsiveContainer,
} from 'recharts';
import * as XLSX from "xlsx";
import jsPDF from "jspdf";
import "jspdf-autotable";
import Select from 'react-select';

const AdminHome = () => {
    const [statistics, setStatistics] = useState([]);
    const [dailyStats, setDailyStats] = useState([]);
    const [sortOrder, setSortOrder] = useState("desc");
    const [loading, setLoading] = useState(false);
    const [agentDailyStats, setAgentDailyStats] = useState([]);
    const [selectedAgent, setSelectedAgent] = useState("");

    useEffect(() => {
        fetchStatistics();
        fetchDailyStats();
        fetchAgentDailyStats(selectedAgent);
    }, [sortOrder, selectedAgent]);

    const fetchAgentDailyStats = async (agentPhone = "all") => {
        try {
            const response = await ApiCall('/api/v1/agent/daily-agent-statistic', 'GET', null, null, true);
            const allData = response.data;

            if (agentPhone === "all") {
                setAgentDailyStats(allData);
            } else {
                const filtered = allData.filter(agent => agent.phone === agentPhone);
                setAgentDailyStats(filtered);
            }
        } catch (error) {
            console.error("Error fetching agent daily stats:", error);
        }
    };


    const fetchStatistics = async () => {
        setLoading(true);
        try {
            const response = await ApiCall('/api/v1/agent/statistic', 'GET', null, null, true);
            setStatistics(response.data);
        } catch (error) {
            console.error("Error fetching statistics:", error);
        }
        setLoading(false);
    };

    const fetchDailyStats = async () => {
        try {
            const response = await ApiCall('/api/v1/agent/daily-statistic', 'GET', null, null, true);
            const formatted = Object.entries(response.data).map(([date, count]) => ({
                date,
                count,
            }));

            const sorted = formatted.sort((a, b) => {
                const dateA = new Date(a.date);
                const dateB = new Date(b.date);
                return sortOrder === "asc" ? dateA - dateB : dateB - dateA;
            });

            setDailyStats(sorted);
        } catch (error) {
            console.error("Error fetching daily stats:", error);
        }
    };
    const agentOptions = statistics.map((agent) => ({
        value: agent.phone,
        label: `${agent.name} (${agent.phone})`,
    }));



    const handleSortChange = (e) => {
        setSortOrder(e.target.value);
    };

    const exportToExcel = () => {
        const ws = XLSX.utils.json_to_sheet(dailyStats);
        const wb = XLSX.utils.book_new();
        XLSX.utils.book_append_sheet(wb, ws, "Kunlik Statistikalar");
        XLSX.writeFile(wb, "daily_statistics.xlsx");
    };

    const exportToPDF = () => {
        const doc = new jsPDF();
        doc.setFontSize(14);
        doc.text("📊 Kunlik ro'yxatdan o'tish statistikasi", 14, 20);

        const tableData = dailyStats.map((entry) => [entry.date, entry.count]);

        doc.autoTable({
            startY: 30,
            head: [["Sana", "Ro'yxatdan o'tganlar soni"]],
            body: tableData,
        });

        doc.save("daily_statistics.pdf");
    };

    const exportAgentsToExcel = (agents, filename) => {
        if (agents.length === 0) return;

        const formatted = agents.map((agent, index) => ({
            "#": index + 1,
            "Agent nomi": agent.name,
            "Telefon raqam": agent.phone,
            "Abituriyentlar soni": agent.count,
        }));

        const ws = XLSX.utils.json_to_sheet(formatted);
        const wb = XLSX.utils.book_new();
        XLSX.utils.book_append_sheet(wb, ws, "Agentlar");
        XLSX.writeFile(wb, filename);
    };

    const totalCount = statistics.reduce((sum, agent) => sum + agent.count, 0);
    const isBotAgent = (phone) => /^[0-9]+$/.test(phone);
    const botAgents = statistics.filter(agent => isBotAgent(agent.phone));
    const siteAgents = statistics.filter(agent => !isBotAgent(agent.phone));

    const renderTable = (title, agents) => (
        <div className="bg-white rounded-lg shadow-md p-6 mb-6">
            {title && <h2 className="text-xl font-semibold mb-4">{title}</h2>}
            {agents.length === 0 ? (
                <p className="text-gray-500">Ma'lumot topilmadi</p>
            ) : (
                <table className="min-w-full table-auto border-collapse border border-gray-300">
                    <thead className="bg-gray-100">
                    <tr>
                        <th className="border border-gray-300 px-4 py-2 text-left">Agent nomi</th>
                        <th className="border border-gray-300 px-4 py-2 text-left">Telefon raqam</th>
                        <th className="border border-gray-300 px-4 py-2 text-left">Abituriyentlar soni</th>
                    </tr>
                    </thead>
                    <tbody>
                    {agents.map((agent, index) => (
                        <tr key={index} className="hover:bg-gray-50">
                            <td className="border border-gray-300 px-4 py-2">{agent.name}</td>
                            <td className="border border-gray-300 px-4 py-2">{agent.phone}</td>
                            <td className="border border-gray-300 px-4 py-2">{agent.count}</td>
                        </tr>
                    ))}
                    </tbody>
                </table>
            )}
        </div>
    );

    const renderDailyStatsTable = () => (
        <div className="bg-white rounded-lg shadow-md p-6 mb-6">
            <h2 className="text-xl font-semibold mb-4">📊 Kunlik ro'yxatdan o'tish jadvali</h2>
            {dailyStats.length === 0 ? (
                <p className="text-gray-500">Ma'lumot topilmadi</p>
            ) : (
                <table className="min-w-full table-auto border-collapse border border-gray-300">
                    <thead className="bg-gray-100">
                    <tr>
                        <th className="border border-gray-300 px-4 py-2 text-left">Sana</th>
                        <th className="border border-gray-300 px-4 py-2 text-left">Ro'yxatdan o'tganlar soni</th>
                    </tr>
                    </thead>
                    <tbody>
                    {dailyStats.map((entry, index) => (
                        <tr key={index} className="hover:bg-gray-50">
                            <td className="border border-gray-300 px-4 py-2">{entry.date}</td>
                            <td className="border border-gray-300 px-4 py-2">{entry.count}</td>
                        </tr>
                    ))}
                    </tbody>
                </table>
            )}
        </div>
    );
    const exportAgentDailyStatsToExcel = () => {
        if (agentDailyStats.length === 0) return;

        const flattened = agentDailyStats.flatMap((agent) => {
            const daily = agent.daily || {};
            return Object.entries(daily).map(([date, count]) => ({
                "Agent nomi": agent.name,
                "Telefon raqam": agent.phone,
                "Sana": date,
                "Ro'yxatdan o'tganlar": count,
            }));
        });

        const ws = XLSX.utils.json_to_sheet(flattened);
        const wb = XLSX.utils.book_new();
        XLSX.utils.book_append_sheet(wb, ws, "Agentlar kunlik statistikasi");
        XLSX.writeFile(wb, "agent_kunlik_statistika.xlsx");
    };

    return (
        <div>
            {loading ? (
                <div>loading</div>
            ) : (
                <div>
                    <Sidebar />
                    <div className="p-10 sm:ml-64">
                        <h1 className="text-2xl font-semibold mb-4">Bosh sahifa</h1>

                        <div className="mb-6 text-lg font-medium">
                            Umumiy ro'yxatdan o'tgan talabalar soni:{" "}
                            <span className="font-bold">{totalCount} ta</span>
                        </div>

                        {/* Agentlar bo'yicha kunlik statistika */}
                        {/* Agent selection and table display */}
                        <div className="bg-white rounded-lg shadow-md p-6 mb-6">
                            <div className="flex justify-between items-center mb-4">
                                <div className="flex gap-2 items-center w-full max-w-md">
                                    <h2 className="text-xl font-semibold whitespace-nowrap">📊  kunlik statistika</h2>
                                    <Select
                                        className="react-select-container  "
                                        a         classNamePrefix="react-select"
                                        options={agentOptions}
                                        value={agentOptions.find(opt => opt.value === selectedAgent) || null}
                                        onChange={(opt) => setSelectedAgent(opt ? opt.value : "")}
                                        isSearchable
                                        placeholder="Agentni qidiring..."
                                        noOptionsMessage={() => "Natija topilmadi"}
                                        isClearable
                                    />
                                </div>
                                <button
                                    onClick={exportAgentDailyStatsToExcel}
                                    className="bg-green-500 text-white px-3 py-1 rounded-md text-sm hover:bg-green-600"
                                >
                                    Excelga yuklash
                                </button>
                            </div>

                            <div className="overflow-x-auto">
                                {selectedAgent && agentDailyStats.length > 0 ? (
                                    <table className="min-w-full table-auto border-collapse border border-gray-300">
                                        <thead className="bg-gray-100">
                                        <tr>
                                            <th className="border px-4 py-2">Agent nomi</th>
                                            <th className="border px-4 py-2">Telefon raqam</th>
                                            <th className="border px-4 py-2">Sana</th>
                                            <th className="border px-4 py-2">Ro'yxatdan o'tganlar</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        {agentDailyStats.flatMap((agent, index) => {
                                            const sortedEntries = Object.entries(agent.daily || {}).sort(
                                                ([a], [b]) => new Date(b) - new Date(a) // show latest dates first
                                            );
                                            return sortedEntries.map(([date, count], i) => (
                                                <tr key={`${index}-${i}`} className="hover:bg-gray-50">
                                                    <td className="border px-4 py-2">{agent.name}</td>
                                                    <td className="border px-4 py-2">{agent.phone}</td>
                                                    <td className="border px-4 py-2">{date}</td>
                                                    <td className="border px-4 py-2">{count}</td>
                                                </tr>
                                            ));
                                        })}
                                        </tbody>

                                    </table>
                                ) : (
                                    <p className="text-gray-500">Agent tanlang...</p>
                                )}
                            </div>
                        </div>

                        {/* Sayt agentlar */}
                        <div className="flex justify-between items-center mb-2">
                            <h2 className="text-xl font-semibold">🧑‍💻 Sayt orqali tayinlangan agentlar</h2>
                            <button
                                onClick={() => exportAgentsToExcel(siteAgents, "sayt_agentlar.xlsx")}
                                className="bg-green-500 text-white px-3 py-1 rounded-md text-sm hover:bg-green-600"
                            >
                                Excelga yuklash
                            </button>
                        </div>
                        {renderTable("", siteAgents)}

                        {/* Bot agentlar */}
                        <div className="flex justify-between items-center mb-2 mt-6">
                            <h2 className="text-xl font-semibold">🤖 Bot orqali tayinlangan agentlar</h2>
                            <button
                                onClick={() => exportAgentsToExcel(botAgents, "bot_agentlar.xlsx")}
                                className="bg-green-500 text-white px-3 py-1 rounded-md text-sm hover:bg-green-600"
                            >
                                Excelga yuklash
                            </button>
                        </div>
                        {renderTable("", botAgents)}



                        {/*agent daily*/}

                        <div className="flex justify-between items-center mb-4">
                            <div className="flex gap-2 items-center">
                                <h2 className="text-xl font-semibold">📊 Agentlar bo'yicha kunlik statistika</h2>
                                <select
                                    value={selectedAgent}
                                    onChange={(e) => setSelectedAgent(e.target.value)}
                                    className="border px-3 py-1 rounded-md text-sm"
                                >
                                    <option value="all">Barcha agentlar</option>
                                    {[...new Set(statistics.map(agent => agent.phone))].map((phone) => {
                                        const name = statistics.find(agent => agent.phone === phone)?.name;
                                        return (
                                            <option key={phone} value={phone}>
                                                {name} ({phone})
                                            </option>
                                        );
                                    })}
                                </select>
                            </div>

                            <button
                                onClick={exportAgentDailyStatsToExcel}
                                className="bg-green-500 text-white px-3 py-1 rounded-md text-sm hover:bg-green-600"
                            >
                                Excelga yuklash
                            </button>
                        </div>



                        {/* Daily chart and export */}
                        <div className="bg-white rounded-lg shadow-md p-6 mb-6">
                            <div className="flex flex-col sm:flex-row justify-between sm:items-center mb-4 gap-2">
                                <h2 className="text-xl font-semibold">📈 Kunlik ro'yxatdan o'tganlar statistikasi</h2>
                                <div className="flex gap-2">
                                    <select
                                        className="border px-3 py-1 rounded-md text-sm"
                                        value={sortOrder}
                                        onChange={handleSortChange}
                                    >
                                        <option value="desc">🆕 Eng so‘nggi sanalar (newest first)</option>
                                        <option value="asc">📅 Eng eski sanalar (oldest first)</option>
                                    </select>
                                    <button
                                        onClick={exportToExcel}
                                        className="bg-green-500 text-white px-3 py-1 rounded-md text-sm hover:bg-green-600"
                                    >
                                        Excelga yuklash
                                    </button>
                                    <button
                                        onClick={exportToPDF}
                                        className="bg-red-500 text-white px-3 py-1 rounded-md text-sm hover:bg-red-600"
                                    >
                                        PDFga yuklash
                                    </button>
                                </div>
                            </div>

                            <ResponsiveContainer width="100%" height={300}>
                                <LineChart data={dailyStats}>
                                    <CartesianGrid stroke="#ccc" />
                                    <XAxis dataKey="date" />
                                    <YAxis allowDecimals={false} />
                                    <Tooltip />
                                    <Line type="monotone" dataKey="count" stroke="#8884d8" />
                                </LineChart>
                            </ResponsiveContainer>
                        </div>

                        {renderDailyStatsTable()}





                    </div>
                </div>
            )}
        </div>
    );
};

export default AdminHome;
