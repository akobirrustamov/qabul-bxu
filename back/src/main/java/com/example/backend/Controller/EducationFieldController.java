package com.example.backend.Controller;

import com.example.backend.DTO.EducationFieldDTO;
import com.example.backend.Entity.EducationField;
import com.example.backend.Entity.User;
import com.example.backend.Enums.UserRoles;
import com.example.backend.Repository.EducationFieldRepo;
import com.example.backend.Repository.EducationFormRepo;
import com.example.backend.Services.AuthService.AuthService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpEntity;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@RestController
@RequiredArgsConstructor
@CrossOrigin
@RequestMapping("/api/v1/education-field")
public class EducationFieldController {

    private final EducationFieldRepo educationFieldRepo;
    private final AuthService service;
    private final EducationFormRepo educationFormRepo;

    @GetMapping
    public HttpEntity<?> getAllEducationField() {
        List<EducationField> educationFields = educationFieldRepo.findAllByOrderByName();
        return ResponseEntity.ok(educationFields);
    }

    @GetMapping("/{educationFormId}")
    public HttpEntity<?> getEducationFieldById(@PathVariable Integer educationFormId) {
        List<EducationField> educationFields = educationFieldRepo.findByEducationFormId(educationFormId);
        return ResponseEntity.ok(educationFields);
    }
    @PostMapping
    public HttpEntity<?> addEducationField(@RequestBody EducationFieldDTO educationFieldDTO){
        educationFieldRepo.save(new EducationField(
                educationFieldDTO.getName(),
                educationFormRepo.findById(educationFieldDTO.getEducationFormId()).orElseThrow(),
                educationFieldDTO.getEducationDuration(),
                educationFieldDTO.getPrice(),
                true,  // isActive defaults to true
                LocalDateTime.now(),
                false
        ));
        return ResponseEntity.ok("Muvaffaqiyatli saqlandi!");  // Success message
    }

    @PutMapping("/{id}")
    public HttpEntity<?> updateEducationField(@PathVariable Integer id, @RequestBody EducationFieldDTO educationFieldDTO){
        Optional<EducationField> existingEducationFieldOpt = educationFieldRepo.findById(id);
        System.out.println(educationFieldDTO);
        if (existingEducationFieldOpt.isEmpty()) {
            return ResponseEntity.status(404).body("EducationField not found");
        }

        EducationField existingEducationField = existingEducationFieldOpt.get();

        // Update properties of the existing EducationField
        existingEducationField.setName(educationFieldDTO.getName());
        existingEducationField.setEducationForm(educationFormRepo.findById(educationFieldDTO.getEducationFormId()).orElseThrow());
        existingEducationField.setEducationDuration(educationFieldDTO.getEducationDuration());
        existingEducationField.setPrice(educationFieldDTO.getPrice());
        existingEducationField.setCreatedAt(LocalDateTime.now());  // Optionally update createdAt or leave unchanged
        existingEducationField.setIsActive(educationFieldDTO.getIsActive());
        educationFieldRepo.save(existingEducationField);


        return ResponseEntity.ok("EducationField updated successfully");
    }



    @PutMapping("status/{id}")
    public HttpEntity<?> setStatus(@PathVariable Integer id){
        Optional<EducationField> existingEducationFieldOpt = educationFieldRepo.findById(id);
        if (existingEducationFieldOpt.isEmpty()) {
            return ResponseEntity.status(404).body("EducationField not found");
        }
        EducationField existingEducationField = existingEducationFieldOpt.get();

        existingEducationField.setIsActive(!existingEducationField.getIsActive());
        educationFieldRepo.save(existingEducationField);

        return ResponseEntity.ok("EducationField updated successfully");
    }


    // Delete EducationField by ID
    @DeleteMapping("/{id}")
    public HttpEntity<?> deleteEducationField(@PathVariable Integer id){
        Optional<EducationField> educationFieldOpt = educationFieldRepo.findById(id);
        if (educationFieldOpt.isEmpty()) {
            return ResponseEntity.status(404).body("EducationField not found");
        }
        educationFieldRepo.deleteById(id);
        return ResponseEntity.noContent().build();  // Successful deletion
    }
}
