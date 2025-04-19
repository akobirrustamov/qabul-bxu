package com.example.backend.Controller;

import com.example.backend.DTO.AbuturientPostDTO;
import com.example.backend.Entity.*;
import com.example.backend.Enums.UserRoles;
import com.example.backend.Repository.*;
import com.example.backend.Services.AuthService.AuthService;
import com.example.backend.Services.ExcelExportService;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.core.io.InputStreamResource;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.web.PageableDefault;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.*;

import java.io.ByteArrayInputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@RestController
@RequiredArgsConstructor
@CrossOrigin
@RequestMapping("/api/v1/admin")
public class AdminController {
    private final UserRepo userRepo;
    private final AbuturientRepo abuturientRepo;
    private final RoleRepo roleRepo;
    private final AuthService service;
    private final EducationFieldRepo educationFieldRepo;
    private final AppealTypeRepo appealTypeRepo;
    private final HistoryRepo historyRepo;
    private final ExcelExportService excelExportService;
//    @GetMapping("/appeals")
//    public HttpEntity<?> getAbuturients() {
//        return ResponseEntity.ok(abuturientRepo.findAll());
//    }

    @GetMapping("/appeals")
    public ResponseEntity<?> getAbuturients(
            @RequestParam(required = false, defaultValue = "") String firstName,
            @RequestParam(required = false, defaultValue = "") String lastName,
            @RequestParam(required = false, defaultValue = "") String fatherName,
            @RequestParam(required = false, defaultValue = "") String passportNumber,
            @RequestParam(required = false, defaultValue = "") String passportPin,
            @RequestParam(required = false, defaultValue = "") String phone,
            @RequestParam(required = false) Integer appealTypeId,
            @RequestParam(required = false) Integer educationFieldId,
            @RequestParam(required = false) UUID agentId,
            @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate createdAt,
            @PageableDefault(size = 2, page = 0) Pageable pageable) {
            System.out.println(createdAt);
            System.out.println(firstName);

            Page<Abuturient> abuturients = abuturientRepo.findByFilters(
                    firstName,
                    passportNumber,
                    passportPin,
                    phone,
                    appealTypeId,
                    educationFieldId,
                    agentId,
                    createdAt,
                    pageable);
            return ResponseEntity.ok(abuturients);
    }



    @GetMapping("/appeals/excel")
    public void exportAbuturientsToExcel(
            @RequestParam(required = false, defaultValue = "") String firstName,
            @RequestParam(required = false, defaultValue = "") String lastName,
            @RequestParam(required = false, defaultValue = "") String fatherName,
            @RequestParam(required = false, defaultValue = "") String passportNumber,
            @RequestParam(required = false, defaultValue = "") String passportPin,
            @RequestParam(required = false, defaultValue = "") String phone,
            @RequestParam(required = false) Integer appealTypeId,
            @RequestParam(required = false) Integer educationFieldId,
            @RequestParam(required = false) UUID agentId,
            @RequestParam(required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate createdAt,
            HttpServletResponse response) throws IOException {

        // Generate the Excel file
        ByteArrayInputStream in = excelExportService.exportToExcel(
                firstName, lastName, fatherName, passportNumber, passportPin, phone,
                appealTypeId, educationFieldId, agentId, createdAt);

        // Set response headers
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=abiturients.xlsx");

        // Write the Excel file to the response output stream
        FileCopyUtils.copy(in, response.getOutputStream());
    }






    @PutMapping("/appeals/{id}/{token}")
    public HttpEntity<?> updateAbuturient(@PathVariable UUID id, @PathVariable String token, @RequestBody AbuturientPostDTO dto) {
        Optional<Abuturient> optionalAbuturient = abuturientRepo.findById(id);
        User decode = service.decode(token);
        if (!optionalAbuturient.isPresent()) {
            return ResponseEntity.notFound().build();
        }
        Abuturient abuturient = optionalAbuturient.get();
        Optional<EducationField> edu = educationFieldRepo.findById(dto.getEducationFieldId());
        Optional<AppealType> appealType = appealTypeRepo.findById(dto.getAppealTypeId());
        if (!edu.isPresent()) {
            return ResponseEntity.notFound().build();
        }
        if (!appealType.isPresent()) {
            return ResponseEntity.notFound().build();
        }

        History history = new History(decode, abuturient, abuturient.getFirstName(), abuturient.getLastName(), abuturient.getPassportNumber(),abuturient.getFatherName(), abuturient.getPassportPin(), abuturient.getAdditionalPhone(),abuturient.getAppealType(), abuturient.getEducationField(), dto.getFirstName(), dto.getLastName(), dto.getFatherName(), dto.getPassportNumber(), dto.getPassportPin(), dto.getPhone(), appealType.get(), edu.get(), LocalDateTime.now());
        abuturient.setFirstName(dto.getFirstName());
        abuturient.setLastName(dto.getLastName());
        abuturient.setFatherName(dto.getFatherName());
        if(!dto.getPassportPin().isEmpty()){
            abuturient.setPassportPin(dto.getPassportPin());
            abuturient.setPassportNumber(dto.getPassportNumber());
        }

        abuturient.setEducationField(edu.get());
        abuturient.setAppealType(appealType.get());
        abuturientRepo.save(abuturient);
        historyRepo.save(history);
        return ResponseEntity.ok("Abuturient updated successfully!");
    }

    @PutMapping("/status/{id}")
    public HttpEntity<?> updateStatus(@PathVariable UUID id) {
        Optional<User> optionalUser = userRepo.findById(id);
        if (!optionalUser.isPresent()) {
            return ResponseEntity.notFound().build();
        }

        User user = optionalUser.get();
        List<Role> roles = user.getRoles();
        Role dataManagerRole = roleRepo.findByName(UserRoles.ROLE_DATA_MANAGER);

        if (roles.contains(dataManagerRole)) {
            // If the role exists, remove it
            System.out.println("remove");
            roles.remove(dataManagerRole);
        } else {
            // If the role doesn't exist, add it
            System.out.println("add");
            roles.add(dataManagerRole);
        }

        user.setRoles(roles);
        userRepo.save(user);

        return ResponseEntity.ok("User updated successfully!");
    }


    @PutMapping("/appeals/ball/{id}/{ball}/{token}")
    public HttpEntity<?> updateAbuturientBall(
            @PathVariable UUID id,
            @PathVariable Double ball,
            @PathVariable String token
    ) {
        Optional<Abuturient> optionalAbuturient = abuturientRepo.findById(id);
        if (!optionalAbuturient.isPresent()) {
            return ResponseEntity.notFound().build();
        }

        Abuturient abuturient = optionalAbuturient.get();

        if (ball <= 0 || ball >= 189) {
            return ResponseEntity.badRequest().body("Ball 0 dan katta va 189 dan kichik bo‘lishi kerak.");
        }

        abuturient.setBall(ball.toString());
        abuturientRepo.save(abuturient);

        return ResponseEntity.ok("Ball muvaffaqiyatli yangilandi.");
    }


}
