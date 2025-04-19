import React, { useState } from "react";
import bg from "./images/bino1.jpg";
import bg2 from "./bgImage/1.jpg";
import bg3 from "./bgImage/2.jpg";
import bg4 from "./bgImage/3.jpg";
import bg5 from "./bgImage/4.jpg";
import bg6 from "./bgImage/5.jpg";
import { Modal } from "react-responsive-modal";
import "react-responsive-modal/styles.css";
import ApiCall from "../../config";
import { useNavigate, useParams } from "react-router-dom";
import { motion } from "framer-motion";
import { fadeIn } from "./framerMotion/variants";

function BgImage(props) {
  const { agentId } = useParams();
  const [open, setOpen] = useState(false);
  const [tel, setTel] = useState(""); // Phone number state
  const [success, setSuccess] = useState(false); // Submission success state
  const [message, setMessage] = useState(""); // Success/error message
  const navigate = useNavigate();

  const handleClose = () => setOpen(false);

  const handleChange = (e) => {
    let value = e.target.value;

    // Only allow digits after the initial +998
    if (value.length >= 14) return;

    if (value.startsWith("+998") && /^\+998\d{0,9}$/.test(value)) {
      if (value.length <= 13) setTel(value);
    } else if (value === "+998") {
      setTel(value);
    } else {
      setTel("+998");
    }
  };

  const handleSave = async (e) => {
    e.preventDefault();

    // Validate the phone number format
    const phoneRegex = /^\+998\d{9}$/;
    if (!phoneRegex.test(tel)) {
      setMessage("Telefon raqami noto'g'ri formatda!");
      setOpen(true);
      return;
    }

    const obj = {
      phone: tel,
      agentId: agentId,
    };

    try {
      const response = await ApiCall(
        `/api/v1/abuturient`,
        "POST",
        obj,
        null,
        true
      );
      setSuccess(true);
      navigate("/data-form", { state: { phone: tel } });
    } catch (error) {
      console.error("Error saving data:", error);
      setSuccess(false);
      setMessage("Xatolik yuz berdi.");
      setOpen(true);
    }
  };

  return (
    <div className="">
      {/* Background Image with Overlay */}
      <div
        className=" bg-cover bg-center "
        style={{ backgroundImage: `url(${bg5})` }}
      >
        <motion.div
          
          className="  flex py-28 justify-center"
        >
          <div className="container mx-auto px-4 sm:px-6 lg:px-8">
            <div className="text-center">
              <h2 className="text-white text-3xl sm:text-4xl md:text-5xl font-bold mb-8">
                XUSH KELIBSIZ!
              </h2>
              <h2 className="text-white text-xl sm:text-2xl md:text-3xl font-bold mb-8">
                BUXORO XALQARO UNIVERSITETI QABUL PLATFORMASIGA
              </h2>

              {/* Login Form */}
              <div className="bg-white rounded-lg shadow-lg max-w-md mx-auto overflow-hidden pb-4">
                <div className="bg-amber-50 p-4">
                  <h3 className="text-xl font-semibold text-gray-800">
                    Tizimga kirish
                  </h3>
                </div>
                <div className="p-6">
                  <p className="text-sm text-gray-600 mb-4">
                    Telefon raqamingizni kiriting:
                  </p>
                  <form onSubmit={handleSave} className="space-y-4">
                    <div className="relative">
                      <div className="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                        <svg
                          className="w-5 h-5 text-gray-400"
                          aria-hidden="true"
                          xmlns="http://www.w3.org/2000/svg"
                          fill="currentColor"
                          viewBox="0 0 19 18"
                        >
                          <path d="M18 13.446a3.02 3.02 0 0 0-.946-1.985l-1.4-1.4a3.054 3.054 0 0 0-4.218 0l-.7.7a.983.983 0 0 1-1.39 0l-2.1-2.1a.983.983 0 0 1 0-1.389l.7-.7a2.98 2.98 0 0 0 0-4.217l-1.4-1.4a2.824 2.824 0 0 0-4.218 0c-3.619 3.619-3 8.229 1.752 12.979C6.785 16.639 9.45 18 11.912 18a7.175 7.175 0 0 0 5.139-2.325A2.9 2.9 0 0 0 18 13.446Z" />
                        </svg>
                      </div>
                      <input
                        type="text"
                        id="phone-input"
                        onChange={handleChange}
                        onClick={() => setTel("+998")}
                        value={tel}
                        aria-describedby="helper-text-explanation"
                        className="w-full pl-10 pr-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 outline-none"
                        placeholder="+998 __ ___-__-__"
                        required
                      />
                    </div>
                    <button
                      type="submit"
                      className="w-full bg-blue-600 hover:bg-blue-700 text-white py-2 px-4 rounded-lg transition duration-300"
                    >
                      Kirish/Ro'yxatdan o'tish
                    </button>
                  </form>
                </div>
                <a
                  href="https://bxu.uz/"
                  target="_blank"
                  className="no-underline text-xl font-bold"
                >
                  Batafsil  <i class="fa-solid fa-arrow-right"></i>
                </a>
              </div>
            </div>
          </div>
        </motion.div>
      </div>
    </div>
  );
}

export default BgImage;
