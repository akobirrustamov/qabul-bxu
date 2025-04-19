package com.example.backend.Controller;

import com.example.backend.DTO.TestSubjectDTO;
import com.example.backend.Entity.Attachment;
import com.example.backend.Entity.TestSubject;
import com.example.backend.Repository.AttachmentRepo;
import com.example.backend.Repository.TestSubjectRepo;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpEntity;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;

@RestController
@RequiredArgsConstructor
@CrossOrigin
@RequestMapping("/api/v1/subject-test")
public class TestSubjectController {
    private final TestSubjectRepo testSubjectRepo;
    private final AttachmentRepo attachmentRepo;

    @GetMapping("/{status}")
    public HttpEntity<?> getTestSubject(@PathVariable String status){
        List<TestSubject> testSubjects = testSubjectRepo.findByStatus(status);
        return ResponseEntity.ok(testSubjects);
    }

}
