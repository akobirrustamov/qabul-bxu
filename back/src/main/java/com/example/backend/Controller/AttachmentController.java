package com.example.backend.Controller;

import com.example.backend.Services.AttachmentService.AttachmentService;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.UUID;

@RestController
@RequestMapping("/api/v1/file")
@RequiredArgsConstructor
public class AttachmentController {
    private final AttachmentService attachmentService;

    @PostMapping("/upload")
    public HttpEntity<?> uploadFile(@RequestParam MultipartFile photo, @RequestParam String prefix) throws IOException {
        return attachmentService.uploadFile(photo, prefix);
    }

    @GetMapping("/getFile/{id}")
    public void getFile(HttpServletResponse response, @PathVariable UUID id) throws IOException {
        attachmentService.getFile(response, id);
    }

}
