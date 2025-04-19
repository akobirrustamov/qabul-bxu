import React, { useState, useEffect } from 'react';
import ApiCall from "../../config";
import Sidebar from "./Sidebar";
import { useNavigate } from "react-router-dom";
import { FiUser, FiPhone, FiLock, FiCheck, FiEye, FiEyeOff, FiSave } from 'react-icons/fi';
import { ToastContainer, toast } from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';

const Settings = () => {
    const [agent, setAgent] = useState(null);
    const [password, setPassword] = useState('');
    const [confirmPassword, setConfirmPassword] = useState('');
    const [passwordError, setPasswordError] = useState('');
    const [showPassword, setShowPassword] = useState(false);
    const [showConfirmPassword, setShowConfirmPassword] = useState(false);
    const [isLoading, setIsLoading] = useState(false);
    const navigate = useNavigate();

    useEffect(() => {
        fetchAgent();
    }, []);

    const fetchAgent = async () => {
        const token = localStorage.getItem("access_token");
        try {
            const response = await ApiCall('/api/v1/auth/me/' + token, 'GET', null, null);
            setAgent(response.data);
        } catch (error) {
            console.error("Error fetching agent:", error);
            toast.error("Agent ma'lumotlarini yuklashda xato yuz berdi");
        }
    };

    const validatePassword = () => {
        if (password.length < 8) {
            setPasswordError("Parol kamida 8 ta belgidan iborat bo'lishi kerak");
            return false;
        }
        if (password !== confirmPassword) {
            setPasswordError("Parollar mos kelmadi");
            return false;
        }
        setPasswordError('');
        return true;
    };

    const handlePasswordChange = async () => {
        setIsLoading(true);
        if (!validatePassword()) {
            setIsLoading(false);
            return;
        }
        let obj =
            {
                phone:"",
                password:password,

            }
        const token = localStorage.getItem("access_token");
        try {
            const response = await ApiCall(
                `/api/v1/auth/password/${token}`,
                'POST',
                obj,null
            );

            if (response.data) {

                toast.success("Parol muvaffaqiyatli o'zgartirildi!");
                setPassword('');
                setConfirmPassword('');
            }
        } catch (error) {
            console.error("Error updating password:", error);
            toast.error("Parolni o'zgartirishda xato yuz berdi");
        } finally {
            setIsLoading(false);
        }
    };

    return (
        <div className="min-h-screen bg-gray-50">
            <Sidebar />
            <ToastContainer position="top-right" autoClose={3000} />

            <div className="p-4 sm:ml-64">
                <div className="max-w-4xl mx-auto">
                    <div className="bg-white rounded-xl shadow-md overflow-hidden">
                        <div className="p-6 sm:p-8">
                            <h1 className="text-2xl font-bold text-gray-800 mb-6 flex items-center">
                                <FiUser className="mr-2" /> Xodim Profili
                            </h1>

                            <div className="grid md:grid-cols-2 gap-8">
                                {/* Agent Information */}
                                <div className="space-y-6">
                                    <div className="bg-blue-50 p-4 rounded-lg">
                                        <h2 className="text-lg font-semibold text-blue-800 mb-4">
                                            Asosiy ma'lumotlar
                                        </h2>

                                        <div className="space-y-3">
                                            <div className="flex items-center">
                                                <div className="bg-blue-100 p-2 rounded-full mr-3">
                                                    <FiUser className="text-blue-600" />
                                                </div>
                                                <div>
                                                    <p className="text-sm text-gray-500">F.I.O</p>
                                                    <p className="font-medium text-gray-800">
                                                        {agent?.name || "Ma'lumot yo'q"}
                                                    </p>
                                                </div>
                                            </div>

                                            <div className="flex items-center">
                                                <div className="bg-blue-100 p-2 rounded-full mr-3">
                                                    <FiPhone className="text-blue-600" />
                                                </div>
                                                <div>
                                                    <p className="text-sm text-gray-500">Telefon raqam</p>
                                                    <p className="font-medium text-gray-800">
                                                        {agent?.phone || "Ma'lumot yo'q"}
                                                    </p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    {/* Stats Section - You can uncomment and use this if needed */}
                                    {/* <div className="bg-indigo-50 p-4 rounded-lg">
                                        <h2 className="text-lg font-semibold text-indigo-800 mb-4">
                                            Faollik statistikasi
                                        </h2>
                                        <div className="grid grid-cols-2 gap-4">
                                            <div className="bg-white p-3 rounded-lg shadow-sm">
                                                <p className="text-sm text-gray-500">Jami abituriyentlar</p>
                                                <p className="text-xl font-bold text-indigo-600">24</p>
                                            </div>
                                            <div className="bg-white p-3 rounded-lg shadow-sm">
                                                <p className="text-sm text-gray-500">Aktiv abituriyentlar</p>
                                                <p className="text-xl font-bold text-indigo-600">18</p>
                                            </div>
                                        </div>
                                    </div> */}
                                </div>

                                {/* Password Change Form */}
                                <div className="bg-white border border-gray-200 rounded-lg p-6 shadow-sm">
                                    <h2 className="text-lg font-semibold text-gray-800 mb-4 flex items-center">
                                        <FiLock className="mr-2" /> Parolni o'zgartirish
                                    </h2>

                                    <div  className="space-y-4">
                                        <div>
                                            <label className="block text-sm font-medium text-gray-700 mb-1">
                                                Yangi parol
                                            </label>
                                            <div className="relative">
                                                <input
                                                    type={showPassword ? "text" : "password"}
                                                    className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                                                    placeholder="Yangi parol"
                                                    value={password}
                                                    onChange={(e) => setPassword(e.target.value)}
                                                    required
                                                />
                                                <button
                                                    type="button"
                                                    className="absolute right-3 top-2.5 text-gray-500 hover:text-gray-700"
                                                    onClick={() => setShowPassword(!showPassword)}
                                                >
                                                    {showPassword ? <FiEyeOff /> : <FiEye />}
                                                </button>
                                            </div>
                                            {password.length > 0 && password.length < 8 && (
                                                <p className="mt-1 text-xs text-red-500">
                                                    Parol kamida 8 ta belgidan iborat bo'lishi kerak
                                                </p>
                                            )}
                                        </div>

                                        <div>
                                            <label className="block text-sm font-medium text-gray-700 mb-1">
                                                Parolni tasdiqlash
                                            </label>
                                            <div className="relative">
                                                <input
                                                    type={showConfirmPassword ? "text" : "password"}
                                                    className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                                                    placeholder="Parolni takrorlang"
                                                    value={confirmPassword}
                                                    onChange={(e) => setConfirmPassword(e.target.value)}
                                                    required
                                                />
                                                <button
                                                    type="button"
                                                    className="absolute right-3 top-2.5 text-gray-500 hover:text-gray-700"
                                                    onClick={() => setShowConfirmPassword(!showConfirmPassword)}
                                                >
                                                    {showConfirmPassword ? <FiEyeOff /> : <FiEye />}
                                                </button>
                                            </div>
                                            {passwordError && (
                                                <p className="mt-1 text-xs text-red-500">{passwordError}</p>
                                            )}
                                        </div>

                                        <button

                                            disabled={isLoading}
                                            onClick={handlePasswordChange}
                                            className={`w-full flex items-center justify-center py-2 px-4 border border-transparent rounded-lg shadow-sm text-white font-medium focus:outline-none focus:ring-2 focus:ring-offset-2 ${
                                                isLoading
                                                    ? 'bg-blue-400 cursor-not-allowed'
                                                    : 'bg-blue-600 hover:bg-blue-700'
                                            }`}
                                        >
                                            {isLoading ? (
                                                <>
                                                    <svg className="animate-spin -ml-1 mr-3 h-5 w-5 text-white" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                                                        <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4"></circle>
                                                        <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
                                                    </svg>
                                                    Jarayonda...
                                                </>
                                            ) : (
                                                <>
                                                    <FiSave className="mr-2" />
                                                    Parolni yangilash
                                                </>
                                            )}
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    );
};

export default Settings;