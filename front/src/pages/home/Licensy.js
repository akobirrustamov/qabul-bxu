import React, { useState } from "react";
import bg from "./images/back.jpg";
import l1 from "./images/img.png";
import l2 from "./images/img_1.png";
import l3 from "./images/img_2.png";
import l4 from "./images/new1.png";
import l5 from "./images/new2.png";
import Zoom from "react-reveal/Zoom";
import { Modal } from "react-responsive-modal";
import "react-responsive-modal/styles.css";
import { motion } from "framer-motion";
import { fadeIn } from "./framerMotion/variants";

function Litsenziya(props) {
  const [open, setOpen] = useState(false);
  const [currentImage, setCurrentImage] = useState(null);

  const handleImageClick = (image) => {
    setCurrentImage(image);
    setOpen(true);
  };

  const handleClose = () => {
    setOpen(false);
  };

  return (
    <div className="h-full">
      <div
        className="bg-fixed bg-cover bg-center h-full bg-black bg-opacity-50"
        style={{ backgroundImage: `url(${bg})` }}
      >
        <motion.section>
          <div className="container p-4">
            <div className="row m-auto">
              <div className="col-lg-12 col-md-12 col-12">
                <div className="content">
                  <motion.div
                  variants={fadeIn("zoom", 0.2)}
                  initial="hidden"
                  whileInView="show"
                  viewport={{ once: false, amount: 0.7 }}
                  data-stellar-background-ratio="0.5"
                  >
                    <h2 className="text-white text-3xl md:text-4xl lg:text-5xl text-center font-bold">
                      Litsenziyalangan ta'lim
                    </h2>
                    <p className="text-white text-center">
                      Vazirlar Mahkamasi huzuridagi Ta’lim sifatini nazorat
                      qilish davlat inspeksiyasi tomonidan 2021-yil 29-oktabr
                      kuni 0037-raqamli litsenziya Buxoro psixologiya va xorijiy
                      tillar institutiga oliy ta’lim xizmatlarini ko’rsatish
                      uchun va O‘zbekiston Respublikasi oliy ta’lim, fan va
                      innovatsiyalar vazirligi tomonidan 2024-yil 16-maydan
                      277162-raqamli litsenziya bilan yangi yo‘nalishlarga
                      ruxsat berilgan
                    </p>
                  </motion.div>
                  <div className="flex flex-wrap justify-center gap-4">
                    <motion.img
                      onClick={() => handleImageClick(l1)}
                      className="w-full sm:w-1/2 md:w-1/3 lg:w-1/4 overlay"
                      src={l1}
                      alt="License 1"
                      variants={fadeIn("zoom", 0.2)}
                      initial="hidden"
                      whileInView="show"
                      viewport={{ once: false, amount: 0.7 }}
                      data-stellar-background-ratio="0.5"
                    />

                    <motion.img
                      onClick={() => handleImageClick(l1)}
                      className="w-full sm:w-1/2 md:w-1/3 lg:w-1/4 overlay"
                      src={l2}
                      alt="License 2"
                      variants={fadeIn("zoom", 0.2)}
                      initial="hidden"
                      whileInView="show"
                      viewport={{ once: false, amount: 0.7 }}
                      data-stellar-background-ratio="0.5"
                    />

                    <motion.img
                      onClick={() => handleImageClick(l3)}
                      className="w-full sm:w-1/2 md:w-1/3 lg:w-1/4 overlay"
                      src={l3}
                      alt="License 3"
                      variants={fadeIn("zoom", 0.2)}
                      initial="hidden"
                      whileInView="show"
                      viewport={{ once: false, amount: 0.7 }}
                      data-stellar-background-ratio="0.5"
                    />
                  </div>
                </div>
              </div>
            </div>
          </div>
        </motion.section>

        <motion.section>
          <div className="container">
            <div className="row">
              <div className="col-lg-12 col-md-12 col-12">
                <div className="content">
                  <motion.div
                    variants={fadeIn("zoom", 0.2)}
                    initial="hidden"
                    whileInView="show"
                    viewport={{ once: false, amount: 0.7 }}
                    data-stellar-background-ratio="0.5"
                  >
                    <h2 className="text-white text-center font-bold text-xl sm:text-2xl md:text-2xl lg:text-4xl xl:text-4xl">
                      Oliy ta'limdan keyingi ta'lim
                    </h2>
                    <h2 className="text-white text-center text-xl sm:text-2xl md:text-3xl lg:text-5xl xl:text-5xl">
                      DOKTORANTURA
                    </h2>
                  </motion.div>

                  <div className="my-4 flex flex-wrap justify-center gap-4">
                    <motion.img
                      onClick={() => handleImageClick(l4)}
                      className="w-full sm:w-1/2 md:w-1/3 lg:w-1/4 overlay pt-4"
                      src={l4}
                      alt="License 4"
                      variants={fadeIn("zoom", 0.2)}
                      initial="hidden"
                      whileInView="show"
                      viewport={{ once: false, amount: 0.7 }}
                      data-stellar-background-ratio="0.5"
                    />

                    <motion.img
                      onClick={() => handleImageClick(l5)}
                      className="w-full sm:w-1/2 md:w-1/3 lg:w-1/4 overlay pt-4"
                      src={l4}
                      alt="License 5"
                      variants={fadeIn("zoom", 0.2)}
                      initial="hidden"
                      whileInView="show"
                      viewport={{ once: false, amount: 0.7 }}
                      data-stellar-background-ratio="0.5"
                    />
                  </div>
                </div>
              </div>
            </div>
          </div>
        </motion.section>
      </div>

      <Modal open={open} onClose={handleClose} center>
        {currentImage && (
          <img
            src={currentImage}
            alt="Zoomed License"
            style={{ width: "100%", height: "auto" }}
          />
        )}
      </Modal>
    </div>
  );
}

export default Litsenziya;
