import React, { useState } from "react";
import { useNavigate } from "react-router-dom";
import { ToastContainer, toast } from "react-toastify";
import "react-toastify/dist/ReactToastify.css";
import Header from "../pages/header/Header";
import Footer from "../pages/footer/Footer";
import ApiCall from "../config/index";

const LoginAdmin = () => {
  const [adminData, setAdminData] = useState({
    phone: "",
    password: "",
    rememberMe: false,
  });
  const [isLoading, setIsLoading] = useState(false);
  const navigate = useNavigate();

  const handleAdminChange = (e) => {
    const { name, value } = e.target;
    setAdminData({ ...adminData, [name]: value });
  };

  const handleAdminSubmit = async (e) => {
    e.preventDefault();
    setIsLoading(true);

    // Validate inputs
    if (!adminData.phone || !adminData.password) {
      toast.error("Iltimos, telefon raqam va parolni kiriting!", {
        position: "top-right",
        autoClose: 3000,
      });
      setIsLoading(false);
      return;
    }

    try {
      const response = await ApiCall(
        "/api/v1/auth/login",
        "POST",
        adminData,
        null,
        false
      );

      localStorage.removeItem("access_token");
      localStorage.removeItem("refresh_token");

      if (response.data.refresh_token) {
        // toast.success('Muvaffaqiyatli kirish!', {
        //     position: "top-right",
        //     autoClose: 2000,
        // });
        localStorage.setItem("access_token", response.data.access_token);
        localStorage.setItem("refresh_token", response.data.refresh_token);
      } else {
        // toast.success('Muvaffaqiyatli kirish!', {
        //     position: "top-right",
        //     autoClose: 2000,
        // });
        localStorage.setItem("access_token", response.data.access_token);
      }

      const roles = response.data.roles || [];

      // Show success toast

      // Navigate based on role
      if (roles[0].name === "ROLE_SUPER_ADMIN" && response.error === false) {
        setTimeout(() => navigate("/dashboard"), 500);
      } else if (roles[0].name === "ROLE_ADMIN" && response.error === false) {
        setTimeout(() => navigate("/admin/home"), 500);
      } else if (roles[0].name === "ROLE_AGENT" && response.error === false) {
        setTimeout(() => navigate("/agent/appeals"), 500);
      } else if (
        roles[0].name === "ROLE_DATA_MANAGER" &&
        response.error === false
      ) {
        setTimeout(() => navigate("/manager/home"), 500);
      }
    } catch (error) {
      console.error("Login error:", error);

      if (error.response) {
        if (error.response.status === 401 || error.response.status === 403) {
          toast.error("Noto‘g‘ri login yoki parol!", {
            position: "top-right",
            autoClose: 3000,
          });
        } else if (error.response.status === 500) {
          toast.error("Server xatosi! Iltimos, keyinroq urinib ko‘ring.", {
            position: "top-right",
            autoClose: 3000,
          });
        } else {
          toast.error("Xatolik yuz berdi!", {
            position: "top-right",
            autoClose: 3000,
          });
        }
      } else {
        toast.error("Noto‘g‘ri login yoki parol!", {
          position: "top-right",
          autoClose: 3000,
        });
      }
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <div className="min-h-screen bg-white selection:bg-primary/10 selection:text-primary dark:bg-gray-900">
      <Header />
      {/* Toast Container */}
      <ToastContainer
        position="top-right"
        autoClose={3000}
        hideProgressBar={false}
        newestOnTop={false}
        closeOnClick
        rtl={false}
        pauseOnFocusLoss
        draggable
        pauseOnHover
        theme="colored"
      />

      <section className="pt-24 mt-0 sm:pt-36 md:pt-40 lg:pt-28">
        <div className="mx-auto px-4 sm:px-12 xl:max-w-6xl xl:px-0 mb-4">
          <div className="pt-16">
            <div
              aria-hidden="true"
              className="absolute inset-0 top-60 grid grid-cols-2 -space-x-52 opacity-50 dark:opacity-30"
            >
              <div className="h-60 bg-gradient-to-br from-primary to-purple-400 blur-[106px] dark:from-blue-700"></div>
              <div className="h-40 bg-gradient-to-r from-cyan-600 to-sky-500 blur-[106px] dark:to-indigo-600"></div>
            </div>
            <div className="items-center gap-12 lg:flex justify-center">
              <div className="relative lg:w-1/2 rounded-3xl border border-gray-100 bg-white p-4 shadow-2xl shadow-gray-600/10 dark:border-gray-700 dark:bg-gray-800 dark:shadow-none sm:p-8">
                <div className="flex m-auto text-center">
                  {/* Your logos here */}
                </div>

                <h2 className="text-center text-2xl font-bold text-gray-800 dark:text-white">
                  Tizimga kirish.
                </h2>

                <form onSubmit={handleAdminSubmit} className="mt-4 p-10 pt-0">
                  <div>
                    <h2 className={"text-center text-xl font-bold"}>
                      Qabul Admin
                    </h2>
                    <label
                      htmlFor="phone"
                      className="my-2 mb-2 block text-gray-600 dark:text-gray-300"
                    >
                      Admin login{" "}
                      <span className="text-xl text-red-500 dark:text-red-400">
                        *
                      </span>
                    </label>
                    <input
                      type="text"
                      name="phone"
                      id="phone"
                      autoComplete="name"
                      value={adminData.phone}
                      onChange={handleAdminChange}
                      className="peer block w-full rounded-lg border border-gray-200 bg-transparent px-4 py-2 text-gray-600 transition-shadow duration-300 invalid:ring-2 invalid:ring-red-400 focus:ring-2 dark:border-gray-700"
                    />
                    <span className="mt-1 hidden text-sm text-red-500 peer-invalid:block"></span>
                  </div>

                  <div className="mt-4">
                    <label
                      htmlFor="password"
                      className="mb-2 block text-gray-600 dark:text-gray-300"
                    >
                      Parol{" "}
                      <span className="text-xl text-red-500 dark:text-red-400">
                        *
                      </span>
                    </label>
                    <input
                      type="password"
                      name="password"
                      id="password"
                      autoComplete="tel"
                      value={adminData.password}
                      onChange={handleAdminChange}
                      className="peer block w-full rounded-lg border border-gray-200 bg-transparent px-4 py-2 text-gray-600 transition-shadow duration-300 invalid:ring-2 invalid:ring-red-400 focus:ring-2 dark:border-gray-700"
                    />
                    <span className="mt-1 hidden text-sm text-red-500 peer-invalid:block"></span>
                  </div>

                  <button
                    type="submit"
                    className="relative mt-6 flex h-12 w-full items-center justify-center px-6 bg-blue-800 rounded-3xl hover:bg-black text-white text-xl font-semibold"
                    disabled={isLoading}
                  >
                    {isLoading ? (
                      <span className="flex items-center">
                        <svg
                          className="animate-spin -ml-1 mr-3 h-5 w-5 text-white"
                          xmlns="http://www.w3.org/2000/svg"
                          fill="none"
                          viewBox="0 0 24 24"
                        >
                          <circle
                            className="opacity-25"
                            cx="12"
                            cy="12"
                            r="10"
                            stroke="currentColor"
                            strokeWidth="4"
                          ></circle>
                          <path
                            className="opacity-75"
                            fill="currentColor"
                            d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"
                          ></path>
                        </svg>
                        Kirilmoqda...
                      </span>
                    ) : (
                      "Kirish"
                    )}
                  </button>
                </form>
              </div>
            </div>
          </div>
        </div>
      </section>
      <Footer />
    </div>
  );
};

export default LoginAdmin;
