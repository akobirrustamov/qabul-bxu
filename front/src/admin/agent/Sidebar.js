import React, { useEffect, useState } from 'react';
import { Link, useNavigate } from "react-router-dom";
import ApiCall from "../../config";

function Sidebar() {
    const navigate = useNavigate();
    const [user, setUser] = useState(null);
    const [sidebarOpen, setSidebarOpen] = useState(false);
    const [showCards, setShowCards] = useState(false)
    useEffect(() => {
        fetchAgent();
    }, []);

    const fetchAgent = async () => {
        const token = localStorage.getItem("access_token");
        try {
            const response = await ApiCall(`/api/v1/auth/me/${token}`, 'GET', null, null);
            setUser(response.data);
            // alert(JSON.stringify(response.data))
            await fetchAgentCards(response.data.id)
        } catch (error) {
            console.error("Error fetching user:", error);
        }
    }

    const fetchAgentCards = async (id) => {
        try {
            const response = await ApiCall(`/api/v1/qr-code/me/${id}`, 'GET', null, null);
            setShowCards(response.data)
        } catch (error) {
            console.error("Error fetching user:", error);
        }
    }

    const toggleSidebar = () => {
        setSidebarOpen(!sidebarOpen);
    }

    const closeSidebarOnMobile = () => {
        if (window.innerWidth < 640) {
            setSidebarOpen(false);
        }
    }

    return (
        <>
            {/* Mobile toggle button */}
            <button
                onClick={toggleSidebar}
                type="button"
                className="inline-flex items-center p-2 mt-2 ms-3 text-sm text-gray-500 rounded-lg sm:hidden hover:bg-gray-100 focus:outline-none focus:ring-2 focus:ring-gray-200 dark:text-gray-400 dark:hover:bg-gray-700 dark:focus:ring-gray-600"
            >
                <span className="sr-only">Open sidebar</span>
                <svg className="w-6 h-6" aria-hidden="true" fill="currentColor" viewBox="0 0 20 20">
                    <path clipRule="evenodd" fillRule="evenodd" d="M2 4.75A.75.75 0 012.75 4h14.5a.75.75 0 010 1.5H2.75A.75.75 0 012 4.75zm0 10.5a.75.75 0 01.75-.75h7.5a.75.75 0 010 1.5h-7.5a.75.75 0 01-.75-.75zM2 10a.75.75 0 01.75-.75h14.5a.75.75 0 010 1.5H2.75A.75.75 0 012 10z"></path>
                </svg>
            </button>
            {sidebarOpen && (
                <div
                    className="fixed inset-0 z-30 bg-black/50 sm:hidden"
                    onClick={toggleSidebar}
                />
            )}

            {/* Sidebar */}
            <aside
                className={`fixed top-0 left-0 z-40 w-64 h-screen transition-transform ${sidebarOpen ? 'translate-x-0' : '-translate-x-full'} sm:translate-x-0`}
                aria-label="Sidebar"
            >
                <div className="h-full px-3 py-4 overflow-y-auto bg-gray-50 dark:bg-gray-800">
                    <div className="flex items-center ps-2.5 mb-5">
                        <h2 className="text-xl font-semibold text-gray-800 dark:text-white">

                        </h2>
                    </div>

                    <ul className="space-y-2 font-medium">
                        <li>
                            <Link
                                to="/agent/home"
                                onClick={closeSidebarOnMobile}
                                className="flex items-center p-2 text-gray-900 rounded-lg dark:text-white hover:bg-gray-100 dark:hover:bg-gray-700 group"
                            >
                                <svg className="w-5 h-5 text-gray-500 transition duration-75 dark:text-gray-400 group-hover:text-gray-900 dark:group-hover:text-white"
                                     fill="currentColor" viewBox="0 0 20 20">
                                    <path d="M10.707 2.293a1 1 0 00-1.414 0l-7 7a1 1 0 001.414 1.414L4 10.414V17a1 1 0 001 1h2a1 1 0 001-1v-2a1 1 0 011-1h2a1 1 0 011 1v2a1 1 0 001 1h2a1 1 0 001-1v-6.586l.293.293a1 1 0 001.414-1.414l-7-7z" />
                                </svg>
                                <span className="ms-3">Bosh sahifa</span>
                            </Link>
                        </li>

                        <li>
                            <Link
                                to="/agent/appeals"
                                onClick={closeSidebarOnMobile}
                                className="flex items-center p-2 text-gray-900 rounded-lg dark:text-white hover:bg-gray-100 dark:hover:bg-gray-700 group"
                            >
                                <svg className="w-5 h-5 text-gray-500 transition duration-75 dark:text-gray-400 group-hover:text-gray-900 dark:group-hover:text-white"
                                     fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2" />
                                </svg>
                                <span className="ms-3">Kelib tushgan arizalar</span>
                            </Link>
                        </li>

                        {
                            showCards &&
                            <li>
                                <Link
                                    to="/agent/vaucher"
                                    onClick={closeSidebarOnMobile}
                                    className="flex items-center p-2 text-gray-900 rounded-lg dark:text-white hover:bg-gray-100 dark:hover:bg-gray-700 group"
                                >
                                    <svg className="w-5 h-5 text-gray-500 transition duration-75 dark:text-gray-400 group-hover:text-gray-900 dark:group-hover:text-white"
                                         fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2" />
                                    </svg>
                                    <span className="ms-3">Vaucher</span>
                                </Link>
                            </li>
                        }




                        {/*{user?.roles?.some(item => item.name === "ROLE_DATA_MANAGER") && (*/}
                        {/*    <li>*/}
                        {/*        <Link*/}
                        {/*            to="/agent/all-appeals"*/}
                        {/*            onClick={closeSidebarOnMobile}*/}
                        {/*            className="flex items-center p-2 text-gray-900 rounded-lg dark:text-white hover:bg-gray-100 dark:hover:bg-gray-700 group"*/}
                        {/*        >*/}
                        {/*            <svg className="w-5 h-5 text-gray-500 transition duration-75 dark:text-gray-400 group-hover:text-gray-900 dark:group-hover:text-white"*/}
                        {/*                 fill="none" stroke="currentColor" viewBox="0 0 24 24">*/}
                        {/*                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M19 11H5m14 0a2 2 0 012 2v6a2 2 0 01-2 2H5a2 2 0 01-2-2v-6a2 2 0 012-2m14 0V9a2 2 0 00-2-2M5 11V9a2 2 0 012-2m0 0V5a2 2 0 012-2h6a2 2 0 012 2v2M7 7h10" />*/}
                        {/*            </svg>*/}
                        {/*            <span className="ms-3">Barchasi</span>*/}
                        {/*        </Link>*/}
                        {/*    </li>*/}
                        {/*)}*/}

                        <li>
                            <Link
                                to="/"
                                onClick={() => {
                                    localStorage.clear();
                                    closeSidebarOnMobile();
                                }}
                                className="flex items-center p-2 text-gray-900 rounded-lg dark:text-white hover:bg-gray-100 dark:hover:bg-gray-700 group"
                            >
                                <svg className="w-5 h-5 text-gray-500 transition duration-75 dark:text-gray-400 group-hover:text-gray-900 dark:group-hover:text-white"
                                     fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1" />
                                </svg>
                                <span className="ms-3">Log out</span>
                            </Link>
                        </li>
                    </ul>
                </div>
            </aside>
        </>
    );
}

export default Sidebar;