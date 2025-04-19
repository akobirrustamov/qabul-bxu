import React, { useEffect, useState } from 'react';
import {Link, useNavigate} from "react-router-dom";
import Header from "../header/Header";




function PageNotFound(props) {
    const [message, setMessage] = useState([]);
    const navigate = useNavigate();

    useEffect(() => {

    }, []);

    return (
        <div className="min-h-screen bg-white selection:bg-primary/10 selection:text-primary dark:bg-gray-900">
            <Header/>
            <div aria-hidden="true"
                 className="absolute inset-0 top-60 grid grid-cols-2 -space-x-52 opacity-50 dark:opacity-30">
                <div
                    className="h-60 bg-gradient-to-br from-primary to-purple-400 blur-[106px] dark:from-blue-900"></div>
                <div className="h-40 bg-gradient-to-r from-cyan-600 to-sky-500 blur-[106px] dark:to-indigo-600"></div>
            </div>
            <div>
                <div className="mx-auto px-4 pt-56 sm:px-12 xl:max-w-6xl xl:px-0">
                    <div className="relative z-10 lg:w-2/3">

                        <div className="flex flex-col">
                            <span
                                className="bg-gradient-to-b from-orange-400 to-secondary bg-clip-text font-mono text-5xl font-bold text-transparent sm:text-6xl lg:text-8xl"> 404 </span>
                            <h1 className="mb-20 mt-12 text-4xl font-bold text-gray-700 dark:text-white md:text-5xl">
                                Kechirasiz bunday saxifa mavjud emas. . .</h1>
                            <a href="/"
                               className="relative flex h-9 w-max items-center justify-center px-4 before:absolute before:inset-0 before:rounded-full bg-blue-800 rounded-3xl before:duration-300 hover:before:scale-105 active:duration-75 active:before:scale-95 ">
                                <span
                                    className="relative text-sm font-semibold text-white dark:text-gray-900 lg:text-primary lg:dark:text-white">Bosh sahifa..</span>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    );
}

export default PageNotFound;
