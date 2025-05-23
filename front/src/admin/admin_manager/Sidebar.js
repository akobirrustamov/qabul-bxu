import React, { useState } from 'react';
import { Link, useLocation, useNavigate } from "react-router-dom";

function Sidebar() {
    const location = useLocation();
    const navigate = useNavigate();
    const [sidebarOpen, setSidebarOpen] = useState(false);

    const isActive = (path) => {
        return location.pathname === path ? "bg-gray-200 dark:bg-gray-700" : "";
    };

    const toggleSidebar = () => {
        setSidebarOpen(!sidebarOpen);
    };

    return (
        <div>
            {/* Toggle button (only on small screens) */}
            <button
                onClick={toggleSidebar}
                type="button"
                className="inline-flex items-center p-2 mt-2 ms-3 text-sm text-gray-500 rounded-lg sm:hidden hover:bg-gray-100 focus:outline-none focus:ring-2 focus:ring-gray-200 dark:text-gray-400 dark:hover:bg-gray-700 dark:focus:ring-gray-600"
            >
                <span className="sr-only">Open sidebar</span>
                <svg className="w-6 h-6" aria-hidden="true" fill="currentColor" viewBox="0 0 20 20"
                     xmlns="http://www.w3.org/2000/svg">
                    <path clipRule="evenodd" fillRule="evenodd"
                          d="M2 4.75A.75.75 0 012.75 4h14.5a.75.75 0 010 1.5H2.75A.75.75 0 012 4.75zm0 10.5a.75.75 0 01.75-.75h7.5a.75.75 0 010 1.5h-7.5a.75.75 0 01-.75-.75zM2 10a.75.75 0 01.75-.75h14.5a.75.75 0 010 1.5H2.75A.75.75 0 012 10z"/>
                </svg>
            </button>

            {/* Sidebar drawer */}
            <aside
                className={`fixed top-0 left-0 z-40 w-64 h-screen transition-transform ${
                    sidebarOpen ? 'translate-x-0' : '-translate-x-full'
                } sm:translate-x-0 bg-gray-50 dark:bg-gray-800`}
                aria-label="Sidebar"
            >
                <div className="h-full px-3 py-4 overflow-y-auto">
                    <ul className="space-y-2 font-medium">
                        <li>
                            <Link to={"/admin/home"}
                                  className={`flex items-center p-2 rounded-lg text-gray-900 dark:text-white hover:bg-gray-100 dark:hover:bg-gray-700 group ${isActive("/admin/home")}`}>
                                <span className="ms-3">Bosh sahifa</span>
                            </Link>
                        </li>
                        <li>
                            <Link to={"/admin/appeal"}
                                  className={`flex items-center p-2 rounded-lg text-gray-900 dark:text-white hover:bg-gray-100 dark:hover:bg-gray-700 group ${isActive("/admin/appeal")}`}>
                                <span className="ms-3">Kelib tushgan arizalar</span>
                            </Link>
                        </li>
                        <li>
                            <Link to={"/admin/agent"}
                                  className={`flex items-center p-2 rounded-lg text-gray-900 dark:text-white hover:bg-gray-100 dark:hover:bg-gray-700 group ${isActive("/admin/agent")}`}>
                                <span className="ms-3">Agentlar</span>
                            </Link>
                        </li>
                        <li>
                            <Link
                                to={"/"}
                                onClick={() => localStorage.clear()}
                                className={`flex items-center p-2 rounded-lg text-gray-900 dark:text-white hover:bg-gray-100 dark:hover:bg-gray-700 group`}
                            >
                                <span className="ms-3">Log out</span>
                            </Link>
                        </li>
                    </ul>
                </div>
            </aside>
        </div>
    );
}

export default Sidebar;
