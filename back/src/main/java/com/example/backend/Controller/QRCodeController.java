package com.example.backend.Controller;

import com.example.backend.DTO.QRCodeDTO;
import com.example.backend.Entity.Abuturient;
import com.example.backend.Entity.Attachment;
import com.example.backend.Entity.QRCode;
import com.example.backend.Entity.User;
import com.example.backend.Repository.AbuturientRepo;
import com.example.backend.Repository.AttachmentRepo;
import com.example.backend.Repository.QRCodeRepo;
import com.example.backend.Repository.UserRepo;
import com.google.zxing.BarcodeFormat;
import com.google.zxing.WriterException;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.qrcode.QRCodeWriter;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.io.File;
import java.io.IOException;
import java.nio.file.FileSystems;
import java.nio.file.Path;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@RestController
@RequiredArgsConstructor
@CrossOrigin
@RequestMapping("/api/v1/qr-code")
public class QRCodeController {
    private final QRCodeRepo qrCodeRepo;
    private final UserRepo userRepo;
    private final AttachmentRepo attachmentRepo;
    private final AbuturientRepo abuturientRepo;
    @GetMapping
    public HttpEntity<?> getQRCode() {
        return ResponseEntity.ok(qrCodeRepo.findAll());
    }


    @GetMapping("/{cardId}")
    public HttpEntity<?> getQRCodeByCardId(@PathVariable UUID cardId) {
        Optional<QRCode> byId = qrCodeRepo.findById(cardId);
        if (byId.isEmpty()) {
            return ResponseEntity.notFound().build();
        }
        QRCode qrCode = byId.get();
        return ResponseEntity.ok(qrCode);

    }

    @PostMapping("/new")
    public HttpEntity<?> newQRCode(@RequestBody QRCodeDTO qrCodeDTO) {
        Optional<User> agentById = userRepo.findById(qrCodeDTO.getAgentID());
        if (agentById.isEmpty()) {
            return new ResponseEntity<>("Agent not found", HttpStatus.NOT_FOUND);
        }

        User agent = agentById.get();
        int count = qrCodeDTO.getCount();
        LocalDateTime now = LocalDateTime.now();

        // QR turini nom bilan belgilaymiz
        String typeName;
        if (qrCodeDTO.getType() == 1) {
            typeName = "gold";
        } else if (qrCodeDTO.getType() == 2) {
            typeName = "silver";
        } else {
            typeName = "unknown";
        }

        // Fayl prefixi va papka yo‘li
        String prefix = "/qr-code/" + agent.getName() + "/" + typeName;
        String baseDir = "backend/files" + prefix;

        File directory = new File(baseDir);
        if (!directory.exists()) {
            directory.mkdirs();
        }

        for (int i = 0; i < count; i++) {
            Integer serialNumber;
            do {
                serialNumber = 1000 + (int) (Math.random() * 8999);
            } while (qrCodeRepo.existsBySerialNumber(serialNumber));

            String fileName = serialNumber + ".png";
            String fullPath = baseDir + "/" + fileName;

            // Attachment
            Attachment attachment = new Attachment();
            attachment.setId(UUID.randomUUID());
            attachment.setPrefix(prefix);
            attachment.setName(fileName);
            attachmentRepo.save(attachment);

            // QRCode
            QRCode qrCode = new QRCode(
                    agent,
                    attachment,
                    serialNumber,
                    now,
                    1,
                    qrCodeDTO.getType()
            );

            QRCode savedQRCode = qrCodeRepo.save(qrCode);
            UUID qrCodeId = savedQRCode.getId();

            String qrContent = "https://qabul.bxu.uz/card/" + qrCodeId;

            try {
                generateQRCodeImage(qrContent, 300, 300, fullPath);
            } catch (WriterException | IOException e) {
                return new ResponseEntity<>("QR code generation error", HttpStatus.INTERNAL_SERVER_ERROR);
            }
        }

        return ResponseEntity.ok(count + " QR codes generated successfully");
    }


    private void generateQRCodeImage(String text, int width, int height, String filePath)
            throws WriterException, IOException {
        QRCodeWriter qrCodeWriter = new QRCodeWriter();
        var bitMatrix = qrCodeWriter.encode(text, BarcodeFormat.QR_CODE, width, height);
        Path path = FileSystems.getDefault().getPath(filePath);
        MatrixToImageWriter.writeToPath(bitMatrix, "PNG", path);
    }




    @GetMapping("/me/{userId}")
    public HttpEntity<?> getUserQRCode(@PathVariable UUID userId) {
        List<QRCode> qrCodeList = qrCodeRepo.findByAgentId(userId);
        Boolean result;
        if (qrCodeList.size() > 0) result = true;
        else result = false;
        return ResponseEntity.ok(result);

    }


    @GetMapping("/my-qr-code/{userId}")
    public HttpEntity<?> getUserQRCodes(@PathVariable UUID userId) {
        List<QRCode> qrCodeList = qrCodeRepo.findByAgentId(userId);
        return ResponseEntity.ok(qrCodeList);
    }


    @PutMapping("/connect/{cardId}/{abuturientId}")
    public HttpEntity<?> putConnectQRCode(@PathVariable UUID cardId, @PathVariable UUID abuturientId) {
        Optional<Abuturient> byId = abuturientRepo.findById(abuturientId);
        if (byId.isEmpty()) return new ResponseEntity<>("Abuturent not found", HttpStatus.NOT_FOUND);
        Abuturient abuturent = byId.get();
        Optional<QRCode> byId1 = qrCodeRepo.findById(cardId);
        if (byId1.isEmpty()) return new ResponseEntity<>("Abuturent not found", HttpStatus.NOT_FOUND);
        QRCode qrCode = byId1.get();
        qrCode.setAbuturient(abuturent);
        qrCode.setStatus(2);
        qrCodeRepo.save(qrCode);
        return ResponseEntity.ok(qrCode);
    }


}
