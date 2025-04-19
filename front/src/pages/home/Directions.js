import React from "react";
import { Carousel } from "antd";
import { motion } from "framer-motion";
import { fadeIn } from "./framerMotion/variants";

// Bachelor images
import b1 from "./images/images_/bakalavr/MATEMATIKA.jpg";
import b2 from "./images/images_/bakalavr/RUS_TILI.jpg";
import b3 from "./images/images_/bakalavr/TRANSPORT.jpg";
import b4 from "./images/images_/bakalavr/axborot_tizimlari.jpg";
import b5 from "./images/images_/bakalavr/boshlangich_talim.jpg";
import b6 from "./images/images_/bakalavr/iqtisodiyot.jpg";
import b7 from "./images/images_/bakalavr/jismoniy_madaniyat.jpg";
import b8 from "./images/images_/bakalavr/mamtabgacha_talim.jpg";
import b9 from "./images/images_/bakalavr/maxsus_pedagogika.jpg";
import b10 from "./images/images_/bakalavr/milliy_goya.jpg";
import b11 from "./images/images_/bakalavr/musiqa.jpg";
import b12 from "./images/images_/bakalavr/ozbek_tili.jpg";
import b13 from "./images/images_/bakalavr/psixologiya.jpg";
import b14 from "./images/images_/bakalavr/xorijiy_til.jpg";
import b15 from "./images/images_/bakalavr/tarix.jpg";
import b16 from "./images/images_/bakalavr/turizm.jpg";

// Master images
import m1 from "./images/images_/magistr/JISMONIY_MAGISTIR.jpg";
import m2 from "./images/images_/magistr/LINGVISTIKA_MAGISTIR.jpg";
import m3 from "./images/images_/magistr/MUSIQA_magistir.jpg";
import m4 from "./images/images_/magistr/OZBEK_TILI_MAGISTIR.jpg";
import m5 from "./images/images_/magistr/PEDAGOGIKA_MAGISTIR.jpg";
import m6 from "./images/images_/magistr/boshlangich_talim_magistir.jpg";
import m7 from "./images/images_/magistr/iqtisodiyot_magistir.jpg";
import m8 from "./images/images_/magistr/psixologiya_magistir.jpg";

const BACHELOR_DIRECTIONS = [
  { src: b1, title: "Matematika" },
  { src: b2, title: "Rus tili" },
  { src: b3, title: "Transport" },
  { src: b4, title: "Axborot tizimlari" },
  { src: b5, title: "Boshlang'ich ta'lim" },
  { src: b6, title: "Iqtisodiyot" },
  { src: b7, title: "Jismoniy madaniyat" },
  { src: b8, title: "Maktabgacha ta'lim" },
  { src: b9, title: "Maxsus pedagogika" },
  { src: b10, title: "Milliy g'oya" },
  { src: b11, title: "Musiqa" },
  { src: b12, title: "O'zbek tili" },
  { src: b13, title: "Psixologiya" },
  { src: b14, title: "Xorijiy til" },
  { src: b15, title: "Tarix" },
  { src: b16, title: "Turizm" },
];

const MASTER_DIRECTIONS = [
  { src: m1, title: "Jismoniy ta'lim magistri" },
  { src: m2, title: "Lingvistika magistri" },
  { src: m3, title: "Musiqa magistri" },
  { src: m4, title: "O'zbek tili magistri" },
  { src: m5, title: "Pedagogika magistri" },
  { src: m6, title: "Boshlang'ich ta'lim magistri" },
  { src: m7, title: "Iqtisodiyot magistri" },
  { src: m8, title: "Psixologiya magistri" },
];

// Split images into chunks for carousel slides
const chunkArray = (arr, size) => {
  return Array.from({ length: Math.ceil(arr.length / size) }, (_, i) =>
    arr.slice(i * size, i * size + size)
  );
};

const BACHELOR_CHUNKS = chunkArray(BACHELOR_DIRECTIONS, 2);
const MASTER_CHUNKS = chunkArray(MASTER_DIRECTIONS, 2);

function Directions() {
  const renderSlide = (items) => (
    <div className="p-4 rounded-lg">
      <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
        {items.map((item, idx) => (
          <div
            key={idx}
            className="bg-white rounded-lg overflow-hidden shadow-md "
          >
            <img
              src={item.src}
              alt={item.title}
              className="w-full h-auto object-cover"
              loading="lazy"
            />
          </div>
        ))}
      </div>
    </div>
  );

  return (
    <div className="bg-blue-950 min-h-screen">
      {/* Header */}
      <header className="py-6 md:py-8 px-4">
        <motion.h1
          variants={fadeIn("right", 0.2)}
          initial="hidden"
          whileInView="show"
          viewport={{ once: false, amount: 0.7 }}
          className="text-xl sm:text-2xl md:text-3xl lg:text-4xl font-bold text-center text-white leading-snug md:leading-tight"
        >
          Buxoro xalqaro universiteti
          <br className="hidden sm:block" />
          bakalavr va magistratura yo'nalishlari
        </motion.h1>
      </header>

      {/* Bachelor Directions */}
      <motion.section
        variants={fadeIn("bottom", 0.5)}
        initial="hidden"
        whileInView="show"
        viewport={{ once: false, amount: 0.7 }}
        className="pb-8 md:pb-12 px-4 bg-slate-800"
      >
        <h2 className="text-lg md:text-xl lg:text-2xl font-bold text-white  text-center pt-4">
          Bakalavr yo'nalishlari
        </h2>
        <div className="max-w-7xl mx-auto">
          <Carousel
            autoplay
            arrows
            autoplaySpeed={5000}
            dots={{ className: "text-white bottom-0" }}
            dotActiveClassName="bg-white"
            slidesToShow={1}
            responsive={[
              {
                breakpoint: 1024,
                settings: {
                  slidesToShow: 1,
                },
              },
              {
                breakpoint: 768,
                settings: {
                  slidesToShow: 1,
                  dots: false,
                },
              },
            ]}
          >
            {BACHELOR_CHUNKS.map((chunk, index) => (
              <div key={`bachelor-${index}`} className="px-2">
                {renderSlide(chunk)}
              </div>
            ))}
          </Carousel>
        </div>
      </motion.section>

      {/* Master Directions */}
      <motion.section
        variants={fadeIn("bottom", 0.5)}
        initial="hidden"
        whileInView="show"
        viewport={{ once: false, amount: 0.7 }}
        className="pb-8 md:pb-12 px-4"
      >
        <h2 className="text-lg md:text-xl lg:text-2xl font-bold text-white text-center pt-4">
          Magistratura yo'nalishlari
        </h2>
        <div className="max-w-7xl mx-auto">
          <Carousel
            autoplay
            arrows
            autoplaySpeed={5000}
            dots={{ className: "text-white bottom-0" }}
            dotActiveClassName="bg-white"
            slidesToShow={1}
            responsive={[
              {
                breakpoint: 1024,
                settings: {
                  slidesToShow: 1,
                },
              },
              {
                breakpoint: 768,
                settings: {
                  slidesToShow: 1,
                  dots: false,
                },
              },
            ]}
          >
            {MASTER_CHUNKS.map((chunk, index) => (
              <div key={`master-${index}`} className="px-2">
                {renderSlide(chunk)}
              </div>
            ))}
          </Carousel>
        </div>
      </motion.section>
    </div>
  );
}

export default Directions;
