import React from "react";
import Header from "../header/Header";
import Footer from "../footer/Footer";
import { motion } from "framer-motion";
import { fadeIn } from "../home/framerMotion/variants";

function EducationOffer() {
  const texts = [
    {
      text: "BIZNING UNIVERSITETD DAVLAT GRANTI ASOSIDA O`QISHINGIZ MUMKIN.",
    },
    {
      text: "UNIVERSITETGA QARASHLI BO`LGAN SHINAM VA QULAY YOTOQXONALAR SIZ UCHUN.",
    },
    {
      text: "IELTS SERTIFIKTINGIZ BO'LSA YOKI O`QISH DAVOMIDA USHBI SERTIFIKATNI OLSANGIZ SERTIFIKAT MUDDATI TUGAGUNCHA 5 MILLION SO'MLIK STIPENDIYAGA EGA BO'LASIZ.",
    },
    {
      text: "MILLIY SERTIFIKAT UCHUN KANTRAKTINGIZDAN 30% LIK CHEGIRMAGA ERISHASIZ.",
    },
    {
      text: "DARSDAN KEYIN O'Z YO'NALISHINGIZDAGI A'LO DARAJADAGI BEPUL KURSLARDAN  FOYDALANISHINGIZ MUMKIN.",
    },
    {
      text: "BOQUVCHISINI QISMAN YOKI TO'LIQ YO'QOTGANLIGI INOBATGA OLINIB 50% GACHA SHARTNOMA TO'LOVIDAN CHEGIRMA QILINADI.",
    },
    {
      text: "BIZDA DUNYONING TOP 10 TALIK UNIVERSITETLARIGA KIRISH UCHUN MAXSUS BEPUL KURSLARDAN FOYDALANISHINGIZ MUMKIN.",
    },
    {
      text: "AMALIYOTLAR VA SHAHAR ICHIDAGI QATNOVINGIZ UCHUN BEPUL MIKROAVTOBUSLAR XIZMATIDAN FOYDALANING.",
    },
  ];

  return (
    <div>
      <Header />
      <div className="pt-40">
        <h1 className="mb-3 mt-4 text-center font-bold">Universitetimiz imtiyozlari</h1>
        <ul className="w-4/5 mx-auto list-none p-4 space-y-6">
          {texts.map((text, index) => (
            <motion.li
              className="cursor-default text-sm md:text-base lg:text-md xl:text-2xl 2xl:text-4xl text-center bg-gradient-to-r from-blue-500 to-green-500 text-white p-4 rounded-lg shadow-lg hover:scale-105 transition-transform duration-200"
              key={index}
              variants={fadeIn("top", `0.${index}`)}
              initial="hidden"
              whileInView="show"
              whileHover={{ scale: 1.05 }}
              viewport={{ once: false, amount: 0.1 }}
              data-stellar-background-ratio="0.5"
            >
              {text.text}
            </motion.li>
          ))}
        </ul>
      </div>
      <Footer />
    </div>
  );
}

export default EducationOffer;
