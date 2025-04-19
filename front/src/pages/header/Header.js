import React, { useState, useEffect } from "react";
import { Link } from "react-router-dom";
import logo from "../../images/logoMain.png";
import { MdMenu, MdClose } from "react-icons/md";
import { FaPhoneAlt } from "react-icons/fa";
import Slider from "react-slick";
import "slick-carousel/slick/slick.css";
import "slick-carousel/slick/slick-theme.css";

function Header() {
  const Links = [
    {
      name: "Ta'lim yo'nalishlari",
      path: "/education-type",
    },
    {
      name: "Kirish imthonlari",
      path: "/education-exam",
    },
    {
      name: "Imtiyozlar",
      path: "/education-offer",
    },
  ];

  const [menuOpen, setMenuOpen] = useState(false);

  const toggleMenu = () => {
    setMenuOpen(!menuOpen);
  };

  const closeMenu = () => {
    setMenuOpen(false);
  };

  useEffect(() => {
    const handleClickOutside = (event) => {
      if (menuOpen && !event.target.closest(".mobile-menu-container")) {
        closeMenu();
      }
    };

    document.addEventListener("mousedown", handleClickOutside);
    return () => {
      document.removeEventListener("mousedown", handleClickOutside);
    };
  }, [menuOpen]);

  const socialLinks = [
    {
      icon: "fa-brands fa-telegram",
      url: "https://t.me/bxu_uz",
      color: "hover:text-blue-500",
      textcolor: "text-[#1877F2]",
      text: "Telegram",
    },
    {
      icon: "fa-brands fa-instagram",
      url: "https://www.instagram.com/bxu.uz",
      color: "hover:text-pink-500",
      textcolor:
        "text-transparent bg-gradient-to-r from-pink-500 via-yellow-500 to-indigo-500 bg-clip-text",
      text: "Instagram",
    },
    {
      icon: "fa-brands fa-square-facebook",
      url: "https://www.facebook.com/share/16Cvb6AEEv/",
      color: "hover:text-blue-500",
      textcolor: "text-[#0088cc]",
      text: "Facebook",
    },
    {
      icon: "fa-brands fa-youtube",
      url: "https://youtube.com/@bxu_uz",
      color: "hover:text-red-500",
      textcolor: "text-[#FF0000]",
      text: "Youtube",
    },
  ];

  const allLinks = [
    ...socialLinks,
    {
      icon: "fa-solid fa-globe",
      url: "https://bxu.uz/",
      color: "hover:text-[#b5b5b5]",
      textcolor: "text-[#a5a5a5]",
      text: "Veb Sahifamiz",
    },
  ];

  // Yangi slider sozlamalari - har bir element alohida slaydda
  const sliderSettings = {
    dots: false,
    infinite: true,
    speed: 800,
    slidesToShow: 5,
    slidesToScroll: 1,
    autoplay: true,
    autoplaySpeed: 2000,
    arrows: false,
    pauseOnHover: false,
    cssEase: "linear",
    responsive: [
      {
        breakpoint: 1024,
        settings: {
          slidesToShow: 5,
        },
      },
      {
        breakpoint: 768,
        settings: {
          slidesToShow: 5,
        },
      },
    ],
  };

  return (
    <header className="bg-gradient-to-r from-blue-800 to-blue-500 fixed w-full z-50 shadow-2xl">
      <div className="container mx-auto px-4 sm:px-6">
        <nav className="flex items-center justify-between h-20 md:h-24">
          {/* Logo Section */}
          <div className="flex items-center justify-center sp flex-shrink-0 z-10">
            <Link to="/" className="flex items-center no-underline">
              <img
                className="h-14 md:h-20 filter contrast-more"
                alt="Buxoro Xalqaro Universiteti logo"
                src={logo}
              />
              <div className="ml-4">
                <h5 className="mb-0 text-white text-xl font-semibold md:text-2xl leading-tight">
                  BUXORO XALQARO
                </h5>
                <h5 className="mb-0 text-white text-2xl font-semibold md:text-3xl leading-tight text-center">
                  UNIVERSITETI
                </h5>
              </div>
            </Link>
          </div>

          {/* Desktop Navigation */}
          <div className="hidden lg:flex items-center space-x-8 z-20">
            {Links.map((link, index) => (
              <Link
                key={index}
                to={link.path}
                className="text-white font-medium hover:text-blue-200 text-2xl transition-colors duration-200 no-underline px-3 py-1 rounded-md hover:bg-blue-600"
              >
                {link.name}
              </Link>
            ))}
          </div>

          {/* Desktop Contact & Social */}
          <div className="hidden lg:flex items-center space-x-6 z-30">
            <div className="flex flex-col items-end">
              <a
                href="tel:+998553099999"
                className="flex items-center text-white hover:text-blue-200 transition-colors duration-200 no-underline mb-2"
              >
                <FaPhoneAlt className="mr-2" />
                <span className="text-sm md:text-xl">+998 55 309-99-99</span>
              </a>
            </div>
          </div>
          <div className="absolute top-0 left-0 w-full overflow-hidden leading-[0] z-0">
            <svg
              viewBox="0 0 1200 120"
              preserveAspectRatio="none"
              className="block w-full h-[70px] lg:h-[90px]"
              xmlns="http://www.w3.org/2000/svg"
            >
              <path
                d="M0,0V46.29c47.79,22.2,103.59,32.17,158,28
         c70.36-5.37,136.33-33.31,206.8-37.5
         C438.64,32.43,512.34,53.67,583,72.05
         c69.27,18,138.3,24.88,209.4,13.08
         c36.15-6,69.85-17.84,104.45-29.34
         C989.49,25,1113-14.29,1200,52.47V0Z"
                fill="#172554"
                opacity="0.3"
              />
              <path
                d="M0,0V15.81
         C13,36.92,27.64,56.86,47.69,72.05
         c51.72,39.22,117.31,38.95,176.89,19.53
         c31.15-10.15,60.09-26.07,89.67-39.8
         c40.92-19,84.73-46,130.83-49.67
         c36.26-2.85,70.9,9.42,98.6,31.56
         c31.77,25.39,62.32,62,103.63,73
         c40.44,10.79,81.35-6.69,119.13-24.28
         s75.16-39,116.92-43.05
         c59.73-5.85,113.28,22.88,168.9,38.84
         c30.2,8.66,59,6.17,87.09-7.5
         c22.43-10.89,48-26.93,60.65-49.24V0Z"
                fill="#172554"
                opacity="0.5"
              />
              <path
                d="M0,0V5.63
         C149.93,59,314.09,71.32,475.83,42.57
         c43-7.64,84.23-20.12,127.61-26.46
         c59-8.63,112.48,12.24,165.56,35.4
         C827.93,77.22,886,95.24,951.2,90
         c86.53-7,172.46-45.71,248.8-84.81V0Z"
                fill="#172554"
              />
            </svg>
          </div>
          {/* Mobile Menu Button and Social Icons */}
          <div className="lg:hidden flex flex-col-reverse items-end space-x-4 z-40">
            {/* Mobile Menu Button */}
            <button
              onClick={toggleMenu}
              className="text-white focus:outline-none no-underline p-2"
              aria-label={menuOpen ? "Close menu" : "Open menu"}
            >
              {menuOpen ? <MdClose size={28} /> : <MdMenu size={28} />}
            </button>
          </div>
        </nav>

        {/* Mobile Menu Overlay */}
        {menuOpen && (
          <div className="lg:hidden fixed inset-0 bg-blue-900 bg-opacity-95 z-40 flex flex-col items-center pt-24 mobile-menu-container">
            {/* Close Button at top right */}
            <button
              onClick={closeMenu}
              className="absolute top-6 right-6 text-white text-2xl p-2"
              aria-label="Close menu"
            >
              <MdClose size={28} />
            </button>

            {/* Navigation Links */}
            <div className="w-full flex flex-col items-center space-y-6">
              {Links.map((link, index) => (
                <Link
                  key={index}
                  to={link.path}
                  className="text-white text-2xl font-medium hover:text-blue-300 w-full text-center py-3 transition-colors duration-200 no-underline hover:bg-blue-800 rounded-lg"
                  onClick={closeMenu}
                >
                  {link.name}
                </Link>
              ))}
            </div>

            {/* Phone Number */}
            <div className="mt-8">
              <a
                href="tel:+998553099999"
                className="flex items-center text-white text-xl hover:text-blue-300 transition-colors duration-200 no-underline bg-blue-800 px-6 py-3 rounded-lg"
                onClick={closeMenu}
              >
                <FaPhoneAlt className="mr-3" />
                +998 55 309-99-99
              </a>
            </div>

            {/* Social Icons */}
            <div className="mt-10 flex justify-center space-x-6">
              {socialLinks.map((social, index) => (
                <a
                  key={index}
                  href={social.url}
                  target="_blank"
                  rel="noopener noreferrer"
                  className={`text-white text-3xl ${social.color} transition-colors duration-200 no-underline p-2 hover:bg-blue-800 rounded-full`}
                  onClick={closeMenu}
                >
                  <i className={`fa-brands ${social.icon}`}></i>
                </a>
              ))}
            </div>
          </div>
        )}
      </div>

      <div className="bg-blue-950">
        {/* 🔵 Desktop versiyasi */}
        <div className="hidden lg:block max-w-7xl mx-auto">
          <Slider {...sliderSettings}>
            {allLinks.map((social, index) => (
              <div key={`desktop-slide-${index}`} className="py-2">
                <div className="flex justify-center">
                  <a
                    href={social.url}
                    target="_blank"
                    rel="noopener noreferrer"
                    className={`text-3xl ${social.textcolor} ${social.color} transition-colors duration-200 no-underline whitespace-nowrap`}
                  >
                    <i className={`${social.icon}`}></i>{" "}
                    <span className="hidden md:inline">{social.text}</span>
                  </a>
                </div>
              </div>
            ))}
          </Slider>
        </div>

        {/* 📱 Mobil versiyasi */}
        <div className="block lg:hidden max-w-7xl mx-auto px-4">
          <Slider {...sliderSettings}>
            {allLinks.map((social, index) => (
              <div key={`mobile-slide-${index}`} className="py-2">
                <div className="flex justify-center">
                  <a
                    href={social.url}
                    target="_blank"
                    rel="noopener noreferrer"
                    className={`text-3xl ${social.textcolor} ${social.color} transition-colors duration-200 no-underline`}
                  >
                    <i className={`${social.icon}`}></i>
                  </a>
                </div>
              </div>
            ))}
          </Slider>
        </div>
      </div>
    </header>
  );
}

export default Header;
