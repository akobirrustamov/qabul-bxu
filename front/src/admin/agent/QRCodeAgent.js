import React, { useState, useEffect } from 'react';
import ApiCall, { baseUrl } from "../../config";
import Sidebar from "./Sidebar";
import { Link, useNavigate } from "react-router-dom";

const QRCodeAgent = () => {
    const [agent, setAgent] = useState(null);
    const navigate = useNavigate();
    const [cards, setCards] = useState([]);
    const [loading, setLoading] = useState(true);
    const [tel, setTel] = useState("+998");
    const [searchLoading, setSearchLoading] = useState(false);
    const [abuturient, setAbuturient] = useState(null);
    const [selectedCardId, setSelectedCardId] = useState("");
    const [successMessage, setSuccessMessage] = useState(null);
    const [connectLoading, setConnectLoading] = useState(false);

    useEffect(() => {
        fetchAgent();
    }, []);

    const fetchAgent = async () => {
        const token = localStorage.getItem("access_token");
        try {
            const response = await ApiCall('/api/v1/agent/me/' + token, 'GET', null, null);
            setAgent(response.data);
            await fetchAgentCards(response.data.id);
        } catch (error) {
            console.error("Error fetching agent:", error);
            setLoading(false);
        }
    };

    const fetchAgentCards = async (id) => {
        try {
            const response = await ApiCall(`/api/v1/qr-code/my-qr-code/${id}`, 'GET', null, null);
            setCards(response.data);
            setLoading(false);
        } catch (error) {
            console.error("Error fetching QR codes:", error);
            setLoading(false);
        }
    }

    const getStatusText = (status) => {
        switch(status) {
            case 1: return "Bo'sh";
            case 2: return "Faol";
            case 3: return "Bloklangan";
            default: return "Noma'lum";
        }
    }

    const getTypeText = (type) => {
        switch(type) {
            case 0: return "Silver";
            case 1: return "Gold";
            case 2: return "Platinum";
            default: return "Noma'lum";
        }
    }

    const handleDownload = async (item) => {
        try {
            const response = await fetch(`${baseUrl}/api/v1/file/getFile/${item?.id}`, {
                method: 'GET',
                headers: {
                    'Content-Type': 'application/png',
                },
            });

            if (!response.ok) throw new Error("Failed to download file");

            const blob = await response.blob();
            const downloadUrl = window.URL.createObjectURL(blob);
            const link = document.createElement('a');
            link.href = downloadUrl;
            link.download = `${item.name}`;
            document.body.appendChild(link);
            link.click();
            link.remove();
            window.URL.revokeObjectURL(downloadUrl);
        } catch (error) {
            console.error("Error downloading file:", error);
        }
    };

    const handlePhoneChange = (e) => {
        let value = e.target.value;
        if (value.length >= 14) return;

        if (value.startsWith("+998") && /^\+998\d{0,9}$/.test(value)) {
            if (value.length <= 13) setTel(value);
        } else if (value === "+998") {
            setTel(value);
        } else {
            setTel("+998");
        }
    };

    const searchAbuturient = async () => {
        if (tel.length !== 13) {
            alert("Iltimos, to'liq telefon raqam kiriting (+998XXXXXXXXX)");
            return;
        }

        setSearchLoading(true);
        try {
            const response = await ApiCall(`/api/v1/abuturient/${tel}`, "GET", null, null, true);

            if (!response.data) {
                setAbuturient(null);
                alert("Ushbu telefon raqam bilan abiturient topilmadi");
                return;
            }

            // Check if this abuturient already has a connected card
            const hasExistingCard = cards.some(card =>
                card.abuturient && card.abuturient.id === response.data.id
            );

            if (hasExistingCard) {
                setAbuturient(null);
                alert("Ushbu abiturientga allaqachon QR kod biriktirilgan. Yangi kod biriktirish mumkin emas!");
                return;
            }

            setAbuturient(response.data);

        } catch (error) {
            setAbuturient(null);
            console.error("Error fetching abuturient:", error);
            alert("Abiturient ma'lumotlarini olishda xatolik yuz berdi");
        } finally {
            setSearchLoading(false);
        }
    };
    const connectCardToAbuturient = async () => {
        if (!selectedCardId || !abuturient) return;

        setConnectLoading(true);
        try {
            const response = await ApiCall(
                `/api/v1/qr-code/connect/${selectedCardId}/${abuturient.id}`,
                'PUT',
                null,
                null
            );

            setSuccessMessage("QR kod muvaffaqiyatli abiturientga biriktirildi!");
            setSelectedCardId("");

            // Refresh the cards list
            await fetchAgentCards(agent.id);

            // Clear success message after 3 seconds
            setTimeout(() => setSuccessMessage(null), 3000);
        } catch (error) {
            console.error("Error connecting card:", error);
            alert("QR kodni biriktirishda xatolik yuz berdi");
        } finally {
            setConnectLoading(false);
        }
    };

    // Get available cards (status === 1)
    const availableCards = cards.filter(card => card.status === 1);

    return (
        <div className="bg-gray-50  min-h-screen">
            <Sidebar />
            <div className="p-4 sm:ml-64">
                {/* Search Section */}
                <div className="bg-white  rounded-lg shadow p-6 mb-6">
                    <h2 className="text-xl font-bold mb-4 text-gray-800 ">Abiturient qidirish</h2>
                    <div className="flex flex-col sm:flex-row gap-4">
                        <div className="relative flex-grow">
                            <div className="absolute inset-y-0 start-0 flex items-center ps-3 pointer-events-none">
                                <svg className="w-4 h-4 text-gray-500 " aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="currentColor" viewBox="0 0 20 16">
                                    <path d="M10 0a10 10 0 1 0 10 10A10 10 0 0 0 10 0Zm0 13a3 3 0 1 1 0-6 3 3 0 0 1 0 6Z"/>
                                </svg>
                            </div>
                            <input
                                type="text"
                                id="phone-input"
                                onChange={handlePhoneChange}
                                onClick={() => tel === "" && setTel("+998")}
                                value={tel}
                                className=" border border-gray-300 text-gray-900 placeholder-black text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block ps-10 p-2.5    "
                                placeholder="+998 __ ___ __ __"
                                required
                            />
                        </div>
                        <button
                            onClick={searchAbuturient}
                            disabled={searchLoading}
                            className="text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center  flex items-center justify-center min-w-[120px]"
                        >
                            {searchLoading ? (
                                <>
                                    <svg aria-hidden="true" className="w-4 h-4 me-2 text-white animate-spin" viewBox="0 0 100 101" fill="none" xmlns="http://www.w3.org/2000/svg">
                                        <path d="M100 50.5908C100 78.2051 77.6142 100.591 50 100.591C22.3858 100.591 0 78.2051 0 50.5908C0 22.9766 22.3858 0.59082 50 0.59082C77.6142 0.59082 100 22.9766 100 50.5908ZM9.08144 50.5908C9.08144 73.1895 27.4013 91.5094 50 91.5094C72.5987 91.5094 90.9186 73.1895 90.9186 50.5908C90.9186 27.9921 72.5987 9.67226 50 9.67226C27.4013 9.67226 9.08144 27.9921 9.08144 50.5908Z" fill="#E5E7EB"/>
                                        <path d="M93.9676 39.0409C96.393 38.4038 97.8624 35.9116 97.0079 33.5539C95.2932 28.8227 92.871 24.3692 89.8167 20.348C85.8452 15.1192 80.8826 10.7238 75.2124 7.41289C69.5422 4.10194 63.2754 1.94025 56.7698 1.05124C51.7666 0.367541 46.6976 0.446843 41.7345 1.27873C39.2613 1.69328 37.813 4.19778 38.4501 6.62326C39.0873 9.04874 41.5694 10.4717 44.0505 10.1071C47.8511 9.54855 51.7191 9.52689 55.5402 10.0491C60.8642 10.7766 65.9928 12.5457 70.6331 15.2552C75.2735 17.9648 79.3347 21.5619 82.5849 25.841C84.9175 28.9121 86.7997 32.2913 88.1811 35.8758C89.083 38.2158 91.5421 39.6781 93.9676 39.0409Z" fill="currentColor"/>
                                    </svg>
                                    Izlanmoqda...
                                </>
                            ) : (
                                "Qidirish"
                            )}
                        </button>
                    </div>

                    {/* Abiturient Info */}
                    {abuturient && (
                        <div className="mt-4 p-4 bg-gray-100  rounded-lg">
                            <h3 className="font-semibold text-lg text-gray-800 ">Abiturient ma'lumotlari</h3>
                                <div className={"flex flex-wrap justify-between"}>
                                    <p className="text-gray-600 text-xl">
                                        <span className="font-medium  text-gray-800">Ism:</span> {abuturient.firstName} {abuturient.lastName}
                                    </p>
                                    <p className="text-gray-600 text-xl">
                                        <span className="font-medium text-gray-800">Telefon:</span> {abuturient.phone}
                                    </p>
                                </div>

                            {/* Card Selection */}
                            <div className="mt-4">
                                <label htmlFor="card-select" className="block mb-2 text-sm font-medium text-gray-900 ">
                                    QR kodni tanlang
                                </label>
                                <select
                                    id="card-select"
                                    value={selectedCardId}
                                    onChange={(e) => setSelectedCardId(e.target.value)}
                                    className="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block  p-2.5    "
                                >
                                    <option value="">QR kod tanlang</option>
                                    {availableCards.map(card => (
                                        <option key={card.id} value={card.id}>
                                            {card.serialNumber} ({getTypeText(card.type)})
                                        </option>
                                    ))}
                                </select>
                            </div>

                            {/* Connect Button */}
                            <div className="mt-4 flex justify-end">
                                <button
                                    onClick={connectCardToAbuturient}
                                    disabled={!selectedCardId || connectLoading}
                                    className="text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center disabled:opacity-50 disabled:cursor-not-allowed"
                                >
                                    {connectLoading ? (
                                        <>
                                            <svg aria-hidden="true" className="w-4 h-4 me-2 text-white animate-spin" viewBox="0 0 100 101" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                <path d="M100 50.5908C100 78.2051 77.6142 100.591 50 100.591C22.3858 100.591 0 78.2051 0 50.5908C0 22.9766 22.3858 0.59082 50 0.59082C77.6142 0.59082 100 22.9766 100 50.5908ZM9.08144 50.5908C9.08144 73.1895 27.4013 91.5094 50 91.5094C72.5987 91.5094 90.9186 73.1895 90.9186 50.5908C90.9186 27.9921 72.5987 9.67226 50 9.67226C27.4013 9.67226 9.08144 27.9921 9.08144 50.5908Z" fill="#E5E7EB"/>
                                                <path d="M93.9676 39.0409C96.393 38.4038 97.8624 35.9116 97.0079 33.5539C95.2932 28.8227 92.871 24.3692 89.8167 20.348C85.8452 15.1192 80.8826 10.7238 75.2124 7.41289C69.5422 4.10194 63.2754 1.94025 56.7698 1.05124C51.7666 0.367541 46.6976 0.446843 41.7345 1.27873C39.2613 1.69328 37.813 4.19778 38.4501 6.62326C39.0873 9.04874 41.5694 10.4717 44.0505 10.1071C47.8511 9.54855 51.7191 9.52689 55.5402 10.0491C60.8642 10.7766 65.9928 12.5457 70.6331 15.2552C75.2735 17.9648 79.3347 21.5619 82.5849 25.841C84.9175 28.9121 86.7997 32.2913 88.1811 35.8758C89.083 38.2158 91.5421 39.6781 93.9676 39.0409Z" fill="currentColor"/>
                                            </svg>
                                            Biriktirilmoqda...
                                        </>
                                    ) : (
                                        "Biriktirish"
                                    )}
                                </button>
                            </div>
                        </div>
                    )}
                </div>

                {/* Success Message */}
                {successMessage && (
                    <div className="mb-4 p-4 bg-green-100 border border-green-400 text-green-700 rounded relative" role="alert">
                        <span className="block sm:inline">{successMessage}</span>
                    </div>
                )}

                {/* QR Codes Table */}
                <div className="bg-white  rounded-lg shadow overflow-hidden">
                    <div className="p-4 border-b border-gray-200 ">
                        <h2 className="text-xl font-bold text-gray-800 ">Mening QR Kodlarim</h2>
                    </div>

                    {loading ? (
                        <div className="flex justify-center items-center h-64">
                            <div className="animate-spin rounded-full h-12 w-12 border-t-2 border-b-2 border-blue-500"></div>
                        </div>
                    ) : (
                        <div className="overflow-x-auto">
                            <table className="w-full text-sm text-left rtl:text-right text-gray-500 ">
                                <thead className="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
                                <tr>
                                    <th scope="col" className="px-6 py-3">TR</th>
                                    <th scope="col" className="px-6 py-3">Serial Number</th>
                                    <th scope="col" className="px-6 py-3">Turi</th>
                                    <th scope="col" className="px-6 py-3">Holati</th>
                                    <th scope="col" className="px-6 py-3">Abuturient</th>
                                    <th scope="col" className="px-6 py-3">Yaratilgan payti</th>
                                    <th scope="col" className="px-6 py-3">Biriktirilgan payti</th>
                                    <th scope="col" className="px-6 py-3">QR Code</th>
                                </tr>
                                </thead>
                                <tbody>
                                {cards.length > 0 ? (
                                    cards.map((card, index) => (
                                        <tr key={card.id} className="bg-white border-b dark:bg-gray-800 dark:border-gray-700 hover:bg-gray-50 dark:hover:bg-gray-600">
                                            <td className="px-2 py-2 font-medium text-gray-900 whitespace-nowrap ">
                                                {index+1}
                                            </td>
                                            <td className="px-2 py-2 font-medium text-gray-900 whitespace-nowrap ">
                                                {card.serialNumber}
                                            </td>
                                            <td className="px-2 py-2">
                                                    <span className={`px-2 py-2 rounded-full text-xs ${
                                                        card.type === 0 ? 'bg-gray-200 text-gray-800' :
                                                            card.type === 1 ? 'bg-yellow-100 text-yellow-800' :
                                                                'bg-blue-100 text-blue-800'
                                                    }`}>
                                                        {getTypeText(card.type)}
                                                    </span>
                                            </td>

                                            <td className="px-2 py-2">
                                                    <span className={`px-2 py-2 rounded-full text-xs ${
                                                        card.status === 0 ? 'bg-gray-200 text-gray-800' :
                                                            card.status === 1 ? 'bg-green-100 text-green-800' :
                                                                'bg-purple-100 text-purple-800'
                                                    }`}>
                                                        {getStatusText(card.status)}
                                                    </span>
                                            </td>
                                            <td className="px-2 py-2 font-medium text-gray-900 whitespace-nowrap ">
                                                {card?.abuturient ? <>{card.abuturient.lastName} {card.abuturient.firstName}</> : "mavjud emas"}
                                            </td>
                                            <td className="px-2 py-2">
                                                {new Date(card.createdAt).toLocaleDateString()}
                                            </td>
                                            <td className="px-2 py-2">
                                                {card.updatedAt ? new Date(card.updatedAt).toLocaleDateString() : "mavjud emas"}
                                            </td>
                                            <td className="px-2 py-2">
                                                {card.attachment && (
                                                    <button
                                                        className="text-blue-500 hover:text-blue-700 mr-2" onClick={()=>handleDownload(card.attachment)}>Yuklash
                                                    </button>
                                                )}
                                            </td>

                                        </tr>
                                    ))
                                ) : (
                                    <tr className="bg-white border-b dark:bg-gray-800 dark:border-gray-700">
                                        <td colSpan="5" className="px-2 py-2 text-center text-gray-500 dark:text-gray-400">
                                            No QR codes found
                                        </td>
                                    </tr>
                                )}
                                </tbody>
                            </table>
                        </div>
                    )}
                </div>
            </div>
        </div>
    );
};

export default QRCodeAgent;