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
        fetchAgentDailyStats();
    }, []);

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

    // Calculate day before yesterday manually
    const today = new Date();
    const yesterday = new Date(today);
    yesterday.setDate(yesterday.getDate() - 1);
    const dayBeforeYesterday = new Date(yesterday);
    dayBeforeYesterday.setDate(dayBeforeYesterday.getDate() - 1);

    const formatDate = (date) => date.toISOString().split('T')[0];

    const todayStr = formatDate(today);
    const yesterdayStr = formatDate(yesterday);
    const dayBeforeYesterdayStr = formatDate(dayBeforeYesterday);


    const renderTable = (title, agents) => (
        <div className="bg-white rounded-lg shadow-md p-6 mb-6">
            {title && <h2 className="text-xl font-semibold mb-4">{title}</h2>}
            {agents.length === 0 ? (
                <p className="text-gray-500">Ma'lumot topilmadi</p>
            ) : (
                <div className="overflow-x-auto">
                    <div className="overflow-y-auto max-h-[500px]">
                        <table className="min-w-full table-auto border-collapse border border-gray-300">
                            <thead className="bg-gray-100 sticky top-0 z-10">
                            <tr>
                                <th className="border border-gray-300 px-2 py-1 text-left text-[12px]">#</th>
                                <th className="border border-gray-300 px-2 py-1 text-left text-[12px]">Agent nomi</th>
                                <th className="border border-gray-300 px-2 py-1 text-left text-[12px]">Telefon raqam</th>
                                <th className="border border-gray-300 px-2 py-1 text-left text-[12px]">Abituriyentlar soni</th>
                                <th className="border border-gray-300 px-2 py-1 text-left text-[12px]">{dayBeforeYesterdayStr}</th>
                                <th className="border border-gray-300 px-2 py-1 text-left text-[12px]">{yesterdayStr}</th>
                                <th className="border border-gray-300 px-2 py-1 text-left text-[12px]">{todayStr}</th>
                            </tr>
                            </thead>

                            <tbody>
                            {agents.map((agent, index) => {
                                const agentDaily = agentDailyStats.find(a => a.phone === agent.phone)?.daily || {};

                                const dayBeforeYesterdayCount = agentDaily[dayBeforeYesterdayStr] || 0;
                                const yesterdayCount = agentDaily[yesterdayStr] || 0;
                                const todayCount = agentDaily[todayStr] || 0;

                                return (
                                    <tr key={index} className="hover:bg-gray-50">
                                        <td className="border border-gray-300 px-4 py-2">{index + 1}</td>
                                        <td className="border border-gray-300 px-4 py-2">{agent.name}</td>
                                        <td className="border border-gray-300 px-4 py-2">{agent.phone}</td>
                                        <td className="border border-gray-300 px-4 py-2">{agent.count}</td>
                                        <td className="border border-gray-300 px-4 py-2">{dayBeforeYesterdayCount}</td>
                                        <td className="border border-gray-300 px-4 py-2">{yesterdayCount}</td>
                                        <td className="border border-gray-300 px-4 py-2">{todayCount}</td>
                                    </tr>
                                );
                            })}
                            </tbody>
                        </table>
                    </div>
                </div>
            )}
        </div>
    );


    const renderDailyStatsTable = () => (
        <div className="bg-white rounded-lg shadow-md p-6 mb-6">
            <h2 className="text-xl font-semibold mb-4">📊 Kunlik ro'yxatdan o'tish jadvali</h2>

            {dailyStats.length === 0 ? (
                <p className="text-gray-500">Ma'lumot topilmadi</p>
            ) : (
                <div className="overflow-x-auto">
                    <div className="overflow-y-auto max-h-[500px]">
                        <table className="min-w-full table-auto border-collapse border border-gray-300">
                            <thead className="bg-gray-100 sticky top-0 z-10">
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
                    </div>
                </div>
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

                        <div className="flex justify-between items-center mb-2">
                            <h2 className="text-xl font-semibold">🧑‍💻 Sayt orqali tayinlangan agentlar: <span className={"text-red-500"}>{siteAgents?.length} ta</span></h2>
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
                            <h2 className="text-xl font-semibold">🤖 Bot orqali tayinlangan agentlar: <span className={"text-red-500"}>{botAgents?.length} ta</span></h2>
                            <button
                                onClick={() => exportAgentsToExcel(botAgents, "bot_agentlar.xlsx")}
                                className="bg-green-500 text-white px-3 py-1 rounded-md text-sm hover:bg-green-600"
                            >
                                Excelga yuklash
                            </button>
                        </div>
                        {renderTable("", botAgents)}



                        {/*agent daily*/}

                        {/*<div className="flex justify-between items-center mb-4">*/}
                        {/*    <div className="flex gap-2 items-center">*/}
                        {/*        <h2 className="text-xl font-semibold">📊 Agentlar bo'yicha kunlik statistika</h2>*/}
                        {/*        <select*/}
                        {/*            value={selectedAgent}*/}
                        {/*            onChange={(e) => setSelectedAgent(e.target.value)}*/}
                        {/*            className="border px-3 py-1 rounded-md text-sm"*/}
                        {/*        >*/}
                        {/*            <option value="all">Barcha agentlar</option>*/}
                        {/*            {[...new Set(statistics.map(agent => agent.phone))].map((phone) => {*/}
                        {/*                const name = statistics.find(agent => agent.phone === phone)?.name;*/}
                        {/*                return (*/}
                        {/*                    <option key={phone} value={phone}>*/}
                        {/*                        {name} ({phone})*/}
                        {/*                    </option>*/}
                        {/*                );*/}
                        {/*            })}*/}
                        {/*        </select>*/}
                        {/*    </div>*/}

                        {/*    <button*/}
                        {/*        onClick={exportAgentDailyStatsToExcel}*/}
                        {/*        className="bg-green-500 text-white px-3 py-1 rounded-md text-sm hover:bg-green-600"*/}
                        {/*    >*/}
                        {/*        Excelga yuklash*/}
                        {/*    </button>*/}
                        {/*</div>*/}



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
