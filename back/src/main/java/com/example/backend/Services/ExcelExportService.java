package com.example.backend.Services;

import com.example.backend.Entity.Abuturient;
import com.example.backend.Entity.EducationField;
import com.example.backend.Entity.EducationForm;
import com.example.backend.Entity.EducationType;
import com.example.backend.Repository.AbuturientRepo;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Service;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.UUID;

@Service
public class ExcelExportService {

    private final AbuturientRepo abuturientRepo;

    public ExcelExportService(AbuturientRepo abuturientRepo) {
        this.abuturientRepo = abuturientRepo;
    }

    public ByteArrayInputStream exportToExcel(String firstName, String lastName, String fatherName,
                                              String passportNumber, String passportPin, String phone,
                                              Integer appealTypeId, Integer educationFieldId, UUID agentId,
                                              LocalDate createdAt) throws IOException {

        List<Abuturient> abuturients = abuturientRepo.findByFiltersOne(
                firstName, lastName, fatherName, passportNumber, passportPin, phone,
                appealTypeId, educationFieldId, agentId, createdAt);

        try (Workbook workbook = new XSSFWorkbook(); ByteArrayOutputStream out = new ByteArrayOutputStream()) {
            Sheet sheet = workbook.createSheet("Abuturients");

            // 🔹 Header
            Row headerRow = sheet.createRow(0);
            String[] headers = {
                    "№", "Ism", "Familia", "Otasining ismi", "Passport raqami", "JSHR", "Telefon",
                    "Ro'yxatdan o'tgan sana", "Ta'lim turi", "Ta'lim shakli", "Yo'nalishi",
                    "To'plangan bal", "Agent"
            };

            for (int i = 0; i < headers.length; i++) {
                Cell cell = headerRow.createCell(i);
                cell.setCellValue(headers[i]);
            }

            // 🔹 Data Rows
            int rowIdx = 1;
            int counter = 1;
            for (Abuturient abuturient : abuturients) {
                Row row = sheet.createRow(rowIdx++);
                int colIdx = 0;

                row.createCell(colIdx++).setCellValue(counter++); // №
                row.createCell(colIdx++).setCellValue(abuturient.getFirstName());
                row.createCell(colIdx++).setCellValue(abuturient.getLastName());
                row.createCell(colIdx++).setCellValue(abuturient.getFatherName());
                row.createCell(colIdx++).setCellValue(abuturient.getPassportNumber());
                row.createCell(colIdx++).setCellValue(abuturient.getPassportPin());
                row.createCell(colIdx++).setCellValue(abuturient.getPhone());

                LocalDateTime createdAtDateTime = abuturient.getCreatedAt();
                String formattedDate = createdAtDateTime != null ?
                        createdAtDateTime.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm")) : "";
                row.createCell(colIdx++).setCellValue(formattedDate);

                if (abuturient.getEducationField() != null) {
                    EducationField educationField = abuturient.getEducationField();
                    EducationForm educationForm = educationField.getEducationForm();
                    EducationType educationType = educationForm != null ? educationForm.getEducationType() : null;

                    row.createCell(colIdx++).setCellValue(educationType != null ? educationType.getName() : "");
                    row.createCell(colIdx++).setCellValue(educationForm != null ? educationForm.getName() : "");
                    row.createCell(colIdx++).setCellValue(educationField.getName());
                } else {
                    row.createCell(colIdx++).setCellValue("");
                    row.createCell(colIdx++).setCellValue("");
                    row.createCell(colIdx++).setCellValue("");
                }

                row.createCell(colIdx++).setCellValue(abuturient.getBall());

                // 🔹 Agent name
                String agentName = abuturient.getAgent() != null ? abuturient.getAgent().getName() : "";
                row.createCell(colIdx).setCellValue(agentName);
            }

            workbook.write(out);
            return new ByteArrayInputStream(out.toByteArray());
        }
    }
}
