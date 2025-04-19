package com.example.backend.Controller;

import com.example.backend.DTO.TestEducationFieldDTO;
import com.example.backend.Entity.EducationField;
import com.example.backend.Entity.TestEducationField;
import com.example.backend.Entity.TestSubject;
import com.example.backend.Repository.EducationFieldRepo;
import com.example.backend.Repository.TestEducationFieldRepo;
import com.example.backend.Repository.TestSubjectRepo;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpEntity;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;
@RestController
@RequiredArgsConstructor
@CrossOrigin
@RequestMapping("/api/v1/test-educationfield")
public class TestEducationFieldController {
    private final TestEducationFieldRepo testEducationFieldRepo;
    private final EducationFieldRepo educationFieldRepo;
    private final TestSubjectRepo testSubjectRepo;

    @PostMapping()
    public HttpEntity<?> save(@RequestBody TestEducationFieldDTO testEducationFieldDTO) {
        System.out.println(testEducationFieldDTO);
        Optional<EducationField> educationFieldOptional = educationFieldRepo.findById(testEducationFieldDTO.getFieldId());
        if (educationFieldOptional.isEmpty()) {
            return ResponseEntity.badRequest().body("EducationField not found!");
        }
        EducationField educationField = educationFieldOptional.get();
        System.out.println(educationField);
        TestSubject test1 = testSubjectRepo.findById(testEducationFieldDTO.getTest1()).orElseThrow();
        System.out.println(test1);
        TestSubject test2 = testSubjectRepo.findById(testEducationFieldDTO.getTest2()).orElseThrow();
        System.out.println(test2);
        TestSubject test3 = testSubjectRepo.findById(testEducationFieldDTO.getTest3()).orElseThrow();
        System.out.println(test3);
        TestSubject test4 = testSubjectRepo.findById(testEducationFieldDTO.getTest4()).orElseThrow();
        System.out.println(test4);
        TestSubject test5 = testSubjectRepo.findById(testEducationFieldDTO.getTest5()).orElseThrow();
        System.out.println(test5);
        TestEducationField save = testEducationFieldRepo.save(new TestEducationField(test1, test2, test3, test4, test5));
        educationField.setTestEducationField(save);
        educationFieldRepo.save(educationField);
        return ResponseEntity.ok(new TestEducationFieldDTO());
    }

    @PutMapping("/{id}")
    public HttpEntity<?> update(@PathVariable Integer id, @RequestBody TestEducationFieldDTO testEducationFieldDTO) {
        // Fetch the existing TestEducationField
        TestEducationField existingTestEducationField = testEducationFieldRepo.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("TestEducationField not found!"));

        // Fetch the associated EducationField
        EducationField educationField = educationFieldRepo.findById(testEducationFieldDTO.getFieldId())
                .orElseThrow(() -> new IllegalArgumentException("EducationField not found!"));

        // Update the ijodiy field based on test conditions
        updateIjodiyField(testEducationFieldDTO, educationField);

        // Fetch and set the test subjects
        setTestSubjects(existingTestEducationField, testEducationFieldDTO);

        // Save the updated entities
        testEducationFieldRepo.save(existingTestEducationField);
        educationField.setTestEducationField(existingTestEducationField);
        educationFieldRepo.save(educationField);

        return ResponseEntity.ok("TestEducationField updated successfully!");
    }

    private void updateIjodiyField(TestEducationFieldDTO dto, EducationField educationField) {
        if (isIjodiyTest(dto.getTest4()) || isIjodiyTest(dto.getTest5())) {
            educationField.setIjodiy(true);
        }
    }

    private boolean isIjodiyTest(Integer testId) {
        return testId != null && testId == 1;
    }

    private void setTestSubjects(TestEducationField testEducationField, TestEducationFieldDTO dto) {
        testEducationField.setTest1(fetchTestSubject(dto.getTest1()));
        testEducationField.setTest2(fetchTestSubject(dto.getTest2()));
        testEducationField.setTest3(fetchTestSubject(dto.getTest3()));
        testEducationField.setTest4(fetchTestSubject(dto.getTest4()));
        testEducationField.setTest5(fetchTestSubject(dto.getTest5()));
    }

    private TestSubject fetchTestSubject(Integer testId) {
        return testSubjectRepo.findById(testId)
                .orElseThrow(() -> new IllegalArgumentException("TestSubject not found for ID: " + testId));
    }


    @DeleteMapping("/{id}")
    public HttpEntity<?> delete(@PathVariable Integer id) {
        Optional<TestEducationField> testEducationFieldOptional = testEducationFieldRepo.findById(id);
        if (testEducationFieldOptional.isEmpty()) {
            return ResponseEntity.badRequest().body("TestEducationField not found!");
        }

        testEducationFieldRepo.deleteById(id);
        return ResponseEntity.ok("TestEducationField deleted successfully!");
    }
}
