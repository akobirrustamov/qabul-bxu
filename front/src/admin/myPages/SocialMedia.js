import React, { useState, useEffect } from "react";
import Sidebar from "./Sidebar";
import ApiCall, { baseUrl } from "../../config";
import { Modal } from "react-responsive-modal";

function SocialMedia() {
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [isEditModalOpen, setIsEditModalOpen] = useState(false); // Edit modal state
  const [galleryItems, setGalleryItems] = useState([]); // Backenddan kelgan rasm va videolar
  const [newFile, setNewFile] = useState(null); // Yangi fayl yuklash uchun
  const [title, setTitle] = useState(""); // Video nomi
  const [description, setDescription] = useState(""); // Video tavsifi
  const [error, setError] = useState(null); // Xatoliklarni qayd qilish
  const [currentItem, setCurrentItem] = useState(null); // Current item for editing

  // Backenddan barcha fayllarni olish
  const getGalleryItems = async () => {
    try {
      const response = await ApiCall("/api/v1/gallery", "GET");

      if (response.data && Array.isArray(response.data)) {
        setGalleryItems(response.data);
      } else {
        console.error("Xatolik: Gallery ma'lumotlari array emas", response.data);
        setGalleryItems([]);
      }
    } catch (error) {
      console.error("Xatolik: Rasmlar va videolar olinmadi", error);
      setError("Ma'lumotlarni yuklab bo'lmadi.");
      setGalleryItems([]);
    }
  };

  useEffect(() => {
    getGalleryItems();
  }, []);

  // Fayl yuklash funksiyasi
  const uploadFile = async (file) => {
    const formData = new FormData();
    formData.append("file", file);

    try {
      const response = await ApiCall("/api/v1/file/upload", "POST", formData, null, true);
      return response.data;
    } catch (error) {
      console.error("Xatolik: Fayl yuklanmadi", error);
      throw error;
    }
  };

  // Yangi faylni yuklash va backendga yuborish
  const handleAddFile = async () => {
    if (!newFile || !title || !description) {
      setError("Iltimos, barcha maydonlarni to‘ldiring.");
      return;
    }

    try {
      const uploadedFileData = await uploadFile(newFile);
      const galleryData = {
        fileUrl: uploadedFileData,
        title,
        description,
      };

      await ApiCall("/api/v1/gallery", "POST", galleryData);
      getGalleryItems();
      setNewFile(null);
      setTitle("");
      setDescription("");
      setIsModalOpen(false);
    } catch (error) {
      setError("Faylni qo'shishda xatolik yuz berdi.");
    }
  };

  // Edit functionality
  const handleEditItem = (item) => {
    setCurrentItem(item);
    setTitle(item.title);
    setDescription(item.description);
    setIsEditModalOpen(true);
  };

  const handleUpdateItem = async () => {
    if (!title || !description) {
      setError("Iltimos, barcha maydonlarni to‘ldiring.");
      return;
    }

    try {
      const updatedData = {
        ...currentItem,
        title,
        description,
      };

      await ApiCall(`/api/v1/gallery/${currentItem.id}`, "PUT", updatedData);
      getGalleryItems();
      setIsEditModalOpen(false);
      setCurrentItem(null);
    } catch (error) {
      setError("Faylni tahrirlashda xatolik yuz berdi.");
    }
  };

  // Delete functionality
  const handleDeleteItem = async (itemId) => {
    try {
      await ApiCall(`/api/v1/gallery/${itemId}`, "DELETE");
      getGalleryItems();
    } catch (error) {
      setError("Faylni o'chirishda xatolik yuz berdi.");
    }
  };

  return (
    <div className="p-6">
      <Sidebar />
      <div className="p-10 sm:ml-64">
        <button
          onClick={() => setIsModalOpen(true)}
          className="bg-blue-500 text-white px-4 py-1"
        >
          Yangi Fayl Qo'shish
        </button>
      </div>

      {/* Modal for adding file */}
      <Modal open={isModalOpen} onClose={() => setIsModalOpen(false)} center>
        <h2 className="text-xl mb-4">Fayl Yuklash</h2>
        <div className="mt-6">
          <input type="file" onChange={(e) => setNewFile(e.target.files[0])} />
          <input
            type="text"
            placeholder="Sarlavha"
            value={title}
            onChange={(e) => setTitle(e.target.value)}
            className="block border p-2 mt-2 w-full"
          />
          <textarea
            placeholder="Tavsif"
            value={description}
            onChange={(e) => setDescription(e.target.value)}
            className="block border p-2 mt-2 w-full"
          />
          <button
            onClick={handleAddFile}
            className="mt-2 bg-blue-500 text-white p-2 rounded"
          >
            Yuklash
          </button>
        </div>
      </Modal>

      {/* Modal for editing file */}
      <Modal open={isEditModalOpen} onClose={() => setIsEditModalOpen(false)} center>
        <h2 className="text-xl mb-4">Faylni Tahrirlash</h2>
        <div className="mt-6">
          <input
            type="text"
            placeholder="Sarlavha"
            value={title}
            onChange={(e) => setTitle(e.target.value)}
            className="block border p-2 mt-2 w-full"
          />
          <textarea
            placeholder="Tavsif"
            value={description}
            onChange={(e) => setDescription(e.target.value)}
            className="block border p-2 mt-2 w-full"
          />
          <button
            onClick={handleUpdateItem}
            className="mt-2 bg-blue-500 text-white p-2 rounded"
          >
            Yangilash
          </button>
        </div>
      </Modal>

      {/* Gallery - Backenddan kelgan fayllarni ko'rsatish */}
      <div className="grid grid-cols-3 gap-4 mt-6">
        {galleryItems.map((item, index) => (
          <div key={index} className="border p-2">
            <h3 className="text-lg font-bold">{item.title}</h3>
            <p className="text-gray-600">{item.description}</p>
            {item.fileUrl.endsWith(".mp4") || item.fileUrl.endsWith(".webm") ? (
              <video controls className="w-full h-40 object-cover">
                <source src={`${baseUrl}${item.fileUrl}`} type="video/mp4" />
              </video>
            ) : (
              <img
                src={`${baseUrl}${item.fileUrl}`}
                alt={item.title}
                className="w-full h-40 object-cover"
              />
            )}
            <div className="mt-2 flex justify-between">
              <button
                onClick={() => handleEditItem(item)}
                className="bg-yellow-500 text-white px-2 py-1"
              >
                Tahrirlash
              </button>
              <button
                onClick={() => handleDeleteItem(item.id)}
                className="bg-red-500 text-white px-2 py-1"
              >
                O'chirish
              </button>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}

export default SocialMedia;
