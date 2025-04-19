import React, { useEffect, useState } from "react";
import { Link, useNavigate } from "react-router-dom";
import Header from "../header/Header";
import "./home.css";
import Footer from "../footer/Footer";
import BgImage from "./BgImage";

import { Modal } from "react-responsive-modal";
import "react-responsive-modal/styles.css";

import ApiCall, { baseUrl } from "../../config/index";
import logo from "./images/logo.png";
import Litsenziya from "./Licensy";
import Yonalishlar from "./Yonalishlar";
import Directions from "./Directions";
function Home(props) {
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [formData, setFormData] = useState({
    name: "",
    phone: "",
    message: "",
  });
  const navigate = useNavigate();

  useEffect(() => {
    const timer = setTimeout(() => {
      setIsModalOpen(true);
    }, 5000); // Opens modal after 5 seconds
    return () => clearTimeout(timer);
  }, []);

  const handleInputChange = (e) => {
    setFormData({ ...formData, [e.target.name]: e.target.value });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      const response = await ApiCall(
        `/api/v1/message`, // Endpoint URL
        "POST", // HTTP Method
        formData, // Data to send
        null, // Optional headers (can be null)
        true // JSON request option
      );

      setFormData({ name: "", phone: "", message: "" }); // Reset form
      setIsModalOpen(false);
      alert("Malumotlaringizni qoldirganingiz uchun raxmat.");
    } catch (error) {
      console.error("Error occurred while sending the message:", error);
      alert("Server bilan aloqa o'rnatishda xatolik yuz berdi.");
    }
  };

  return (
    <div className="my-bg-second">
      <Header />
      <div className="header-problem my-bg-second"></div>
      <div className="pt-6 md:pt-20">
        <BgImage />
      </div>
      {/* <Yonalishlar /> */}
      <Litsenziya />
      <Directions />
      <Footer />
    </div>
  );
}

export default Home;
