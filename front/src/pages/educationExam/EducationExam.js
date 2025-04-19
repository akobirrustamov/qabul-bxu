import React from "react";
import Header from "../header/Header";
import Footer from "../footer/Footer";
import { motion } from "framer-motion";
import { fadeIn } from "../home/framerMotion/variants";

const EducationExamTable = () => {
  const data = [
    {
      id: 1,
      name: "Psixologiya",
      block1: "Biologiya",
      block2: "Ona-tili va adabiyot",
      block3: "Ona tili",
      block4: "Matematika",
      block5: "O'zbekiston tarixi",
    },
    {
      id: 2,
      name: "Xorijiy til va adabiyoti",
      block1: "Ingliz tili",
      block2: "Ona-tili va adabiyot",
      block3: "Ona tili",
      block4: "Matematika",
      block5: "O'zbekiston tarixi",
    },
    {
      id: 3,
      name: "Maktabgacha ta'lim",
      block1: "Biologiya",
      block2: "Ona-tili va adabiyot",
      block3: "Ona tili",
      block4: "Matematika",
      block5: "O'zbekiston tarixi",
    },
    {
      id: 4,
      name: "Boshlang‘ich ta'lim",
      block1: "Matematika",
      block2: "Ona-tili va adabiyot",
      block3: "Ona tili",
      block4: "Matematika",
      block5: "O'zbekiston tarixi",
    },
    {
      id: 5,
      name: "Musiqa ta'limi",
      block1: "Ijodiy",
      block2: "Ona-tili va adabiyot",
      block3: "Ona tili",
      block4: "Matematika",
      block5: "O'zbekiston tarixi",
    },
    {
      id: 6,
      name: "O‘zbek tili va adabiyoti",
      block1: "O‘zbek tili va adabiyot",
      block2: "Tarix",
      block3: "Ona tili",
      block4: "Matematika",
      block5: "O'zbekiston tarixi",
    },
    {
      id: 7,
      name: "Iqtisodiyot",
      block1: "Matematika",
      block2: "Chet tili",
      block3: "Ona tili",
      block4: "Matematika",
      block5: "O'zbekiston tarixi",
    },
    {
      id: 8,
      name: "Tarix",
      block1: "Tarix",
      block2: "Geografiya",
      block3: "Ona tili",
      block4: "Matematika",
      block5: "O'zbekiston tarixi",
    },
    {
      id: 9,
      name: "Logistika",
      block1: "Ona tili",
      block2: "Matematika",
      block3: "Ona tili",
      block4: "Matematika",
      block5: "O'zbekiston tarixi",
    },
    {
      id: 10,
      name: "Matematika",
      block1: "Matematika",
      block2: "Fizika",
      block3: "Ona tili",
      block4: "Matematika",
      block5: "O'zbekiston tarixi",
    },
    {
      id: 11,
      name: "Maxsus Pedagogika(Logopediya)",
      block1: "Biologiya",
      block2: "Ona-tili va adabiyot",
      block3: "Ona tili",
      block4: "Matematika",
      block5: "O'zbekiston tarixi",
    },
    {
      id: 12,
      name: "Turizm",
      block1: "Matematika",
      block2: "Chet tili",
      block3: "Ona tili",
      block4: "Matematika",
      block5: "O'zbekiston tarixi",
    },
    {
      id: 13,
      name: "Ona-tili va adabiyot: Rus tili va adabiyoti",
      block1: "Rus tili va adabiyoti",
      block2: "Tarix",
      block3: "Ona tili",
      block4: "Matematika",
      block5: "O'zbekiston tarixi",
    },
    {
      id: 14,
      name: "Jismoniy madaniyati",
      block1: "Ijodiy",
      block2: "Ijodiy",
      block3: "Ona tili",
      block4: "Matematika",
      block5: "O'zbekiston tarixi",
    },
    {
      id: 15,
      name: "Axborot tizimlari va texnologiyalari",
      block1: "Matematika",
      block2: "Fizika",
      block3: "Ona tili",
      block4: "Matematika",
      block5: "O'zbekiston tarixi",
    },
    {
      id: 16,
      name: "Milly g'oya, ma'naviyat asoslari va huquq ta'limi",
      block1: "Tarix",
      block2: "Geografiya",
      block3: "Ona tili",
      block4: "Matematika",
      block5: "O'zbekiston tarixi",
    },
  ];

  return (
    <div>
      <div>
        <Header />
      </div>

      <motion.div className="pt-40 px-4">
        <h1 className="mb-3 mt-4 text-center font-bold">Kirish imthonlari</h1>
        <div className="overflow-x-auto mb-4 md:px-12 sm:px-6 px-2">
          <table
            className="w-full border border-gray-300 bg-white"
            style={{ minWidth: "800px" }}
          >
            <thead>
              <tr className="bg-gray-100">
                <th className="border border-gray-300 px-3 py-2 text-sm">№</th>
                <th className="border border-gray-300 px-3 py-2 text-sm">
                  Yo'nalish nomi
                </th>
                <th className="border border-gray-300 px-3 py-2 text-sm">
                  1-blok
                </th>
                <th className="border border-gray-300 px-3 py-2 text-sm">
                  2-blok
                </th>
                <th className="border border-gray-300 px-3 py-2 text-sm">
                  3-blok
                </th>
                <th className="border border-gray-300 px-3 py-2 text-sm">
                  4-blok
                </th>
                <th className="border border-gray-300 px-3 py-2 text-sm">
                  5-blok
                </th>
              </tr>
            </thead>
            <tbody>
              {data.map((item, index) => (
                <tr
                  key={item.id}
                  className={index % 2 === 0 ? "bg-gray-50" : "bg-white"}
                >
                  <td className="border border-gray-300 px-3 py-2 text-center text-sm">
                    {item.id}
                  </td>
                  <td className="border border-gray-300 px-3 py-2 text-sm">
                    {item.name}
                  </td>
                  <td className="border border-gray-300 px-3 py-2 text-center text-sm">
                    {item.block1}
                  </td>
                  <td className="border border-gray-300 px-3 py-2 text-center text-sm">
                    {item.block2}
                  </td>
                  <td className="border border-gray-300 px-3 py-2 text-center text-sm">
                    {item.block3}
                  </td>
                  <td className="border border-gray-300 px-3 py-2 text-center text-sm">
                    {item.block4}
                  </td>
                  <td className="border border-gray-300 px-3 py-2 text-center text-sm">
                    {item.block5}
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </motion.div>
      <div>
        <Footer />
      </div>
    </div>
  );
};

export default EducationExamTable;
