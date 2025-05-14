import React, { useEffect, useState } from "react";
import { useLocation, useNavigate } from "react-router-dom";
import Header from "../header/Header";
import Footer from "../footer/Footer";
import bg from "./images/back.jpg";
import ApiCall, { baseUrl } from "../../config";
import Zoom from "react-reveal/Zoom";
import { CiPhone } from "react-icons/ci";
import Select from "react-select";

function ForeignForm() {
  const navigate = useNavigate();
  const location = useLocation();
  const phone = location.state?.phone || "";
  const [showForm, setShowForm] = useState(true);
  const [formData, setFormData] = useState(null);
  const [appealType, setAppealType] = useState([]);
  const [educationType, setEducationType] = useState([]);
  const [educationForm, setEducationForm] = useState([]);
  const [educationField, setEducationField] = useState([]);
  const [regions, setRegions] = useState([]);
  const [districts, setDistricts] = useState([]);
  const [loadingDistricts, setLoadingDistricts] = useState(false);
  const [tel, setTel] = useState("+");
  const [abuturient, setAbuturient] = useState({
    firstName: "",
    lastName: "",
    fatherName: "",
    phone: tel || "",
    additionalPhone: "",
    language: true,
    appealTypeId: "",
    educationTypeId: "",
    educationFormId: "",
    educationFieldId: "",
    status: 0,
    country: "",
    city: "",
    createdAt: new Date().toISOString(),
  });

  useEffect(() => {
    fetchRegions();
    // getPhoneData();
    getAppealType();
    getEducationType();
  }, []);

  const fetchRegions = async () => {
    try {
      const response = await ApiCall("/api/v1/region", "GET", null, null);
      setRegions(
        response.data.map((region) => ({
          value: region.id,
          label: region.name,
        }))
      );
    } catch (error) {
      console.error("Error fetching regions:", error);
    }
  };

  // const fetchRegionDistricts = async (regionId) => {
  //   setLoadingDistricts(true);
  //   try {
  //     const response = await ApiCall(
  //       `/api/v1/district/${regionId}`,
  //       "GET",
  //       null,
  //       null
  //     );
  //     setDistricts(
  //       response.data.map((district) => ({
  //         value: district.id,
  //         label: district.name,
  //       }))
  //     );
  //   } catch (error) {
  //     console.error("Error fetching districts:", error);
  //   } finally {
  //     setLoadingDistricts(false);
  //   }
  // };

  // const getPhoneData = async () => {
  //   try {
  //     const response = await ApiCall(
  //       `/api/v1/abuturient/${phone}`,
  //       "GET",
  //       null,
  //       null,
  //       true
  //     );
  //     if (response.data === null) {
  //       setShowForm(true);
  //     } else if (response.data) {
  //       setFormData(response.data);
  //       setShowForm(false);
  //     }
  //   } catch (error) {
  //     console.error("Error fetching data:", error);
  //   }
  // };

  const getAppealType = async () => {
    try {
      const response = await ApiCall(
        `/api/v1/appeal-type`,
        "GET",
        null,
        null,
        true
      );
      setAppealType(
        response.data.map((type) => ({
          value: type.id,
          label: type.name,
        }))
      );
    } catch (error) {
      console.error("Error fetching appeal types:", error);
    }
  };

  const getEducationType = async () => {
    try {
      const response = await ApiCall(
        `/api/v1/education-type`,
        "GET",
        null,
        null,
        true
      );
      setEducationType(
        response.data.map((type) => ({
          value: type.id,
          label: type.name,
        }))
      );
    } catch (error) {
      console.error("Error fetching education types:", error);
    }
  };

  const getEducationForm = async (id) => {
    try {
      const response = await ApiCall(
        `/api/v1/education-form/${id}`,
        "GET",
        null,
        null,
        true
      );
      setEducationForm(
        response.data.map((form) => ({
          value: form.id,
          label: form.name,
        }))
      );
    } catch (error) {
      console.error("Error fetching education forms:", error);
    }
  };

  // const getEducationField = async (id) => {
  //     try {
  //         const response = await ApiCall(`/api/v1/education-field/${id}`, "GET", null, null, true);
  //         setEducationField(response.data.map(field => ({
  //             value: field.id,
  //             label: field.name
  //         })));
  //     } catch (error) {
  //         console.error("Error fetching education fields:", error);
  //     }
  // };

  const getEducationField = async (id) => {
    try {
      const response = await ApiCall(
        `/api/v1/education-field/${id}`,
        "GET",
        null,
        null,
        true
      );
      setEducationField(
        response.data
          .filter((field) => field.isActive === true) // Filter only active fields
          .map((field) => ({
            value: field.id,
            label: field.name,
            status: field.isActive, // Include status in the option object
          }))
      );
    } catch (error) {
      console.error("Error fetching education fields:", error);
    }
  };
  const handleSave = async (e) => {
    e.preventDefault();
    if (
      !abuturient.firstName ||
      !abuturient.lastName ||
      !abuturient.phone ||
      !abuturient.appealTypeId ||
      !abuturient.educationTypeId ||
      !abuturient.educationFormId ||
      !abuturient.educationFieldId ||
      !abuturient.country ||
      !abuturient.city
    ) {
      alert("Iltimos, barcha maydonlarni to'ldiring!");
      return;
    }

    try {
      const response = await ApiCall(
        `/api/v1/abuturient/foreign`,
        "POST",
        abuturient,
        null,
        true
      );
      setFormData(response.data);
      setShowForm(false);
    } catch (error) {
      console.error("Error saving data:", error);
      alert("Xatolik yuz berdi. Ma'lumotni saqlashning iloji bo'lmadi.");
    }
  };

  const handleChange = (e) => {
    let value = e.target.value;

    // Only allow digits after the initial +998
    if (value.length >= 20) return;

    if (value.startsWith("+") && /^\+\d{0,20}$/.test(value)) {
      if (value.length <= 20) setTel(value);
    } else if (value === "+") {
      setTel(value);
    } else {
      setTel("+");
    }
  };

  const handleInputChange = (e) => {
    const { name, value } = e.target;
    if (name === "phone") {
      if (value.length > 20) return; // Limit the length of the phone number
      if (value.startsWith("+") && /^\+\d{0,20}$/.test(value)) {
        if (value.length <= 20) setTel(value);
      } else if (value === "+") {
        setTel(value);
      } else {
        setTel("+");
      }
    }
    setAbuturient({ ...abuturient, [name]: value });
  };

  const handleSelectChange = (selectedOption, { name }) => {
    setAbuturient({ ...abuturient, [name]: selectedOption.value });

    if (name === "educationTypeId") {
      getEducationForm(selectedOption.value);
      setAbuturient((prev) => ({
        ...prev,
        educationFormId: "",
        educationFieldId: "",
      }));
      setEducationForm([]);
      setEducationField([]);
    } else if (name === "educationFormId") {
      getEducationField(selectedOption.value);
      setAbuturient((prev) => ({
        ...prev,
        educationFieldId: "",
      }));
      setEducationField([]);
    } else if (name === "country") {
      // fetchRegionDistricts(selectedOption.value);
      setAbuturient((prev) => ({
        ...prev,
        city: "",
      }));
      setDistricts([]);
    }
  };

  const handleNavigate = () => {
    // localStorage'ni tozalash shart emas
    // Kerakli ma'lumotlarni saqlab qolamiz
    localStorage.setItem("phone", formData?.phone || phone);

    navigate("/test", {
      state: {
        phone: formData?.phone || phone,
      },
    });
  };

  const handleDownloadPDF = async () => {
    try {
      const response = await fetch(
        `${baseUrl}/api/v1/abuturient/contract/${phone}`,
        {
          method: "GET",
        }
      );

      if (!response.ok) {
        throw new Error("Failed to download file");
      }

      const contentType = response.headers.get("Content-Type");
      if (!contentType || !contentType.includes("application/pdf")) {
        throw new Error("The response is not a valid PDF file.");
      }

      const blob = await response.blob();
      if (!blob.size) {
        throw new Error("The PDF file is empty.");
      }

      const downloadUrl = window.URL.createObjectURL(blob);
      const link = document.createElement("a");
      link.href = downloadUrl;
      link.download = `Contract_${phone}.pdf`;
      document.body.appendChild(link);
      link.click();
      link.remove();
      window.URL.revokeObjectURL(downloadUrl);
    } catch (error) {
      console.error("Error downloading PDF:", error);
    }
  };

  const customStyles = {
    control: (provided) => ({
      ...provided,
      minHeight: "40px",
      borderRadius: "0.375rem",
      borderColor: "#d1d5db",
      "&:hover": {
        borderColor: "#3b82f6",
      },
      boxShadow: "none",
    }),
    option: (provided, state) => ({
      ...provided,
      backgroundColor: state.isSelected ? "#3b82f6" : "white",
      color: state.isSelected ? "white" : "#1f2937",
      "&:hover": {
        backgroundColor: "#e5e7eb",
      },
    }),
    menu: (provided) => ({
      ...provided,
      zIndex: 9999,
      position: "absolute",
      marginTop: "0.25rem",
    }),
    menuPortal: (provided) => ({
      ...provided,
      zIndex: 9999,
    }),
  };
  return (
    <div>
      <Header />
      <div className="header-problem my-bg-second"></div>
      <div className="h-full">
        <div
          className="bg-fixed bg-cover bg-center"
          style={{ backgroundImage: `url(${bg})` }}
        >
          <section
            className="overlay bg-black bg-opacity-50 pt-24"
            data-stellar-background-ratio="0.5"
          >
            <div className="container mx-auto px-4 ">
              <div className="row">
                <div className="col-lg-12 col-md-12 col-12 text-center text-white my-10 ">
                  <div className="mt-16">
                    {showForm ? (
                      <Zoom>
                        <div className="bg-white p-6 md:p-8 rounded-lg shadow-lg w-full max-w-4xl mx-auto text-gray-800">
                          <h2 className="text-2xl font-bold mb-6 text-center">
                            Ro'yxatdan o'tish (Регистрация)
                          </h2>
                          <form onSubmit={handleSave} className="space-y-6">
                            <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                              {/* First Name */}
                              <div>
                                <label className="block text-sm font-medium text-gray-700 mb-1">
                                  Ism(Имя)
                                </label>
                                <input
                                  type="text"
                                  name="firstName"
                                  value={abuturient.firstName}
                                  onChange={handleInputChange}
                                  className="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500"
                                  required
                                />
                              </div>

                              {/* Last Name */}
                              <div>
                                <label className="block text-sm font-medium text-gray-700 mb-1">
                                  Familiya(Фамилия)
                                </label>
                                <input
                                  type="text"
                                  name="lastName"
                                  value={abuturient.lastName}
                                  onChange={handleInputChange}
                                  className="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500"
                                  required
                                />
                              </div>

                              {/* Father's Name */}
                              <div>
                                <label className="block text-sm font-medium text-gray-700 mb-1">
                                  Sharif(Отчество)
                                </label>
                                <input
                                  type="text"
                                  name="fatherName"
                                  value={abuturient.fatherName}
                                  onChange={handleInputChange}
                                  className="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500"
                                />
                              </div>

                              {/* Phone */}
                              <div>
                                <label className="block text-sm font-medium text-gray-700 mb-1">
                                  Telefon raqami(Номер телефона)
                                </label>
                                <input
                                  type="text"
                                  name="phone"
                                  onChange={handleInputChange}
                                  value={tel}
                                  aria-describedby="helper-text-explanation"
                                  className="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500 bg-gray-100"
                                  required
                                />
                              </div>

                              {/* Region */}
                              <div>
                                <label className="block text-sm font-medium text-gray-700 mb-1">
                                  Davlat(Страна)
                                </label>
                                <input
                                  type="text"
                                  name="country"
                                  value={abuturient.country}
                                  onChange={handleInputChange}
                                  className="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500"
                                  required
                                />
                              </div>

                              {/* District */}
                              <div>
                                {/* <label className="block text-sm font-medium text-gray-700 mb-1">
                                  Tuman/Shahar
                                </label>
                                <Select
                                  name="districtId"
                                  value={districts.find(
                                    (option) =>
                                      option.value === abuturient.districtId
                                  )}
                                  onChange={handleSelectChange}
                                  options={districts}
                                  placeholder={
                                    loadingDistricts
                                      ? "Yuklanmoqda..."
                                      : "Tuman/Shaharni tanlang"
                                  }
                                  isDisabled={
                                    !abuturient.regionId || loadingDistricts
                                  }
                                  isSearchable
                                  styles={customStyles}
                                  required
                                /> */}
                                <label className="block text-sm font-medium text-gray-700 mb-1">
                                  Shahar(Город)
                                </label>
                                <input
                                  type="text"
                                  name="city"
                                  value={abuturient.city}
                                  onChange={handleInputChange}
                                  className="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500"
                                  required
                                />
                              </div>

                              {/* Appeal Type */}
                              <div>
                                <label className="block text-sm font-medium text-gray-700 mb-1">
                                  Ariza turi(Тип обращения)
                                </label>
                                <Select
                                  name="appealTypeId"
                                  value={appealType.find(
                                    (option) =>
                                      option.value === abuturient.appealTypeId
                                  )}
                                  onChange={handleSelectChange}
                                  options={appealType}
                                  placeholder="Ariza turini tanlang"
                                  isSearchable
                                  styles={customStyles}
                                  required
                                />
                              </div>

                              {/* Education Type */}
                              <div>
                                <label className="block text-sm font-medium text-gray-700 mb-1">
                                  Ta'lim turi(Тип образования)
                                </label>
                                <Select
                                  name="educationTypeId"
                                  value={educationType.find(
                                    (option) =>
                                      option.value ===
                                      abuturient.educationTypeId
                                  )}
                                  onChange={handleSelectChange}
                                  options={educationType}
                                  placeholder="Ta'lim turini tanlang"
                                  isSearchable
                                  styles={customStyles}
                                  required
                                />
                              </div>

                              {/* Education Form */}
                              <div>
                                <label className="block text-sm font-medium text-gray-700 mb-1">
                                  Ta'lim shakli(Форма обучения)
                                </label>
                                <Select
                                  name="educationFormId"
                                  value={educationForm.find(
                                    (option) =>
                                      option.value ===
                                      abuturient.educationFormId
                                  )}
                                  onChange={handleSelectChange}
                                  options={educationForm}
                                  placeholder={
                                    abuturient.educationTypeId
                                      ? "Ta'lim shaklini tanlang"
                                      : "Avval ta'lim turini tanlang"
                                  }
                                  isDisabled={!abuturient.educationTypeId}
                                  isSearchable
                                  styles={customStyles}
                                  required
                                />
                              </div>

                              {/* Education Field */}
                              <div>
                                <label className="block text-sm font-medium text-gray-700 mb-1 z-auto">
                                  Yo'nalish(Направление)
                                </label>
                                <Select
                                  name="educationFieldId"
                                  value={educationField.find(
                                    (option) =>
                                      option.value ===
                                      abuturient.educationFieldId
                                  )}
                                  onChange={handleSelectChange}
                                  options={educationField}
                                  placeholder={
                                    abuturient.educationFormId
                                      ? "Yo'nalishni tanlang"
                                      : "Avval ta'lim shaklini tanlang"
                                  }
                                  isDisabled={!abuturient.educationFormId}
                                  isSearchable
                                  styles={customStyles}
                                  menuPortalTarget={document.body}
                                  menuPosition="fixed"
                                  required
                                />
                              </div>
                            </div>

                            {/* Save Button */}
                            <div className="text-center pt-4">
                              <button
                                type="submit"
                                className="bg-blue-600 hover:bg-blue-700 text-white font-medium py-2 px-6 rounded-lg transition duration-300 ease-in-out transform hover:scale-105"
                              >
                                Saqlash(Сохранять)
                              </button>
                            </div>
                          </form>
                        </div>
                      </Zoom>
                    ) : (
                      <div className="bg-white p-6 rounded-lg shadow-lg w-full max-w-2xl mx-auto text-gray-800">
                        <h2 className="text-2xl font-bold mb-6 text-center flex items-center justify-center">
                          <svg
                            className="w-6 h-6 mr-2 text-blue-600"
                            fill="none"
                            stroke="currentColor"
                            viewBox="0 0 24 24"
                            xmlns="http://www.w3.org/2000/svg"
                          >
                            <path
                              strokeLinecap="round"
                              strokeLinejoin="round"
                              strokeWidth={2}
                              d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"
                            />
                          </svg>
                          Mavjud ma'lumotlar
                        </h2>
                        <div className="space-y-4">
                          {/* First Name */}
                          <div className="flex items-center space-x-4">
                            <svg
                              className="w-5 h-5 text-gray-600"
                              fill="none"
                              stroke="currentColor"
                              viewBox="0 0 24 24"
                              xmlns="http://www.w3.org/2000/svg"
                            >
                              <path
                                strokeLinecap="round"
                                strokeLinejoin="round"
                                strokeWidth={2}
                                d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"
                              />
                            </svg>
                            <p className={"my-1"}>
                              <strong>FIO:</strong>{" "}
                              {formData?.lastName || "Noma'lum"}{" "}
                              {formData?.firstName || "Noma'lum"}{" "}
                              {formData?.fatherName || ""}
                            </p>
                          </div>

                          {/* Phone */}
                          <div className="flex items-center space-x-4">
                            <svg
                              className="w-5 h-5 text-gray-600"
                              fill="none"
                              stroke="currentColor"
                              viewBox="0 0 24 24"
                              xmlns="http://www.w3.org/2000/svg"
                            >
                              <path
                                strokeLinecap="round"
                                strokeLinejoin="round"
                                strokeWidth={2}
                                d="M3 5a2 2 0 012-2h3.28a1 1 0 01.948.684l1.498 4.493a1 1 0 01-.502 1.21l-2.257 1.13a11.042 11.042 0 005.516 5.516l1.13-2.257a1 1 0 011.21-.502l4.493 1.498a1 1 0 01.684.949V19a2 2 0 01-2 2h-1C9.716 21 3 14.284 3 6V5z"
                              />
                            </svg>
                            <p className={"my-1"}>
                              <strong>Telefon:</strong> {formData?.phone}
                            </p>
                          </div>

                          {/* Region and District */}
                          {formData?.district && (
                            <div className="flex items-center space-x-4">
                              <svg
                                className="w-5 h-5 text-gray-600"
                                fill="none"
                                stroke="currentColor"
                                viewBox="0 0 24 24"
                                xmlns="http://www.w3.org/2000/svg"
                              >
                                <path
                                  strokeLinecap="round"
                                  strokeLinejoin="round"
                                  strokeWidth={2}
                                  d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z"
                                />
                                <path
                                  strokeLinecap="round"
                                  strokeLinejoin="round"
                                  strokeWidth={2}
                                  d="M15 11a3 3 0 11-6 0 3 3 0 016 0z"
                                />
                              </svg>
                              <p className={"my-1"}>
                                <strong>Manzil:</strong>{" "}
                                {formData?.district.region?.name || "Noma'lum"},{" "}
                                {formData?.district?.name || "Noma'lum"}
                              </p>
                            </div>
                          )}

                          {/* turi */}
                          <div className="flex items-center space-x-4">
                            <svg
                              className="w-5 h-5 text-gray-600"
                              fill="none"
                              stroke="currentColor"
                              viewBox="0 0 24 24"
                              xmlns="http://www.w3.org/2000/svg"
                            >
                              <path
                                strokeLinecap="round"
                                strokeLinejoin="round"
                                strokeWidth={2}
                                d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z"
                              />
                            </svg>
                            <p className={"my-1"}>
                              <strong>Ta'lim turi:</strong>{" "}
                              {formData?.educationField?.educationForm
                                ?.educationType.name || "Noma'lum"}
                            </p>
                          </div>

                          {/* shakli */}
                          <div className="flex items-center space-x-4">
                            <svg
                              className="w-5 h-5 text-gray-600"
                              fill="none"
                              stroke="currentColor"
                              viewBox="0 0 24 24"
                              xmlns="http://www.w3.org/2000/svg"
                            >
                              <path
                                strokeLinecap="round"
                                strokeLinejoin="round"
                                strokeWidth={2}
                                d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z"
                              />
                            </svg>
                            <p className={"my-1"}>
                              <strong>Ta'lim shakli:</strong>{" "}
                              {formData?.educationField?.educationForm?.name ||
                                "Noma'lum"}
                            </p>
                          </div>

                          {/* Yo'nalish */}
                          <div className="flex items-center space-x-4">
                            <svg
                              className="w-5 h-5 text-gray-600"
                              fill="none"
                              stroke="currentColor"
                              viewBox="0 0 24 24"
                              xmlns="http://www.w3.org/2000/svg"
                            >
                              <path
                                strokeLinecap="round"
                                strokeLinejoin="round"
                                strokeWidth={2}
                                d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z"
                              />
                            </svg>
                            <p className={"my-1"}>
                              <strong>Yo'nalishi:</strong>{" "}
                              {formData?.educationField?.name || "Noma'lum"}
                            </p>
                          </div>

                          {/* Ariza turi */}
                          <div className="flex items-center space-x-4">
                            <svg
                              className="w-5 h-5 text-gray-600"
                              fill="none"
                              stroke="currentColor"
                              viewBox="0 0 24 24"
                              xmlns="http://www.w3.org/2000/svg"
                            >
                              <path
                                strokeLinecap="round"
                                strokeLinejoin="round"
                                strokeWidth={2}
                                d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2"
                              />
                            </svg>
                            <p className={"my-1"}>
                              <strong>Ariza turi:</strong>{" "}
                              {formData?.appealType?.name || "Noma'lum"}
                            </p>
                          </div>

                          {/* Test Status and Actions */}
                          <div className="mt-6">
                            {formData?.status >= 3 ? (
                              <div className="text-center">
                                <div className="flex items-center justify-center space-x-2 mb-4">
                                  <svg
                                    className="w-6 h-6 text-green-600"
                                    fill="none"
                                    stroke="currentColor"
                                    viewBox="0 0 24 24"
                                    xmlns="http://www.w3.org/2000/svg"
                                  >
                                    <path
                                      strokeLinecap="round"
                                      strokeLinejoin="round"
                                      strokeWidth={2}
                                      d="M5 13l4 4L19 7"
                                    />
                                  </svg>
                                  <p className="text-lg font-semibold">
                                    Siz testdan o'tgansiz
                                  </p>
                                </div>
                                {formData.getContract && (
                                  <button
                                    onClick={handleDownloadPDF}
                                    className="bg-blue-600 text-white px-4 py-2 rounded-lg hover:bg-blue-700 transition duration-300 flex items-center justify-center space-x-2 mx-auto"
                                  >
                                    <svg
                                      className="w-5 h-5"
                                      fill="none"
                                      stroke="currentColor"
                                      viewBox="0 0 24 24"
                                      xmlns="http://www.w3.org/2000/svg"
                                    >
                                      <path
                                        strokeLinecap="round"
                                        strokeLinejoin="round"
                                        strokeWidth={2}
                                        d="M4 16v1a3 3 0 003 3h10a3 3 0 003-3v-1m-4-4l-4 4m0 0l-4-4m4 4V4"
                                      />
                                    </svg>
                                    <span>Shartnomani yuklab olish</span>
                                  </button>
                                )}
                              </div>
                            ) : formData?.educationField?.educationForm
                                ?.educationType.id === 2 ? (
                              <div>
                                <div
                                  className={"bg-cyan-100 p-4 m-4 rounded-lg"}
                                >
                                  <h3 className="font-medium">
                                    Ijodiy imtihonni topshirish uchun siz
                                    institutga markaziy binosiga tashrif
                                    buyurishingiz so'raladi.
                                  </h3>
                                  <h4 className="mt-2 font-medium">
                                    Manzil: Buxoro shahri Sitorayi Mohi-Xosa MFY
                                    G'ijduvon ko'chasi 250-uy
                                  </h4>

                                  <div className="flex-1 min-w-[250px] border-r pr-4">
                                    <div className="flex items-center gap-2 mt-3">
                                      <CiPhone className="text-dark text-2xl" />
                                      <a
                                        className="text-dark hover:text-blue-600"
                                        href="tel:+998553099999"
                                      >
                                        +998 55 309-99-99
                                      </a>
                                    </div>
                                    <div className="flex items-center gap-2 mb-4">
                                      <CiPhone className="text-dark text-2xl" />
                                      <a
                                        className="text-dark hover:text-blue-600"
                                        href="tel:+998 55 305-55-55"
                                      >
                                        +998 55 305-55-55
                                      </a>
                                    </div>
                                    <iframe
                                      src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3064.8958577959097!2d64.42846967583635!3d39.80932777154381!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3f5009003f1c477b%3A0x920d498788a13e58!2sBuxoro%20psixologiya%20va%20xorijiy%20tillar%20instituti!5e0!3m2!1sru!2s!4v1728054121217!5m2!1sru!2s"
                                      width="100%"
                                      height="250"
                                      allowFullScreen=""
                                      loading="lazy"
                                      className="rounded-lg border-0"
                                      referrerPolicy="no-referrer-when-downgrade"
                                    ></iframe>
                                  </div>
                                </div>
                              </div>
                            ) : (
                              <div className="text-center">
                                <button
                                  onClick={handleNavigate}
                                  className="bg-blue-600 hover:bg-blue-700 text-white px-6 py-2 rounded-lg transition duration-300 ease-in-out transform hover:scale-105 flex items-center justify-center space-x-2 mx-auto"
                                >
                                  <svg
                                    className="w-5 h-5"
                                    fill="none"
                                    stroke="currentColor"
                                    viewBox="0 0 24 24"
                                    xmlns="http://www.w3.org/2000/svg"
                                  >
                                    <path
                                      strokeLinecap="round"
                                      strokeLinejoin="round"
                                      strokeWidth={2}
                                      d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2m-6 9l2 2 4-4"
                                    />
                                  </svg>
                                  <span>Test topshirish</span>
                                </button>
                              </div>
                            )}
                          </div>
                        </div>
                      </div>
                    )}
                  </div>
                </div>
              </div>
            </div>
          </section>
        </div>
      </div>
      <Footer />
    </div>
  );
}

export default ForeignForm;
