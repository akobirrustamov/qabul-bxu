import React, { useEffect, useState } from "react";
import ApiCall from "../../config";

function Yonalishlar(props) {
  const [educationFields, setEducationFields] = useState([]);
  const [educationForms, setEducationForms] = useState([]);
  const [filterText, setFilterText] = useState(""); // For search input
  const [activeTab, setActiveTab] = useState(null); // Default tab (no "All" tab)
  const [uniqueEducationForms, setUniqueEducationForms] = useState([]); // Unique education form names and ids

  useEffect(() => {
    fetchEducationFields();
    fetchEducationForms();
  }, []);

  useEffect(() => {
    if (educationFields.length > 0) {
      // Extract unique education forms with their ids and names
      const forms = [
        ...new Map(
          educationFields.map((field) => [
            field.educationForm.id,
            field.educationForm,
          ])
        ).values(),
      ];
      setUniqueEducationForms(forms);
      setActiveTab(forms[0]?.id); // Set the first form's id as the default active tab
    }
  }, [educationFields]);

  const fetchEducationFields = async () => {
    try {
      const response = await ApiCall(
        "/api/v1/education-field",
        "GET",
        null,
        null,
        true
      );
      setEducationFields(response.data);
    } catch (error) {
      console.error("Error fetching education fields:", error);
    }
  };

  const fetchEducationForms = async () => {
    try {
      const response = await ApiCall(
        "/api/v1/education-form/1",
        "GET",
        null,
        null,
        true
      );
      setEducationForms(response.data);
    } catch (error) {
      console.error("Error fetching education forms:", error);
    }
  };

  const filteredFields = educationFields.filter((field) => {
    const matchesName = field.name
      .toLowerCase()
      .includes(filterText.toLowerCase());
    const matchesTab = activeTab
      ? field.educationForm?.id === activeTab
      : false;
    return matchesName && matchesTab;
  });

  return (
    <div className="h-full bg-white pt-40">
      <div className="p-4 md:p-6 lg:p-8 xl:p-10">
        <div className="text-center mb-4">
          <h2 className="text-2xl sm:text-3xl md:text-4xl xl:text-5xl font-bold">
            QABUL YO'NALISHLARI
          </h2>
          <p className="text-sm sm:text-md md:text-lg xl:text-xl mt-2">
            Oliygohimizning ta'lim yo'nalishlari bilan quyidagi jadval orqali
            tanishib chiqishingiz mumkin
          </p>
        </div>

        <div className="p-4 sm:p-6 md:p-8 lg:p-10 xl:p-12 pt-0 mx-auto">
          {/* Tabs */}
          <div className="tabs flex flex-wrap gap-2 mb-4 justify-center">
            {uniqueEducationForms.map((form) => (
              <span
                key={form.id}
                className={`tab px-3 py-1 sm:px-4 sm:py-2 cursor-pointer text-sm sm:text-base ${
                  activeTab === form.id
                    ? "bg-blue-500 text-white rounded"
                    : "bg-gray-200 hover:bg-gray-300 rounded"
                }`}
                onClick={() => setActiveTab(form.id)}
              >
                {form.educationType.name === "Magistr"
                  ? "Magistratura"
                  : form.name}
              </span>
            ))}
          </div>

          {/* Table */}
          <div className="overflow-x-auto">
            <table className="min-w-full table-auto border-collapse border border-gray-300 rounded-lg bg-[#EFF9FF]">
              <thead>
                <tr className="bg-[#EFF9FF]">
                  <th className="border border-gray-300 px-2 py-2 text-sm sm:text-base md:text-lg">
                    N%
                  </th>
                  <th className="border border-gray-300 px-2 py-2 text-sm sm:text-base md:text-lg">
                    Yo'nalish nomi
                  </th>
                  <th className="border border-gray-300 px-2 py-2 text-sm sm:text-base md:text-lg">
                    Davomiyligi
                  </th>
                  <th className="border border-gray-300 px-2 py-2 text-sm sm:text-base md:text-lg">
                    Kontrakt summasi
                  </th>
                </tr>
              </thead>
              <tbody>
                {filteredFields.map(
                  (field, index) =>
                    field.isActive === true && (
                      <tr
                        key={field.id}
                        className={`${
                          index % 2 === 0 ? "bg-white" : "bg-[#EFF9FF]"
                        } hover:bg-gray-50`}
                      >
                        <td className="border border-gray-300 px-2 py-2 text-sm sm:text-base md:text-lg">
                          {index + 1}
                        </td>
                        <td className="border border-gray-300 px-2 py-2 text-sm sm:text-base md:text-lg font-semibold">
                          {field.name}
                        </td>
                        <td className="border border-gray-300 px-2 py-2 text-sm sm:text-base md:text-lg">
                          {field.educationDuration}
                        </td>
                        <td className="border border-gray-300 px-2 py-2 text-sm sm:text-base md:text-lg">
                          {field.price}
                        </td>
                      </tr>
                    )
                )}
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
  );
}

export default Yonalishlar;
