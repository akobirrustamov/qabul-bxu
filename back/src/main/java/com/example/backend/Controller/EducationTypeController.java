package com.example.backend.Controller;

import com.example.backend.Entity.EducationType;
import com.example.backend.Repository.EducationTypeRepo;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpEntity;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@RestController
@RequiredArgsConstructor
@CrossOrigin
@RequestMapping("/api/v1/education-type")
public class EducationTypeController {

    private final EducationTypeRepo educationTypeRepo;

    // Get all EducationTypes
    @GetMapping
    public HttpEntity<?> getAllEducationType() {
        List<EducationType> educationTypeList = educationTypeRepo.findAll();
        return ResponseEntity.ok(educationTypeList);
    }

    // Add a new EducationType
    @PostMapping
    public HttpEntity<?> addEducationType(@RequestBody Map<String, String> educationType) {
        String name = educationType.get("name");
        if (name == null || name.isEmpty()) {
            return ResponseEntity.badRequest().body("EducationType name cannot be null or empty");
        }

        EducationType newEducationType = new EducationType(name, true, LocalDateTime.now());
        educationTypeRepo.save(newEducationType);
        return ResponseEntity.ok("EducationType successfully saved!");
    }

    @PutMapping("/{id}")
    public HttpEntity<?> updateEducationType(@PathVariable Integer id, @RequestBody Map<String, String> educationType) {
        Optional<EducationType> optionalEducationType = educationTypeRepo.findById(id);

        if (optionalEducationType.isEmpty()) {
            return ResponseEntity.status(404).body("EducationType not found");
        }

        String name = educationType.get("name");
        if (name == null || name.isEmpty()) {
            return ResponseEntity.badRequest().body("EducationType name cannot be null or empty");
        }

        EducationType existingEducationType = optionalEducationType.get();
        existingEducationType.setName(name);
        existingEducationType.setIsActive(Boolean.valueOf(educationType.get("isActive"))); // Update as active by default if needed
        educationTypeRepo.save(existingEducationType);

        return ResponseEntity.ok("EducationType successfully updated!");
    }

    // Delete an EducationType by ID
    @DeleteMapping("/{id}")
    public HttpEntity<?> deleteEducationType(@PathVariable Integer id) {
        Optional<EducationType> optionalEducationType = educationTypeRepo.findById(id);

        if (optionalEducationType.isEmpty()) {
            return ResponseEntity.status(404).body("EducationType not found");
        }

        educationTypeRepo.deleteById(id);
        return ResponseEntity.noContent().build(); // Successful deletion
    }
}
