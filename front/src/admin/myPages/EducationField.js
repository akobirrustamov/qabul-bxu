    import React, { useState, useEffect } from "react";
    import ApiCall from "../../config";
    import Sidebar from "./Sidebar";
    import { Modal } from "react-responsive-modal";
    import "react-responsive-modal/styles.css";

    const EducationField = () => {
        const [educationFields, setEducationFields] = useState([]);
        const [educationForms, setEducationForms] = useState([]);
        const [modalOpen, setModalOpen] = useState(false);
        const [modalOpenSubject, setModalOpenSubject] = useState(false);
        const [filterText, setFilterText] = useState(""); // For search input
        const [subject1, setSubject1] = useState([])
        const [subject2, setSubject2] = useState([])
        const [educationFieldTestSubject, setEducationFieldTestSubject] = useState({
            fieldId:null,
            test1:null,
            test2:null,
            test3:null,
            test4:null,
            test5:null,
        })


        const [formData, setFormData] = useState({
            id: null,
            name: "",
            educationFormId: "",
            educationDuration: "",
            price: "",
            isActive: true,
        });
        const [filter, setFilter] = useState(""); // For educationFormId filter

        useEffect(() => {
            fetchEducationFields();
            fetchEducationForms();
            getEducationStatus1()
            getEducationStatus2()
        }, []);

        const fetchEducationFields = async () => {
            try {
                const response = await ApiCall("/api/v1/education-field", "GET", null, null, true);
                setEducationFields(response.data);
            } catch (error) {
                console.error("Error fetching education fields:", error);
            }
        };

        const fetchEducationForms = async () => {
            try {
                const response = await ApiCall("/api/v1/education-form", "GET", null, null, true);
                setEducationForms(response.data);
            } catch (error) {
                console.error("Error fetching education forms:", error);
            }
        };
        const handleAddOrEdit = async () => {
            const endpoint = formData.id
                ? `/api/v1/education-field/${formData.id}`
                : "/api/v1/education-field";
            const method = formData.id ? "PUT" : "POST";

            try {
                await ApiCall(endpoint, method, formData, null, true);
                fetchEducationFields();
                setModalOpen(false);
                setFormData({
                    id: null,
                    name: "",
                    educationFormId: "",
                    educationDuration: "",
                    price: "",
                    isActive: true,
                });
            } catch (error) {
                console.error("Error saving education field:", error);
            }
        };

        const handleDelete = async (id) => {
            try {
                await ApiCall(`/api/v1/education-field/${id}`, "DELETE", null, null, true);
                fetchEducationFields();
            } catch (error) {
                console.error("Error deleting education field:", error);
            }
        };

        const handleEdit = (field) => {
            setFormData({...field, educationFormId: field.educationForm.id});
            setModalOpen(true);
        };

        const handleFilterChange = (e) => {
            setFilter(e.target.value);
        };

        const handleSearchChange = (e) => {
            setFilterText(e.target.value); // Update filterText state on input change
        };

        // Filter education fields by name and educationFormId
        const filteredFields = educationFields.filter((field) => {
            const matchesName = field.name.toLowerCase().includes(filterText.toLowerCase());
            const matchesEducationForm = filter
                ? field.educationForm?.id.toString() === filter // Filter by educationFormId if filter is set
                : true;
            return matchesName && matchesEducationForm;
        });


        const handleChangeStatus = async(id) =>{
            try {
                const response = await ApiCall(`/api/v1/education-field/status/${id}`, "PUT", null, null, true);
                fetchEducationFields();
            } catch (error) {
                console.error("Error deleting education field:", error);
            }

        }
        const getEducationStatus1 = async() =>{
            try {
                const response = await ApiCall(`/api/v1/subject-test/${1}`, "GET", null, null, true);

                setSubject1(response.data)

            } catch (error) {
                console.error("Error deleting education field:", error);
            }

        }
        const getEducationStatus2 = async() =>{
            try {
                const response = await ApiCall(`/api/v1/subject-test/${2}`, "GET", null, null, true);
                setSubject2(response.data)

            } catch (error) {
                console.error("Error deleting education field:", error);
            }

        }

        const handleSendTest = async ()=>{
            try {
                console.log("dssdds")
                const response = await ApiCall(`/api/v1/test-educationfield`, "POST", educationFieldTestSubject, null, true);
                // alert(JSON.stringify(response.data))
            } catch (error) {
                console.error("Error deleting education field:", error);
            }
        }


        return (
            <div>
                <Sidebar />
                <div className="p-10 sm:ml-64">
                    <div className="flex justify-between items-center mb-4">
                        <h2 className="text-3xl md:text-4xl xl:text-5xl">Ta'lim yo'nalishlari</h2>
                        <div className="flex items-center gap-4">

                            <select
                                value={filter}
                                onChange={handleFilterChange} // Update filter on select change
                                className="border px-1 py-1 rounded"
                            >
                                <option value="">Barchasi</option> {/* Option for no filtering */}
                                {educationForms.map((form) => (
                                    <option key={form.id} value={form.id}>
                                        {form.name}, {form.educationType.name}
                                    </option>
                                ))}
                            </select>

                            {/* Search input for filtering by name */}
                            <input
                                type="text"
                                placeholder="Yo'nalish nomi..."
                                className="border px-1 py-1 rounded"
                                value={filterText}
                                onChange={handleSearchChange} // Update filterText state on input change
                            />

                            <button
                                className="bg-blue-500 text-white px-1 py-1 rounded"
                                onClick={() => setModalOpen(true)}
                            >
                                Yangi qo'shish
                            </button>
                        </div>
                    </div>

                    <div className="mt-4">
                        <table className="min-w-full table-auto border-collapse border border-gray-300">
                            <thead>
                            <tr className="bg-gray-200">
                                <th className="border border-gray-300 px-1 py-1 text-[14px]">N%</th>
                                <th className="border border-gray-300 px-1 py-1 text-[14px]">Yo'nalish nomi</th>
                                <th className="border border-gray-300 px-1 py-1 text-[14px]">Turi</th>
                                <th className="border border-gray-300 px-1 py-1 text-[14px]">Shakli</th>
                                <th className="border border-gray-300 px-1 py-1 text-[14px]">Davomiyligi</th>
                                <th className="border border-gray-300 px-1 py-1 text-[14px]">Kontrakt summasi</th>
                                <th className="border border-gray-300 px-1 py-1 text-[14px]">Test</th>
                                <th className="border border-gray-300 px-1 py-1 text-[14px]">Faolligi</th>
                                <th className="border border-gray-300 px-1 py-1 text-[14px]"></th>
                            </tr>
                            </thead>
                            <tbody>
                            {filteredFields.map((field, index) => (
                                <tr key={field.id} >
                                    <td className="border border-gray-300 px-1 py-1 text-[14px]">{index + 1}</td>
                                    <td className="border border-gray-300 px-1 py-1 text-[12px]">{field.name}</td>
                                    <td className="border border-gray-300 px-1 py-1 text-[14px]">{field.educationForm.educationType.name}</td>
                                    <td className="border border-gray-300 px-1 py-1 text-[14px]">{field.educationForm?.name}</td>
                                    <td className="border border-gray-300 px-1 py-1 text-[14px]">{field.educationDuration}</td>
                                    <td className="border border-gray-300 px-1 py-1 text-[14px]">{field.price}</td>
                                    <td className="border border-gray-300 px-1 py-1 text-[14px]">{
                                        field.testEducationField===null?
                                    <button   className="bg-red-500 text-white px-2 py-1 rounded"
                                              onClick={()=>{
                                                setModalOpenSubject(!modalOpenSubject);
                                                  setEducationFieldTestSubject({...educationFieldTestSubject, fieldId: field.id, test1:  null, test2:  null, test3:  null, test4:  null, test5:  null});
                                              }}
                                    >qo'sish</button>:
                                            <button
                                                onClick={()=>{
                                                    setModalOpenSubject(!modalOpenSubject);
                                                    // alert(JSON.stringify( field.testEducationField))
                                                    setEducationFieldTestSubject({...educationFieldTestSubject, fieldId: field.id, test1:  field.testEducationField.test1.id, test2:  field.testEducationField.test2.id, test3:  field.testEducationField.test3.id, test4:  field.testEducationField.test4.id, test5:  field.testEducationField.test5.id,});
                                                }}
                                                className="bg-yellow-500 text-white px-2 py-1 rounded mr-2">tahrirlash</button>
                                    }</td>
                                    <td className="border border-gray-300 px-1 py-1 text-[14px]">
                                        <input
                                            checked={field.isActive}
                                            className="m-2"
                                            type="checkbox"
                                            onChange={()=>handleChangeStatus(field.id)}
                                        />
                                    </td>
                                    <td className="border border-gray-300 px-1 py-1 text-[14px]">

                                        <button
                                            className="bg-yellow-500 text-white px-2 py-1 rounded mr-2"

                                            onClick={() => handleEdit(field)}
                                        >
                                            Tahrirlash
                                        </button>
                                        {/*<button*/}
                                        {/*    className="bg-red-500 text-white px-2 py-1 rounded"*/}

                                        {/*    onClick={() => handleDelete(field.id)}*/}
                                        {/*>*/}
                                        {/*    O'chirish*/}
                                        {/*</button>*/}

                                    </td>
                                </tr>
                            ))}
                            </tbody>
                        </table>
                    </div>
                </div>

                <Modal
                    styles={{
                        modal: {
                            width: "400px", // Set modal width
                            maxWidth: "90%", // Ensure responsiveness for smaller screens
                            padding: "20px", // Optional: add padding inside modal
                        },
                    }}
                    open={modalOpen} onClose={() => setModalOpen(false)} center animationDuration={800}
                >
                    <h2 className="text-2xl mb-4">{formData.id ? "Tahrirlash" : "Qo'shish"}</h2>
                    <form
                        onSubmit={(e) => {
                            e.preventDefault();
                            handleAddOrEdit();
                        }}
                    >
                        <div className="mb-4">
                            <label className="block text-sm font-medium mb-2">Nomi</label>
                            <input
                                type="text"
                                value={formData.name}
                                onChange={(e) =>
                                    setFormData({ ...formData, name: e.target.value })
                                }
                                className="border px-1 py-1 rounded w-full"
                                required
                            />
                        </div>
                        <div className="mb-4">
                            <label className="block text-sm font-medium mb-2">Talim shakli</label>
                            <select
                                value={formData.educationFormId}
                                onChange={(e) =>
                                    setFormData({ ...formData, educationFormId: e.target.value })
                                }
                                className="border px-1 py-1 rounded w-full"
                                required
                            >
                                <option value="">Tanlang</option>
                                {educationForms.map((form) => (
                                    <option key={form.id} value={form.id}>
                                        {form.name}, {form.educationType.name}
                                    </option>
                                ))}
                            </select>
                        </div>
                        <div className="mb-4">
                            <label className="block text-sm font-medium mb-2">Davomiyligi</label>
                            <input
                                type="number"
                                value={formData.educationDuration}
                                onChange={(e) =>
                                    setFormData({ ...formData, educationDuration: e.target.value })
                                }
                                className="border px-1 py-1 rounded w-full"
                                required
                            />
                        </div>
                        <div className="mb-4">
                            <label className="block text-sm font-medium mb-2">Kontrakt narxi</label>
                            <input
                                type="text"
                                value={formData.price}
                                onChange={(e) =>
                                    setFormData({ ...formData, price: e.target.value })
                                }
                                className="border px-1 py-1 rounded w-full"
                                required
                            />
                        </div>
                        <button
                            type="submit"
                            className="bg-blue-500 text-white px-1 py-1 rounded"
                        >
                            {formData.id ? "Tahrirlash" : "Qo'shish"}
                        </button>
                    </form>
                </Modal>

                <Modal
                    styles={{
                        modal: {
                            width: "400px", // Set modal width
                            maxWidth: "90%", // Ensure responsiveness for smaller screens
                            padding: "20px", // Optional: add padding inside modal
                        },
                    }}
                    open={modalOpenSubject} onClose={() => setModalOpenSubject(false)} center animationDuration={800}
                >
                    <h2 className="text-2xl mb-4">{formData.id ? "Tahrirlash" : "Qo'shish"}</h2>
                    <form >
                        <div className="mb-4">
                            <label className="block text-sm font-medium mb-2">Fan 1 (Majburiy blok ) 1.1 bal</label>
                            <select
                                name="test1"
                                value={educationFieldTestSubject.test1}
                                onChange={(e) => setEducationFieldTestSubject({ ...educationFieldTestSubject, test1: e.target.value })}
                                className="border px-1 py-1 rounded w-full"
                            >
                                <option value="">Tanlang</option>
                                {subject1.map((subject) => (
                                    <option key={subject.id} value={subject.id}>
                                        {subject.name}
                                    </option>
                                ))}
                            </select>
                        </div>
                        <div className="mb-4">
                            <label className="block text-sm font-medium mb-2">Fan 2 (Majburiy blok) 1.1 bal</label>
                            <select
                                name="test2"
                                value={educationFieldTestSubject.test2}
                                onChange={(e) => setEducationFieldTestSubject({ ...educationFieldTestSubject, test2: e.target.value })}
                                className="border px-1 py-1 rounded w-full"
                            >
                                <option value="">Tanlang</option>
                                {subject1.map((subject) => (
                                    <option key={subject.id} value={subject.id}>
                                        {subject.name}
                                    </option>
                                ))}
                            </select>
                        </div>
                        <div className="mb-4">
                            <label className="block text-sm font-medium mb-2">Fan 3 (Majburiy blok) 1.1 bal</label>
                            <select
                                name="test3"
                                value={educationFieldTestSubject.test3}
                                onChange={(e) => setEducationFieldTestSubject({ ...educationFieldTestSubject, test3: e.target.value })}
                                className="border px-1 py-1 rounded w-full"
                            >
                                <option value="">Tanlang</option>
                                {subject1.map((subject) => (
                                    <option key={subject.id} value={subject.id}>
                                        {subject.name}
                                    </option>
                                ))}
                            </select>
                        </div>
                        <div className="mb-4">
                            <label className="block text-sm font-medium mb-2">Fan 4 (Asosiy blok) 2.1 bal</label>
                            <select
                                name="test4"
                                value={educationFieldTestSubject.test4}
                                onChange={(e) => setEducationFieldTestSubject({ ...educationFieldTestSubject, test4: e.target.value })}
                                className="border px-1 py-1 rounded w-full"
                            >
                                <option value="">Tanlang</option>
                                {subject2.map((subject) => (
                                    <option key={subject.id} value={subject.id}>
                                        {subject.name}
                                    </option>
                                ))}
                            </select>
                        </div>
                        <div className="mb-4">
                            <label className="block text-sm font-medium mb-2">Fan 5 (Asosiy blok) 3.1 bal</label>
                            <select
                                name="test5"
                                value={educationFieldTestSubject.test5}
                                onChange={(e) => setEducationFieldTestSubject({ ...educationFieldTestSubject, test5: e.target.value })}
                                className="border px-1 py-1 rounded w-full"
                            >
                                <option value="">Tanlang</option>
                                {subject2.map((subject) => (
                                    <option key={subject.id} value={subject.id}>
                                        {subject.name}
                                    </option>
                                ))}
                            </select>
                        </div>
                        <button
                            type="submit"
                            className="bg-blue-500 text-white px-1 py-1 rounded"
                            onClick={handleSendTest}
                        >
                            {formData.id ? "Tahrirlash" : "Qo'shish"}
                        </button>
                    </form>
                </Modal>







            </div>
        );
    };

    export default EducationField;
