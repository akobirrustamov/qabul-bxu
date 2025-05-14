package com.example.backend.Controller;

import com.example.backend.DTO.TestScoreDTO;
import com.example.backend.Entity.Abuturient;
import com.example.backend.Entity.MyTest;
import com.example.backend.Entity.TestScore;
import com.example.backend.Entity.TestSubject;
import com.example.backend.Repository.AbuturientRepo;
import com.example.backend.Repository.MyTestRepo;
import com.example.backend.Repository.TestScoreRepo;
import com.example.backend.Repository.TestSubjectRepo;
import lombok.RequiredArgsConstructor;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.io.FileInputStream;
import java.time.LocalDateTime;
import java.util.*;

@RestController
@RequestMapping("/api/v1/test")
@RequiredArgsConstructor
@CrossOrigin(origins = "*")
public class TestController {
    private final MyTestRepo myTestRepo;
    private final AbuturientRepo abuturientRepo;
    private final TestSubjectRepo testSubjectRepo;
    private final TestScoreRepo testScoreRepo;

    @GetMapping("/add/update")
    public HttpEntity<?> addOrUpdateTests() {
//        String filePath = System.getProperty("user.home") + "/Downloads/test.xlsx";
        String filePath =  "./test.xlsx";

        try (FileInputStream fileInputStream = new FileInputStream(filePath)) {
            Workbook workbook = new XSSFWorkbook(fileInputStream);
            Sheet sheet = workbook.getSheetAt(0);
            DataFormatter dataFormatter = new DataFormatter();
            for (int i = 1; i <= sheet.getLastRowNum(); i++) {
                Row row = sheet.getRow(i);

                if (row == null) continue;

                // Retrieve subject name and status from Excel
                String subjectName = dataFormatter.formatCellValue(row.getCell(6));
                String status = dataFormatter.formatCellValue(row.getCell(7));

                // Find or create TestSubject
                TestSubject testSubject = testSubjectRepo.findByNameAndStatus(subjectName, status)
                        .orElseGet(() -> {
                            TestSubject newSubject = new TestSubject(subjectName, "", status, LocalDateTime.now());
                            return testSubjectRepo.save(newSubject);
                        });

                // Retrieve question and answers from Excel
                String question = dataFormatter.formatCellValue(row.getCell(1));
                String correctAnswer = dataFormatter.formatCellValue(row.getCell(2)); // Column C
                String wrongAnswer1 = dataFormatter.formatCellValue(row.getCell(3)); // Column D
                String wrongAnswer2 = dataFormatter.formatCellValue(row.getCell(4)); // Column E
                String wrongAnswer3 = dataFormatter.formatCellValue(row.getCell(5)); // Column F

                // Save the test question to the database
                MyTest test = new MyTest(question, correctAnswer, wrongAnswer1, wrongAnswer2, wrongAnswer3, testSubject);
                myTestRepo.save(test);
            }

            return new ResponseEntity<>("Tests saved successfully!", HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>("Error occurred while processing the file: " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @GetMapping("/{phone}")
    public HttpEntity<?> getTestsForAbiturient(@PathVariable("phone") String phone) {
        Abuturient abiturient = abuturientRepo.findByPhone(phone);
        if (abiturient == null) {
            return new ResponseEntity<>("Phone not found", HttpStatus.NOT_FOUND);
        }
        System.out.println(abiturient);

        TestScore testScore = testScoreRepo.findByAbuturientId(abiturient.getId());
        if (testScore == null) {
            testScore = new TestScore(abiturient, "0", "0", LocalDateTime.now(), 0);
            testScoreRepo.save(testScore);
        }
        // Convert the string to a float
        float rightScore = Float.parseFloat(testScore.getRightScore());

// Perform the comparison
        System.out.println(rightScore);
        System.out.println(rightScore < 57.0f);
        if (rightScore < 57.0f) {
            testScore.setStatus(0);
            abiturient.setStatus(2);
            abuturientRepo.save(abiturient);
            testScoreRepo.save(testScore);
        }
        System.out.println(testScore);
        if (testScore.getStatus() == 0 || testScore.getStatus() == null) {
            TestSubject test1 = abiturient.getEducationField().getTestEducationField().getTest1();
            TestSubject test2 = abiturient.getEducationField().getTestEducationField().getTest2();
            TestSubject test3 = abiturient.getEducationField().getTestEducationField().getTest3();
            TestSubject test4 = abiturient.getEducationField().getTestEducationField().getTest4();
            TestSubject test5 = abiturient.getEducationField().getTestEducationField().getTest5();
            Map<String, Object> randomTests = new HashMap<>();
            randomTests.put("subject1", myTestRepo.findRandomByTestSubject(test1.getId(), 5));
            randomTests.put("subject2", myTestRepo.findRandomByTestSubject(test2.getId(), 5));
            randomTests.put("subject3", myTestRepo.findRandomByTestSubject(test3.getId(), 5));
            randomTests.put("subject4", myTestRepo.findRandomByTestSubject(test4.getId(), 10));
            randomTests.put("subject5", myTestRepo.findRandomByTestSubject(test5.getId(), 10));

            List<String> strings = new ArrayList<>();
            strings.add(test1.getName());
            strings.add(test2.getName());
            strings.add(test3.getName());
            strings.add(test4.getName());
            strings.add(test5.getName());
            randomTests.put("subjects", strings);
            return ResponseEntity.ok(randomTests);
        }

        return ResponseEntity.ok(testScore);
    }

    @PostMapping("/result/{phone}")
    public HttpEntity<?> setTestScore(@RequestBody TestScoreDTO testScoreDTO, @PathVariable String phone) {
        Abuturient abiturient = abuturientRepo.findByPhone(phone);
        System.out.println(testScoreDTO);
        if (abiturient == null) {
            return new ResponseEntity<>("Phone not found", HttpStatus.NOT_FOUND);
        }

        TestScore testScore = testScoreRepo.findByAbuturientId(abiturient.getId());
        testScore.setScore(testScoreDTO.getShowScore());
        testScore.setRightScore(testScoreDTO.getScore());
        testScoreRepo.save(testScore);
        abiturient.setStatus(3);
        abiturient.setBall(testScoreDTO.getShowScore());
        if(abiturient.getEducationField().getIjodiy()){
            abiturient.setGetContract(false);
        }else {
            abiturient.setGetContract(true);
        }
        abuturientRepo.save(abiturient);

        return new ResponseEntity<>("Score updated successfully", HttpStatus.OK);
    }

    @GetMapping("/score/{phone}")
    public HttpEntity<?> getTestScore(@PathVariable("phone") String phone) {
        TestScore testScore = testScoreRepo.findByAbuturientId(abuturientRepo.findByPhone(phone).getId());
        if (testScore == null) {
            return new ResponseEntity<>("Phone not found", HttpStatus.NOT_FOUND);
        }
        System.out.println(testScore);
        return ResponseEntity.ok(testScore);
    }
}
