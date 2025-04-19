import React, { useState, useEffect } from 'react';
import Header from "../header/Header";
import { useParams } from "react-router-dom";
import Footer from "../footer/Footer";
import ApiCall from "../../config";

function GoldCard() {
    const { cardId } = useParams();
    const [cardData, setCardData] = useState(null);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);

    useEffect(() => {
        const fetchCardData = async () => {
            try {
                const response = await ApiCall(`/api/v1/qr-code/${cardId}`, 'GET', null, null);
                setCardData(response.data);
                setLoading(false);
            } catch (err) {
                setError("Kartani yuklashda xatolik yuz berdi");
                setLoading(false);
                console.error("Error fetching card data:", err);
            }
        };

        fetchCardData();
    }, [cardId]);

    if (loading) {
        return (
            <div>
                <Header />
                <div className="py-32 h-screen flex items-center justify-center">
                    <div className="animate-spin rounded-full h-12 w-12 border-t-2 border-b-2 border-blue-500"></div>
                </div>
                <Footer />
            </div>
        );
    }

    if (error) {
        return (
            <div>
                <Header />
                <div className="py-32 h-screen flex items-center justify-center">
                    <div className="text-red-500 text-xl">{error}</div>
                </div>
                <Footer />
            </div>
        );
    }

    const renderField = (label, value) => {
        if (!value) return null;
        return (
            <div className="flex items-start py-2">
                <span className="font-medium text-gray-700 w-1/3">{label}:</span>
                <span className="text-gray-900 flex-1">{value}</span>
            </div>
        );
    };

    return (
        <div>
            <Header />

            <div className="pt-32 pb-20 container mx-auto px-4">
                <div className="max-w-3xl mx-auto bg-white rounded-lg my-8 shadow-lg overflow-hidden border border-yellow-200">
                    <div className="p-8">
                        <h1 className="text-3xl font-bold text-center text-yellow-600 mb-2">
                          BUXORO XALQARO UNIVERSITETI
                        </h1>
                        <h1 className="text-3xl font-bold text-center text-yellow-600 mb-8">
                            Gold Kartasi
                        </h1>

                        {cardData?.abuturient ? (
                            <div className="space-y-6">
                                <div className="grid grid-cols-1 md:grid-cols-2 gap-8">
                                    <div className="bg-gray-50 p-6 rounded-lg">
                                        <h2 className="text-xl font-semibold mb-4 text-yellow-700 border-b pb-2 border-yellow-200">
                                            Abiturient ma'lumotlari
                                        </h2>
                                        <div className="space-y-3">
                                            {renderField("Ism", cardData.abuturient.firstName)}
                                            {renderField("Familiya", cardData.abuturient.lastName)}
                                            {renderField("Otasining ismi", cardData.abuturient.fatherName)}
                                            {renderField("Telefon", cardData.abuturient.phone)}
                                            {renderField("Qo'shimcha telefon", cardData.abuturient.additionalPhone)}
                                            {renderField("Passport raqami", cardData.abuturient.passportNumber)}
                                            {renderField("Passport PIN", cardData.abuturient.passportPin)}
                                        </div>
                                    </div>
                                    <div className="bg-gray-50 p-6 rounded-lg">
                                        <h2 className="text-xl font-semibold mb-4 text-yellow-700 border-b pb-2 border-yellow-200">
                                            Ta'lim ma'lumotlari
                                        </h2>
                                        <div className="space-y-3">
                                            {renderField("Ariza turi", cardData.abuturient.appealType?.name)}
                                            {renderField("Ta'lim yo'nalishi", cardData.abuturient.educationField?.name)}
                                            {renderField("Yozilgan sana", cardData.abuturient.createdAt && new Date(cardData.abuturient.createdAt).toLocaleDateString())}
                                        </div>
                                    </div>
                                </div>

                                <div className="mt-8 p-6 bg-yellow-50 border-l-8 border-yellow-500 rounded-lg">
                                    <h3 className="font-bold text-yellow-800 text-xl mb-2">📣 Diqqat!</h3>
                                    <p className="text-yellow-700 mb-1">
                                        Ushbu karta allaqachon abiturientga biriktirilgan.
                                    </p>
                                    <p className="text-yellow-700 font-medium">
                                        Bu karta egasi 2025-2026 o'quv yili davomida kontraktidan <span className="text-green-600 font-bold">5 million so'm</span> chegirma beriladi.
                                    </p>
                                </div>

                            </div>
                        ) : (
                            <div className="text-center py-12">
                                <div className="text-2xl font-semibold text-gray-600 mb-4">
                                    Kartaga abiturient biriktirilmagan
                                </div>
                                <p className="text-gray-500">
                                    Ushbu kartani abiturientga biriktirish uchun agent bilan bog'laning
                                </p>
                            </div>
                        )}
                    </div>

                    {/* Card details footer */}
                    <div className="bg-yellow-50 px-6 py-4 border-t border-yellow-200">
                        <div className="flex flex-col md:flex-row justify-between items-center">
                            <div className="mb-2 md:mb-0">
                                <p className="text-gray-700">
                                    <span className="font-medium">Agent:</span> {cardData?.agent?.name || "Noma'lum"}
                                </p>
                            </div>
                            <div>
                                <p className="text-gray-700">
                                    <span className="font-medium">Seriya raqami:</span> {cardData?.serialNumber || "Noma'lum"}
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <Footer />
        </div>
    );
}

// Helper function to get status text
const getStatusText = (status) => {
    switch(status) {
        case 1: return "Bo'sh";
        case 2: return "Faol";
        case 3: return "Bloklangan";
        default: return "Noma'lum";
    }
};

export default GoldCard;