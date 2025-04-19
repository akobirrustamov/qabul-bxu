package com.example.backend.Controller;

import com.example.backend.Entity.Abuturient;
import com.example.backend.Entity.Attachment;
import com.example.backend.Entity.Certificate;
import com.example.backend.Repository.AbuturientRepo;
import com.example.backend.Repository.AttachmentRepo;
import com.example.backend.Repository.CertificateRepo;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpEntity;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.UUID;

@RestController
@RequestMapping("/api/v1/certificate")
@RequiredArgsConstructor
public class CertificateController {

    private final CertificateRepo certificateRepo;
    private final AbuturientRepo abuturientRepo;
    private final AttachmentRepo attachmentRepo;

    @PostMapping("/{abuturientId}/{fileId}")
    public HttpEntity<?> addCertificate(@PathVariable UUID abuturientId, @PathVariable UUID fileId) {
        Abuturient abuturient = abuturientRepo.findById(abuturientId).orElseThrow();
        Attachment attachment = attachmentRepo.findById(fileId).orElseThrow();
        Certificate certificate = new Certificate(attachment, abuturient);
        certificateRepo.save(certificate);
        return ResponseEntity.ok(certificate);

    }




}
