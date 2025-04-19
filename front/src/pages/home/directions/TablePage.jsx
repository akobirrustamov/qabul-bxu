import React, {useEffect, useState} from 'react'
import Table from 'react-bootstrap/Table';
import "../tablePage/tablepage.css"

import { useTranslation } from 'react-i18next';
import Zoom from "react-reveal/Zoom";
import ApiCall from "../../../config";

const TablePage = () => {
    const [show, setShow] = useState(4)

    const [educationFields, setEducationFields] = useState([]);
    const [educationForms, setEducationForms] = useState([]);
    const [modalOpen, setModalOpen] = useState(false);
    const [modalOpenSubject, setModalOpenSubject] = useState(false);
    const [filterText, setFilterText] = useState(""); // For search input
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






    return (
    <Zoom className='f-table p-3'>
        <div className='ch-table p-2 m-auto'>
            <div className={"p-4 pb-0 pt-0"}>
                <div className="text-center wow fadeInUp my-2" data-wow-delay="0.1s">
                    <h1 className=""> {t('directions.title')}</h1>
                </div>

            </div>
            <div className="tabs">
                {educationForms.map(item=>{

                    <span
                        className={`tab ${show == 4 ? "hover:bg-gray-200 rounded active" : " hover:bg-gray-200 rounded"}`}
                        onClick={() => setShow(4)}> {t('directions.tab_btn4')} </span>

                })}

                 <span
                     className={`tab ${show == 4 ? "hover:bg-gray-200 rounded active" : " hover:bg-gray-200 rounded"}`}
                     onClick={() => setShow(4)}> {t('directions.tab_btn4')} </span>
                <span className={`tab ${show == 1 ? "hover:bg-gray-200 rounded active" : " hover:bg-gray-200 rounded"}`}
                      onClick={() => setShow(1)}> {t('directions.tab_btn1')} </span>
                <span className={`tab ${show == 2 ? "hover:bg-gray-200 rounded active" : " hover:bg-gray-200 rounded"}`}
                      onClick={() => setShow(2)}> {t('directions.tab_btn2')} </span>
                <span className={`tab ${show == 3 ? "hover:bg-gray-200 rounded active" : " hover:bg-gray-200 rounded"}`}
                      onClick={() => setShow(3)}> {t('directions.tab_btn3')} </span>
                <span className={`tab ${show == 5 ? "hover:bg-gray-200 rounded active" : " hover:bg-gray-200 rounded"}`}
                      onClick={() => setShow(5)}> {t('directions.tab_btn5')} </span>

            </div>
            <div className={show == 1 ? "p-4 pt-0" : "hidden"}>

                <Table striped bordered hover>
                    <thead className='bg-dark'>
                    <tr>
                        <th>T/r</th>
                        <th>{t('directions.th1')}</th>
                        <th>{t('directions.th2')}</th>
                    </tr>
                    </thead>
                    <tbody>

                    </tbody>
                </Table>
            </div>
            <div className={show == 2 ? "p-4 pt-0" : "hidden"}>
                <Table striped bordered hover>
                    <thead className='bg-dark'>
                    <tr>
                        <th>T/r</th>
                        <th>{t('directions.th1')}</th>
                        <th>{t('directions.th2')}</th>
                    </tr>
                    </thead>
                    <tbody>

                    </tbody>
                </Table>
            </div>
            <div className={show == 3 ? "p-4 pt-0" : "hidden"}>
                <Table striped bordered hover>
                    <thead className='bg-dark'>
                    <tr>
                        <th>T/r</th>
                        <th>{t('directions.th1')}</th>
                        <th>{t('directions.th2')}</th>
                    </tr>
                    </thead>
                    <tbody>

                    </tbody>
                </Table>
            </div>


        </div>
    </Zoom>
  )
}

export default TablePage