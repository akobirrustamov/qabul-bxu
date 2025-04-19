package com.example.backend.Config;

import com.example.backend.Entity.*;
import com.example.backend.Enums.UserRoles;
import com.example.backend.Repository.*;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.security.crypto.password.PasswordEncoder;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.*;

@Configuration
@RequiredArgsConstructor
public class AutoRun implements CommandLineRunner {
    private final RoleRepo roleRepo;
    private final UserRepo userRepo;
    private final PasswordEncoder passwordEncoder;
    private final EducationLanguageRepo educationLanguageRepo;
    private final EducationTypeRepo educationTypeRepo;
    private final EducationFormRepo educationFormRepo;
    private final EducationFieldRepo educationFieldRepo;
    private final AppealTypeRepo appealTypeRepo;
    private final TestSubjectRepo testSubjectRepo;
    @Override
    public void run(String... args) throws Exception {
        String adminPhone = "admin1234";
        if (roleRepo.findAll().isEmpty()) {
            List<Role> savedRoles = saveRoles();
        }
        Optional<User> userByPhone = userRepo.findByPhone(adminPhone);
        saveUser(adminPhone, userByPhone);
        if(educationLanguageRepo.findAll().isEmpty()) {
            saveEducationLanguage();
        }
        if(educationTypeRepo.findAll().isEmpty()) {
            saveEducationType();
        }
        if (educationFormRepo.findAll().isEmpty()) {
            saveEducationForm();
        }
        if (educationFieldRepo.findAll().isEmpty()) {
            saveEducationField();
        }
        if (appealTypeRepo.findAll().isEmpty()) {
            saveAppealType();
        }
        if (testSubjectRepo.findAll().isEmpty()) {
            TestSubject testSubject = new TestSubject( "Ijodiy imtihon", "", "2", LocalDateTime.now());
            testSubjectRepo.save(testSubject);
        }


        if(userRepo.findByPhone("admin_bxu").isEmpty()){
            User user = User.builder()
                    .phone("admin_bxu")
                    .name("Admin")
                    .password(passwordEncoder.encode("00000000"))
                    .roles(List.of(roleRepo.findByName(UserRoles.ROLE_ADMIN), roleRepo.findByName(UserRoles.ROLE_DATA_MANAGER)))
                    .build();
            userRepo.save(user);
        }

    }
    private void saveAppealType() {
        appealTypeRepo.save(new AppealType(1, "O'qishga topshirish", true, LocalDateTime.now()));
        appealTypeRepo.save(new AppealType(2, "O'qishni ko'chirish", true, LocalDateTime.now()));
    }



    private void saveEducationLanguage() {
        educationLanguageRepo.saveAll(List.of(
                new EducationLanguage(1, "O'zbek", true, LocalDateTime.now()),
                new EducationLanguage(2, "RUS",true, LocalDateTime.now())
        ));
    }
    private void saveEducationType() {
        educationTypeRepo.saveAll(List.of(
                new EducationType(1, "Bakalavr",true, LocalDateTime.now()),
                new EducationType(2, "Magistr",true, LocalDateTime.now())
        ));
    }
    private void saveEducationForm() {
        educationFormRepo.saveAll(List.of(
                new EducationForm(1, "Kunduzgi", educationTypeRepo.findById(1).orElseThrow(), true, LocalDateTime.now()),
                new EducationForm(2, "Sirtqi", educationTypeRepo.findById(1).orElseThrow(), true, LocalDateTime.now()),
                new EducationForm(3, "Masofaviy", educationTypeRepo.findById(1).orElseThrow(), true, LocalDateTime.now()),
                new EducationForm(4, "Kechgi", educationTypeRepo.findById(1).orElseThrow(), true, LocalDateTime.now()),
                new EducationForm(5, "Kunduzgi", educationTypeRepo.findById(2).orElseThrow(), true, LocalDateTime.now())
//                new EducationForm(6, "Masofaviy", educationTypeRepo.findById(2).orElseThrow(), true, LocalDateTime.now())
        ));
    }

    private void saveEducationField() {
        educationFieldRepo.saveAll(List.of(
                new EducationField("60310300 - Psixologiya", educationFormRepo.findById(1).orElseThrow(), 4, "15000000", true, LocalDateTime.now(), false),
                new EducationField("60110900 - Xorijiy til va adabiyoti (tillar bo'yicha)", educationFormRepo.findById(1).orElseThrow(), 4, "15000000", true, LocalDateTime.now(), false),
                new EducationField("60112600 - Maktabgacha va boshlangich talimda xorijiy til)", educationFormRepo.findById(1).orElseThrow(), 4, "15000000", true, LocalDateTime.now(), false),
                new EducationField("60410100 - Iqtisodiyot", educationFormRepo.findById(1).orElseThrow(), 4, "15000000", true, LocalDateTime.now(), false),
                new EducationField("60110700 - Uzbek tili va adabiyoti", educationFormRepo.findById(1).orElseThrow(), 4, "15000000", true, LocalDateTime.now(),false),
                new EducationField("60220300 - Tarix", educationFormRepo.findById(1).orElseThrow(), 4, "15000000", true, LocalDateTime.now(), false),
                new EducationField("60110600 - Musiqa talimi", educationFormRepo.findById(1).orElseThrow(), 3, "15000000", true, LocalDateTime.now(), true),
                new EducationField("60110200 - Maktabgacha talim", educationFormRepo.findById(1).orElseThrow(), 3, "15000000", true, LocalDateTime.now(), false),
                new EducationField("60110400 - Boshlangich talim", educationFormRepo.findById(1).orElseThrow(), 4, "15000000", true, LocalDateTime.now(), false),
                new EducationField("60111200 - Jismoniy madaniyat", educationFormRepo.findById(1).orElseThrow(), 3, "15000000", true, LocalDateTime.now(), false),
                new EducationField("60111100 - Milly g'oya, ma'naviyat asoslari va huquq ta'limi", educationFormRepo.findById(1).orElseThrow(), 4, "15000000", true, LocalDateTime.now(), false),
                new EducationField("60610100 - Axborot tizimlari va texnologiyalari", educationFormRepo.findById(1).orElseThrow(), 4, "15000000", true, LocalDateTime.now(), false),
                new EducationField("61010100 - Turizm va mehmondo'stlik", educationFormRepo.findById(1).orElseThrow(), 4, "15000000", true, LocalDateTime.now(), false),
                new EducationField("60110300 - Maxsus pedagogika (Logopediya)", educationFormRepo.findById(1).orElseThrow(), 4, "15000000", true, LocalDateTime.now(), false),
                new EducationField("60310903 - Amaliy psixologiya", educationFormRepo.findById(1).orElseThrow(), 4, "15000000", true, LocalDateTime.now(), false),
                new EducationField("61010400 - Logistika", educationFormRepo.findById(1).orElseThrow(), 4, "15000000", true, LocalDateTime.now(), false),
                new EducationField("60540100 - Matematika", educationFormRepo.findById(1).orElseThrow(), 4, "15000000", true, LocalDateTime.now(), false),
                new EducationField("60110800 - Ona tili va adabiyoti (Rus tili)", educationFormRepo.findById(1).orElseThrow(), 4, "15000000", true, LocalDateTime.now(), false),

                new EducationField("60310300 - Psixologiya", educationFormRepo.findById(2).orElseThrow(), 5, "12000000", true, LocalDateTime.now(), false),
                new EducationField("60110200 - Maktabgacha talim", educationFormRepo.findById(2).orElseThrow(), 5, "12000000", true, LocalDateTime.now(), false),
                new EducationField("60410100 - Iqtisodiyot", educationFormRepo.findById(2).orElseThrow(), 5, "12000000", true, LocalDateTime.now(), false),
                new EducationField("60220300 - Tarix", educationFormRepo.findById(2).orElseThrow(), 5, "12000000", true, LocalDateTime.now(), false),
                new EducationField("60110400 - Boshlangich talim", educationFormRepo.findById(2).orElseThrow(), 5, "12000000", true, LocalDateTime.now(), false),
                new EducationField("60110600 - Musiqa talimi", educationFormRepo.findById(2).orElseThrow(), 5, "12000000", true, LocalDateTime.now(), true),
                new EducationField("60111200 - Jismoniy madaniyat", educationFormRepo.findById(2).orElseThrow(), 5, "12000000", true, LocalDateTime.now(), false),
                new EducationField("60111100 - Milly g'oya, ma'naviyat asoslari va huquq ta'limi", educationFormRepo.findById(2).orElseThrow(), 5, "12000000", true, LocalDateTime.now(), false),
                new EducationField("60610100 - Axborot tizimlari va texnologiyalari", educationFormRepo.findById(2).orElseThrow(), 5, "12000000", true, LocalDateTime.now(), false),
                new EducationField("61010100 - Turizm va mehmondo'stlik", educationFormRepo.findById(2).orElseThrow(), 5, "12000000", true, LocalDateTime.now(), false),
                new EducationField("60111400 - Uzbek tili va adabiyoti", educationFormRepo.findById(2).orElseThrow(), 5, "12000000", true, LocalDateTime.now(), false),
                new EducationField("60310903-  Amaliy psixologiya", educationFormRepo.findById(2).orElseThrow(), 5, "12000000", true, LocalDateTime.now(), false),
                new EducationField("61010400 - Logistika", educationFormRepo.findById(2).orElseThrow(), 5, "12000000", true, LocalDateTime.now(),    false),

                new EducationField("60110400 - Boshlangich talim", educationFormRepo.findById(4).orElseThrow(), 5, "12000000", true, LocalDateTime.now(), false),
                new EducationField("60110600 - Musiqa talimi", educationFormRepo.findById(4).orElseThrow(), 5, "12000000", true, LocalDateTime.now(), true),
                new EducationField("60110700 - Uzbek tili va adabiyoti", educationFormRepo.findById(4).orElseThrow(), 5, "12000000", true, LocalDateTime.now(), false),
                new EducationField("60111200 - Jismoniy madaniyat", educationFormRepo.findById(4).orElseThrow(), 5, "12000000", true, LocalDateTime.now(), false),
                new EducationField("60110300 - Maxsus pedagogika (Logopediya)", educationFormRepo.findById(4).orElseThrow(), 5, "12000000", true, LocalDateTime.now(), false),
                new EducationField("60110900 - Xorijiy til va adabiyoti (tillar bo'yicha)", educationFormRepo.findById(4).orElseThrow(), 4, "12000000", true, LocalDateTime.now(), false),

                new EducationField("60310300 - Psixologiya", educationFormRepo.findById(3).orElseThrow(), 4, "10000000", true, LocalDateTime.now(), false),
                new EducationField("60410100 - Iqtisodiyot", educationFormRepo.findById(3).orElseThrow(), 4, "10000000", true, LocalDateTime.now(), false),
                new EducationField("60110700 - Uzbek tili va adabiyoti", educationFormRepo.findById(3).orElseThrow(), 4, "10000000", true, LocalDateTime.now(), false),
                new EducationField("60110200 - Maktabgacha talim", educationFormRepo.findById(3).orElseThrow(), 3, "10000000", true, LocalDateTime.now(), false),
                new EducationField("60110400 - Boshlangich talim", educationFormRepo.findById(3).orElseThrow(), 5, "10000000", true, LocalDateTime.now(), false),
                new EducationField("60111100 - Milly g'oya, ma'naviyat asoslari va huquq ta'limi", educationFormRepo.findById(3).orElseThrow(), 4, "10000000", true, LocalDateTime.now(), false),
                new EducationField("61010400 - Logistika", educationFormRepo.findById(3).orElseThrow(), 4, "10000000", true, LocalDateTime.now(), false),
                new EducationField("60540100 - Matematika", educationFormRepo.findById(3).orElseThrow(), 4, "10000000", true, LocalDateTime.now(), false),
                new EducationField("60110800 - Ona tili va adabiyoti (Rus tili)", educationFormRepo.findById(3).orElseThrow(), 4, "10000000", true, LocalDateTime.now(), false),

                new EducationField("70310301 - Psixologiya", educationFormRepo.findById(5).orElseThrow(), 2, "18000000", true, LocalDateTime.now(), false),
                new EducationField("70410102 - Iqtisodiyot", educationFormRepo.findById(5).orElseThrow(), 2, "18000000", true, LocalDateTime.now(), false),
                new EducationField("70110401 - Ta'lim va tarbiya nazariyasi va metodikasi (boshlang'ich ta'lim)", educationFormRepo.findById(5).orElseThrow(), 2, "18000000", true, LocalDateTime.now(), false),
                new EducationField("70110601 - Musiqa ta'limi va san'at", educationFormRepo.findById(5).orElseThrow(), 2, "18000000", true, LocalDateTime.now(), true),
                new EducationField("70111201 - Jismoniy tarbiya va sport mashg'ulotlari nazariyasi va metodikasi", educationFormRepo.findById(5).orElseThrow(), 2, "18000000", true, LocalDateTime.now(), false),
                new EducationField("70110101 - Pedagogika nazariyasi va tarixi", educationFormRepo.findById(5).orElseThrow(), 2, "18000000", true, LocalDateTime.now(), false),
                new EducationField("70110701 - O'zbek tili va adabiyoti", educationFormRepo.findById(5).orElseThrow(), 2, "18000000", true, LocalDateTime.now(), false),
                new EducationField("70230101 - Lingvistika (tillar bo'yicha)", educationFormRepo.findById(5).orElseThrow(), 2, "18000000", true, LocalDateTime.now(), false)
                ));
    }

    private void saveUser(String adminPhone, Optional<User> userByPhone) {
        if (userByPhone.isEmpty()) {
            User user = User.builder()
                    .phone(adminPhone)
                    .name("Admin1")
                    .password(passwordEncoder.encode("00000000"))
                    .roles(List.of(roleRepo.findByName(UserRoles.ROLE_ADMIN), roleRepo.findByName(UserRoles.ROLE_DATA_MANAGER)))
                    .build();
            userRepo.save(user);
            User user1 = User.builder()
                    .phone(adminPhone+"5")
                    .name("Admin2")
                    .password(passwordEncoder.encode("00000000"))
                    .roles(List.of(roleRepo.findByName(UserRoles.ROLE_ADMIN)))
                    .build();
            userRepo.save(user1);

            User generator = User.builder()
                    .phone("generator")
                    .name("Generator")
                    .password(passwordEncoder.encode("bxu_qabul"))
                    .roles(List.of(roleRepo.findByName(UserRoles.ROLE_SUPER_ADMIN), roleRepo.findByName(UserRoles.ROLE_DATA_MANAGER)))
                    .build();
            userRepo.save(generator);
        }
    }

    private List<Role> saveRoles() {
        return roleRepo.saveAll(List.of(
                new Role(1, UserRoles.ROLE_SUPER_ADMIN),
                new Role(2, UserRoles.ROLE_ADMIN),
                new Role(3, UserRoles.ROLE_WORKER),
                new Role(4, UserRoles.ROLE_AGENT),
                new Role(5, UserRoles.ROLE_OPERATOR),
                new Role(6, UserRoles.ROLE_STUDENT),
                new Role(7, UserRoles.ROLE_DATA_MANAGER)

        ));
    }



}
