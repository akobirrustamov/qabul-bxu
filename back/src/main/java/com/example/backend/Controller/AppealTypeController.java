package com.example.backend.Controller;

import com.example.backend.Entity.AppealType;
import com.example.backend.Entity.EducationType;
import com.example.backend.Repository.AppealTypeRepo;
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
@RequestMapping("/api/v1/appeal-type")
public class AppealTypeController {
    private final AppealTypeRepo appealTypeRepo;

    @GetMapping
    public HttpEntity<?> getAllEducationType() {
        List<AppealType> educationTypeList = appealTypeRepo.findAll();
        return ResponseEntity.ok(educationTypeList);
    }

    // Add a new EducationType

}
