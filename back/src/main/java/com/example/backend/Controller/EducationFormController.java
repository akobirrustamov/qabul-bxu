package com.example.backend.Controller;

import com.example.backend.DTO.EducationFormDTO;
import com.example.backend.Entity.EducationForm;
import com.example.backend.Repository.EducationFormRepo;
import com.example.backend.Repository.EducationTypeRepo;
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
@RequestMapping("/api/v1/education-form")
public class EducationFormController {

    private final EducationTypeRepo educationTypeRepo;
    private final EducationFormRepo educationFormRepo;
    @GetMapping
    public HttpEntity<?> getAllEducationForm() {
        List<EducationForm> educationForms = educationFormRepo.findAll();
        return ResponseEntity.ok(educationForms);
    }

    @GetMapping("/{id}")
    public HttpEntity<?> getEducationFormById(@PathVariable Integer id) {
        List<EducationForm> byId = educationFormRepo.findByEducationTypeId(id);
        System.out.println(byId);
        return ResponseEntity.ok(byId);
    }
    @PostMapping
    public HttpEntity<?> addEducationForm(@RequestBody EducationFormDTO educationFormDTO) {
        EducationForm educationForm = new EducationForm(
                null,
                educationFormDTO.getName(),
                educationTypeRepo.findById(educationFormDTO.getEducationTypeId()).orElseThrow(() -> new RuntimeException("EducationType not found")),
                true, // Default to active
                LocalDateTime.now()
        );
        educationFormRepo.save(educationForm);
        return ResponseEntity.ok("Muvaffaqiyatli saqlandi!"); // Success message
    }
    @PutMapping("/{id}")
    public HttpEntity<?> updateEducationForm(@PathVariable Integer id, @RequestBody EducationFormDTO educationFormDTO) {
        Optional<EducationForm> optionalEducationForm = educationFormRepo.findById(id);

        if (optionalEducationForm.isEmpty()) {
            return ResponseEntity.status(404).body("EducationForm not found");
        }

        EducationForm educationForm = optionalEducationForm.get();
        educationForm.setName(educationFormDTO.getName());
        educationForm.setEducationType(
                educationTypeRepo.findById(educationFormDTO.getEducationTypeId()).orElseThrow(() -> new RuntimeException("EducationType not found"))
        );
        educationForm.setIsActive(educationFormDTO.getIsActive());
        educationForm.setCreatedAt(LocalDateTime.now()); // Update createdAt if needed

        educationFormRepo.save(educationForm);
        return ResponseEntity.ok("EducationForm updated successfully");
    }

    // Delete EducationForm by ID
    @DeleteMapping("/{id}")
    public HttpEntity<?> deleteEducationForm(@PathVariable Integer id) {
        Optional<EducationForm> optionalEducationForm = educationFormRepo.findById(id);

        if (optionalEducationForm.isEmpty()) {
            return ResponseEntity.status(404).body("EducationForm not found");
        }

        educationFormRepo.deleteById(id);
        return ResponseEntity.noContent().build(); // Successful deletion
    }
}
