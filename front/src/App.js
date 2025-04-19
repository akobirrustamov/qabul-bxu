import React, { useEffect } from "react";
import "./App.css";
import { Route, Routes, useLocation, useNavigate } from "react-router-dom";
import ApiCall from "./config/index";

// my pages
import Home from "./pages/home/Home";
import PageNotFound from "./pages/404/404";
import DataForm from "./pages/home/DataForm";
import EducationTypeInstitute from "./pages/educationType/EducationTypeInstitute";
import EducationExam from "./pages/educationExam/EducationExam";
import EducationOffer from "./pages/educationOffer/EducationOffer";
import EducationSocial from "./pages/educationSocial/EducationSocial";
import EducationPrize from "./pages/educationPrize/EducationPrize";

import LoginAdmin from "./admin/LoginAdmin";
import EducationForm from "./admin/myPages/EducationForm";
import EducationField from "./admin/myPages/EducationField";
import EducationType from "./admin/myPages/EducationType";
import MyAppeals from "./admin/myPages/Appeals";
import AdminHome from "./admin/myPages/AdminHome";

// app admin
import AdminHomeUser from "./admin/admin/AdminHome";
import AgentList from "./admin/admin/AgentList";
import Operators from "./admin/admin/Operators";
import Appeals from "./admin/admin/Appeals";

// agent

import AdminHomeAgent from "./admin/agent/AdminHome";
import AppealsAgent from "./admin/agent/Appeals";
import TestAbuturient from "./pages/home/TestAbuturient";
import Staff from "./admin/myPages/Staff";
import AllAppeals from "./admin/agent/AllAppeals";
import SocialMedia from "./admin/myPages/SocialMedia";
import MyQRCode from "./admin/myPages/MyQRCode";
import GoldCard from "./pages/goldCard/GoldCard";
import QRCodeAgent from "./admin/agent/QRCodeAgent";
import Settings from "./admin/myPages/Settings";
function App() {
  const blockedPages = ["/dashboard", "/agent", "/admin"];
  const navigate = useNavigate();
  const location = useLocation();

  useEffect(() => {
    checkSecurity();
  }, [blockedPages, location.pathname, navigate]);
  async function checkSecurity() {
    if (location.pathname === "/admin/login") return;
    if (
      blockedPages.some((blockedPage) =>
        location.pathname.startsWith(blockedPage)
      )
    ) {
      let accessToken = localStorage.getItem("access_token");
      const res = await ApiCall("/api/v1/security", "GET");
      if (res?.data == 401) {
        navigate("/admin/login");
      }
      if (accessToken !== null) {
        if (res?.data !== 401 && res?.error) {
          if (res?.data[0]?.name !== "ROLE_ADMIN") {
            navigate("/404");
          }
        }
      } else {
        navigate("/admin/login");
      }
    }
  }

  return (
    <div>
      <Routes>
        <Route path={"/"} element={<Home />} />
        <Route path={"/:agentId"} element={<Home />} />
        <Route path={"/card/:cardId"} element={<GoldCard />} />
        <Route path={"/data-form"} element={<DataForm />} />
        <Route path={"/test"} element={<TestAbuturient />} />
        <Route path={"/education-type"} element={<EducationTypeInstitute />} />
        <Route path={"/education-exam"} element={<EducationExam />} />
        <Route path={"/education-offer"} element={<EducationOffer />} />

        {/* <Route path={"/education-social"} element={<EducationSocial />} />
        <Route path={"/education-prize"} element={<EducationPrize />} /> */}

        <Route path={"/admin/login"} element={<LoginAdmin />} />
        <Route path={"/dashboard"} element={<AdminHome />} />
        <Route path={"/dashboard/appeal"} element={<MyAppeals />} />
        <Route path={"/dashboard/qr-code"} element={<MyQRCode />} />
        <Route path={"/dashboard/settings"} element={<Settings />} />
        <Route path={"/dashboard/staff"} element={<Staff />} />
        <Route path={"/dashboard/education-socialMedia"} element={<SocialMedia />}/>
        <Route path={"/dashboard/education-form"} element={<EducationForm />} />
        <Route path={"/dashboard/education-field"} element={<EducationField />}/>
        <Route path={"/dashboard/education-type"} element={<EducationType />} />
        <Route path={"/*"} element={<PageNotFound />} />

        {/*  app admins */}
        <Route path={"/admin/home"} element={<AdminHomeUser />} />
        <Route path={"/admin/agent"} element={<AgentList />} />
        <Route path={"/admin/operator"} element={<Operators />} />
        <Route path={"/admin/appeal"} element={<Appeals />} />

        {/*agent*/}
        <Route path={"/agent/home"} element={<AdminHomeAgent />} />
        <Route path={"/agent/vaucher"} element={<QRCodeAgent />} />
        <Route path={"/agent/appeals"} element={<AppealsAgent />} />
        <Route path={"/agent/all-appeals"} element={<AllAppeals />} />
      </Routes>
    </div>
  );
}

export default App;
