import React from "react";
import Header from "../header/Header";
import Footer from "../footer/Footer";

function EducationSocial() {
  return (
    <div>
      <Header />
      {/*<div className="pt-24">*/}
      {/*  <div className="grid grid-cols-3 gap-4 mt-6">*/}
      {/*    {galleryItems.map((item, index) => (*/}
      {/*      <div key={index} className="border p-2">*/}
      {/*        <h3 className="text-lg font-bold">{item.title}</h3>*/}
      {/*        <p className="text-gray-600">{item.description}</p>*/}
      {/*        {item.fileUrl.endsWith(".mp4") ||*/}
      {/*        item.fileUrl.endsWith(".webm") ? (*/}
      {/*          <video controls className="w-full h-40 object-cover">*/}
      {/*            <source src={`${baseUrl}${item.fileUrl}`} type="video/mp4" />*/}
      {/*          </video>*/}
      {/*        ) : (*/}
      {/*          <img*/}
      {/*            src={`${baseUrl}${item.fileUrl}`}*/}
      {/*            alt={item.title}*/}
      {/*            className="w-full h-40 object-cover"*/}
      {/*          />*/}
      {/*        )}*/}
      {/*      </div>*/}
      {/*    ))}*/}
      {/*  </div>*/}
      {/*</div>*/}
      <Footer />
    </div>
  );
}

export default EducationSocial;
