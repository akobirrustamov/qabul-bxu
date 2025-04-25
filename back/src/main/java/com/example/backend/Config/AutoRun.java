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
    private final RegionRepo regionRepo;
    private final DistrictRepo districtRepo;
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
        if(regionRepo.findAll().isEmpty()) {
            saveAllRegions();
        }
    }

    private void saveAllRegions() {
        List<Region> regions = List.of(
                new Region(1, "Andijon viloyati", LocalDateTime.now()),
                new Region(2, "Buxoro viloyati", LocalDateTime.now()),
                new Region(3, "Farg'ona viloyati", LocalDateTime.now()),
                new Region(4, "Jizzax viloyati", LocalDateTime.now()),
                new Region(5, "Xorazm viloyati", LocalDateTime.now()),
                new Region(6, "Namangan viloyati", LocalDateTime.now()),
                new Region(7, "Navoiy viloyati", LocalDateTime.now()),
                new Region(8, "Qashqadaryo viloyati", LocalDateTime.now()),
                new Region(9, "Qoraqalpog'iston Respublikasi", LocalDateTime.now()),
                new Region(10, "Samarqand viloyati", LocalDateTime.now()),
                new Region(11, "Sirdaryo viloyati", LocalDateTime.now()),
                new Region(12, "Surxondaryo viloyati", LocalDateTime.now()),
                new Region(13, "Toshkent shahri", LocalDateTime.now()),
                new Region(14, "Toshkent viloyati", LocalDateTime.now())
        );
        List<Region> regions1 = regionRepo.saveAll(regions);
        saveAllDistricts(regions1);
    }

    private void saveAllDistricts(List<Region> regions) {
        Map<Integer, Region> regionMap = new HashMap<>();
        for (Region region : regions) {
            regionMap.put(region.getId(), region);
        }

        List<District> districts = List.of(
                // Andijon viloyati (1)
                new District(1, "Andijon shahri", regionMap.get(1), LocalDateTime.now()),
                new District(2, "Andijon tumani", regionMap.get(1), LocalDateTime.now()),
                new District(3, "Asaka tumani", regionMap.get(1), LocalDateTime.now()),
                new District(4, "Baliqchi tumani", regionMap.get(1), LocalDateTime.now()),
                new District(5, "Bo'z tumani", regionMap.get(1), LocalDateTime.now()),
                new District(6, "Buloqboshi tumani", regionMap.get(1), LocalDateTime.now()),
                new District(7, "Izboskan tumani", regionMap.get(1), LocalDateTime.now()),
                new District(8, "Jalaquduq tumani", regionMap.get(1), LocalDateTime.now()),
                new District(9, "Xo'jaobod tumani", regionMap.get(1), LocalDateTime.now()),
                new District(10, "Qo'rg'ontepa tumani", regionMap.get(1), LocalDateTime.now()),
                new District(11, "Marxamat tumani", regionMap.get(1), LocalDateTime.now()),
                new District(12, "Oltinko'l tumani", regionMap.get(1), LocalDateTime.now()),
                new District(13, "Paxtaobod tumani", regionMap.get(1), LocalDateTime.now()),
                new District(14, "Shahrixon tumani", regionMap.get(1), LocalDateTime.now()),
                new District(15, "Ulug'nor tumani", regionMap.get(1), LocalDateTime.now()),
                new District(16, "Xonobod shahri", regionMap.get(1), LocalDateTime.now()),

                // Buxoro viloyati (2)
                new District(17, "Buxoro shahri", regionMap.get(2), LocalDateTime.now()),
                new District(18, "Buxoro tumani", regionMap.get(2), LocalDateTime.now()),
                new District(19, "G'ijduvon tumani", regionMap.get(2), LocalDateTime.now()),
                new District(20, "Jondor tumani", regionMap.get(2), LocalDateTime.now()),
                new District(21, "Kogon shahri", regionMap.get(2), LocalDateTime.now()),
                new District(22, "Kogon tumani", regionMap.get(2), LocalDateTime.now()),
                new District(23, "Olot tumani", regionMap.get(2), LocalDateTime.now()),
                new District(24, "Peshku tumani", regionMap.get(2), LocalDateTime.now()),
                new District(25, "Qorako'l tumani", regionMap.get(2), LocalDateTime.now()),
                new District(26, "Qorovulbozor tumani", regionMap.get(2), LocalDateTime.now()),
                new District(27, "Romitan tumani", regionMap.get(2), LocalDateTime.now()),
                new District(28, "Shofirkon tumani", regionMap.get(2), LocalDateTime.now()),
                new District(29, "Vobkent tumani", regionMap.get(2), LocalDateTime.now()),

                // Farg'ona viloyati (3)
                new District(30, "Farg'ona shahri", regionMap.get(3), LocalDateTime.now()),
                new District(31, "Beshariq tumani", regionMap.get(3), LocalDateTime.now()),
                new District(32, "Bog'dod tumani", regionMap.get(3), LocalDateTime.now()),
                new District(33, "Buvayda tumani", regionMap.get(3), LocalDateTime.now()),
                new District(34, "Dang'ara tumani", regionMap.get(3), LocalDateTime.now()),
                new District(35, "Farg'ona tumani", regionMap.get(3), LocalDateTime.now()),
                new District(36, "Furqat tumani", regionMap.get(3), LocalDateTime.now()),
                new District(37, "Oltiariq tumani", regionMap.get(3), LocalDateTime.now()),
                new District(38, "O'zbekiston tumani", regionMap.get(3), LocalDateTime.now()),
                new District(39, "Qo'shtepa tumani", regionMap.get(3), LocalDateTime.now()),
                new District(40, "Quva tumani", regionMap.get(3), LocalDateTime.now()),
                new District(41, "Quvasoy shahri", regionMap.get(3), LocalDateTime.now()),
                new District(42, "Rishton tumani", regionMap.get(3), LocalDateTime.now()),
                new District(43, "So'x tumani", regionMap.get(3), LocalDateTime.now()),
                new District(44, "Toshloq tumani", regionMap.get(3), LocalDateTime.now()),
                new District(45, "Uchko'prik tumani", regionMap.get(3), LocalDateTime.now()),
                new District(46, "Yozyovon tumani", regionMap.get(3), LocalDateTime.now()),
                new District(47, "Qo'qon shahri", regionMap.get(3), LocalDateTime.now()),
                new District(48, "Marg'ilon shahri", regionMap.get(3), LocalDateTime.now()),

                // Jizzax viloyati (4)
                new District(49, "Jizzax shahri", regionMap.get(4), LocalDateTime.now()),
                new District(50, "Arnasoy tumani", regionMap.get(4), LocalDateTime.now()),
                new District(51, "Baxmal tumani", regionMap.get(4), LocalDateTime.now()),
                new District(52, "Do'stlik tumani", regionMap.get(4), LocalDateTime.now()),
                new District(53, "Forish tumani", regionMap.get(4), LocalDateTime.now()),
                new District(54, "G'allaorol tumani", regionMap.get(4), LocalDateTime.now()),
                new District(55, "Mirzacho'l tumani", regionMap.get(4), LocalDateTime.now()),
                new District(56, "Paxtakor tumani", regionMap.get(4), LocalDateTime.now()),
                new District(57, "Yangiobod tumani", regionMap.get(4), LocalDateTime.now()),
                new District(58, "Zomin tumani", regionMap.get(4), LocalDateTime.now()),
                new District(59, "Zarbdor tumani", regionMap.get(4), LocalDateTime.now()),
                new District(60, "Zafarobod tumani", regionMap.get(4), LocalDateTime.now()),
                new District(61, "Sh.Rashidov tumani", regionMap.get(4), LocalDateTime.now()),

                // Xorazm viloyati (5)
                new District(62, "Urganch shahri", regionMap.get(5), LocalDateTime.now()),
                new District(63, "Xiva shahri", regionMap.get(5), LocalDateTime.now()),
                new District(64, "Bog'ot tumani", regionMap.get(5), LocalDateTime.now()),
                new District(65, "Gurlan tumani", regionMap.get(5), LocalDateTime.now()),
                new District(66, "Qo'shko'pir tumani", regionMap.get(5), LocalDateTime.now()),
                new District(67, "Urganch tumani", regionMap.get(5), LocalDateTime.now()),
                new District(68, "Xazorasp tumani", regionMap.get(5), LocalDateTime.now()),
                new District(69, "Xonqa tumani", regionMap.get(5), LocalDateTime.now()),
                new District(70, "Xiva tumani", regionMap.get(5), LocalDateTime.now()),
                new District(71, "Shovot tumani", regionMap.get(5), LocalDateTime.now()),
                new District(72, "Yangiariq tumani", regionMap.get(5), LocalDateTime.now()),
                new District(73, "Yangibozor tumani", regionMap.get(5), LocalDateTime.now()),
                new District(74, "Tuproqqal'a tumani", regionMap.get(5), LocalDateTime.now()),

                // Namangan viloyati (6)
                new District(75, "Namangan shahri", regionMap.get(6), LocalDateTime.now()),
                new District(76, "Chortoq tumani", regionMap.get(6), LocalDateTime.now()),
                new District(77, "Chust tumani", regionMap.get(6), LocalDateTime.now()),
                new District(78, "Kosonsoy tumani", regionMap.get(6), LocalDateTime.now()),
                new District(79, "Mingbuloq tumani", regionMap.get(6), LocalDateTime.now()),
                new District(80, "Namangan tumani", regionMap.get(6), LocalDateTime.now()),
                new District(81, "Norin tumani", regionMap.get(6), LocalDateTime.now()),
                new District(82, "Pop tumani", regionMap.get(6), LocalDateTime.now()),
                new District(83, "To'raqo'rg'on tumani", regionMap.get(6), LocalDateTime.now()),
                new District(84, "Uychi tumani", regionMap.get(6), LocalDateTime.now()),
                new District(85, "Uchqo'rg'on tumani", regionMap.get(6), LocalDateTime.now()),
                new District(86, "Yangiqo'rg'on tumani", regionMap.get(6), LocalDateTime.now()),
                new District(87, "Davlatobod tumani", regionMap.get(6), LocalDateTime.now()),
                new District(88, "Yangi Namangan tumani", regionMap.get(6), LocalDateTime.now()),

                // Navoiy viloyati (7)
                new District(89, "Navoiy shahri", regionMap.get(7), LocalDateTime.now()),
                new District(90, "Zarafshon shahri", regionMap.get(7), LocalDateTime.now()),
                new District(91, "Konimex tumani", regionMap.get(7), LocalDateTime.now()),
                new District(92, "Qiziltepa tumani", regionMap.get(7), LocalDateTime.now()),
                new District(93, "Navbahor tumani", regionMap.get(7), LocalDateTime.now()),
                new District(94, "Karmana tumani", regionMap.get(7), LocalDateTime.now()),
                new District(95, "Nurota tumani", regionMap.get(7), LocalDateTime.now()),
                new District(96, "Tomdi tumani", regionMap.get(7), LocalDateTime.now()),
                new District(97, "Uchquduq tumani", regionMap.get(7), LocalDateTime.now()),
                new District(98, "Xatirchi tumani", regionMap.get(7), LocalDateTime.now()),
                new District(99, "G'ozg'on tumani", regionMap.get(7), LocalDateTime.now()),

                // Qashqadaryo viloyati (8)
                new District(100, "Qarshi shahri", regionMap.get(8), LocalDateTime.now()),
                new District(101, "Shahrisabz shahri", regionMap.get(8), LocalDateTime.now()),
                new District(102, "G'uzor tumani", regionMap.get(8), LocalDateTime.now()),
                new District(103, "Dehqonobod tumani", regionMap.get(8), LocalDateTime.now()),
                new District(104, "Qamashi tumani", regionMap.get(8), LocalDateTime.now()),
                new District(105, "Qarshi tumani", regionMap.get(8), LocalDateTime.now()),
                new District(106, "Koson tumani", regionMap.get(8), LocalDateTime.now()),
                new District(107, "Kitob tumani", regionMap.get(8), LocalDateTime.now()),
                new District(108, "Mirishkor tumani", regionMap.get(8), LocalDateTime.now()),
                new District(109, "Muborak tumani", regionMap.get(8), LocalDateTime.now()),
                new District(110, "Nishon tumani", regionMap.get(8), LocalDateTime.now()),
                new District(111, "Kasbi tumani", regionMap.get(8), LocalDateTime.now()),
                new District(112, "Chiroqchi tumani", regionMap.get(8), LocalDateTime.now()),
                new District(113, "Shahrisabz tumani", regionMap.get(8), LocalDateTime.now()),
                new District(114, "Yakkabog' tumani", regionMap.get(8), LocalDateTime.now()),
                new District(115, "Ko'kdala tumani", regionMap.get(8), LocalDateTime.now()),

                // Qoraqalpog'iston Respublikasi (9)
                new District(116, "Nukus shahri", regionMap.get(9), LocalDateTime.now()),
                new District(117, "Amudaryo tumani", regionMap.get(9), LocalDateTime.now()),
                new District(118, "Beruniy tumani", regionMap.get(9), LocalDateTime.now()),
                new District(119, "Qorao'zak tumani", regionMap.get(9), LocalDateTime.now()),
                new District(120, "Kegeyli tumani", regionMap.get(9), LocalDateTime.now()),
                new District(121, "Qo'ng'irot tumani", regionMap.get(9), LocalDateTime.now()),
                new District(122, "Qanliko'l tumani", regionMap.get(9), LocalDateTime.now()),
                new District(123, "Mo'ynoq tumani", regionMap.get(9), LocalDateTime.now()),
                new District(124, "Nukus tumani", regionMap.get(9), LocalDateTime.now()),
                new District(125, "Taxiatosh tumani", regionMap.get(9), LocalDateTime.now()),
                new District(126, "Taxtako'pir tumani", regionMap.get(9), LocalDateTime.now()),
                new District(127, "To'rtko'l tumani", regionMap.get(9), LocalDateTime.now()),
                new District(128, "Xo'jayli tumani", regionMap.get(9), LocalDateTime.now()),
                new District(129, "Chimboy tumani", regionMap.get(9), LocalDateTime.now()),
                new District(130, "Shumanay tumani", regionMap.get(9), LocalDateTime.now()),
                new District(131, "Ellikqal'a tumani", regionMap.get(9), LocalDateTime.now()),
                new District(132, "Bo'zatov tumani", regionMap.get(9), LocalDateTime.now()),

                // Samarqand viloyati (10)
                new District(133, "Samarqand shahri", regionMap.get(10), LocalDateTime.now()),
                new District(134, "Kattaqo'rg'on shahri", regionMap.get(10), LocalDateTime.now()),
                new District(135, "Oqdaryo tumani", regionMap.get(10), LocalDateTime.now()),
                new District(136, "Bulung'ur tumani", regionMap.get(10), LocalDateTime.now()),
                new District(137, "Jomboy tumani", regionMap.get(10), LocalDateTime.now()),
                new District(138, "Ishtixon tumani", regionMap.get(10), LocalDateTime.now()),
                new District(139, "Kattaqo'rg'on tumani", regionMap.get(10), LocalDateTime.now()),
                new District(140, "Qo'shrabot tumani", regionMap.get(10), LocalDateTime.now()),
                new District(141, "Narpay tumani", regionMap.get(10), LocalDateTime.now()),
                new District(142, "Payariq tumani", regionMap.get(10), LocalDateTime.now()),
                new District(143, "Pastdarg'om tumani", regionMap.get(10), LocalDateTime.now()),
                new District(144, "Paxtachi tumani", regionMap.get(10), LocalDateTime.now()),
                new District(145, "Samarqand tumani", regionMap.get(10), LocalDateTime.now()),
                new District(146, "Nurobod tumani", regionMap.get(10), LocalDateTime.now()),
                new District(147, "Urgut tumani", regionMap.get(10), LocalDateTime.now()),
                new District(148, "Tayloq tumani", regionMap.get(10), LocalDateTime.now()),

                // Sirdaryo viloyati (11)
                new District(149, "Guliston shahri", regionMap.get(11), LocalDateTime.now()),
                new District(150, "Shirin shahri", regionMap.get(11), LocalDateTime.now()),
                new District(151, "Yangiyer shahri", regionMap.get(11), LocalDateTime.now()),
                new District(152, "Baxt shahri", regionMap.get(11), LocalDateTime.now()),
                new District(153, "Oqoltin tumani", regionMap.get(11), LocalDateTime.now()),
                new District(154, "Boyovut tumani", regionMap.get(11), LocalDateTime.now()),
                new District(155, "Sayxunobod tumani", regionMap.get(11), LocalDateTime.now()),
                new District(156, "Guliston tumani", regionMap.get(11), LocalDateTime.now()),
                new District(157, "Sardoba tumani", regionMap.get(11), LocalDateTime.now()),
                new District(158, "Mirzaobod tumani", regionMap.get(11), LocalDateTime.now()),
                new District(159, "Sirdaryo tumani", regionMap.get(11), LocalDateTime.now()),
                new District(160, "Xovos tumani", regionMap.get(11), LocalDateTime.now()),

                // Surxondaryo viloyati (12)
                new District(161, "Termiz shahri", regionMap.get(12), LocalDateTime.now()),
                new District(162, "Oltinsoy tumani", regionMap.get(12), LocalDateTime.now()),
                new District(163, "Angor tumani", regionMap.get(12), LocalDateTime.now()),
                new District(164, "Boysun tumani", regionMap.get(12), LocalDateTime.now()),
                new District(165, "Muzrabot tumani", regionMap.get(12), LocalDateTime.now()),
                new District(166, "Denov tumani", regionMap.get(12), LocalDateTime.now()),
                new District(167, "Jarqo'rg'on tumani", regionMap.get(12), LocalDateTime.now()),
                new District(168, "Qumqo'rg'on tumani", regionMap.get(12), LocalDateTime.now()),
                new District(169, "Qiziriq tumani", regionMap.get(12), LocalDateTime.now()),
                new District(170, "Sariosiyo tumani", regionMap.get(12), LocalDateTime.now()),
                new District(171, "Termiz tumani", regionMap.get(12), LocalDateTime.now()),
                new District(172, "Uzun tumani", regionMap.get(12), LocalDateTime.now()),
                new District(173, "Sherobod tumani", regionMap.get(12), LocalDateTime.now()),
                new District(174, "Sho'rchi tumani", regionMap.get(12), LocalDateTime.now()),
                new District(175, "Bandixon tumani", regionMap.get(12), LocalDateTime.now()),

                // Toshkent shahri (13)
                new District(176, "Uchtepa tumani", regionMap.get(13), LocalDateTime.now()),
                new District(177, "Bektemir tumani", regionMap.get(13), LocalDateTime.now()),
                new District(178, "Yunusobod tumani", regionMap.get(13), LocalDateTime.now()),
                new District(179, "Mirzo Ulug'bek tumani", regionMap.get(13), LocalDateTime.now()),
                new District(180, "Mirobod tumani", regionMap.get(13), LocalDateTime.now()),
                new District(181, "Shayxontohur tumani", regionMap.get(13), LocalDateTime.now()),
                new District(182, "Olmazor tumani", regionMap.get(13), LocalDateTime.now()),
                new District(183, "Sirg'ali tumani", regionMap.get(13), LocalDateTime.now()),
                new District(184, "Yakkasaroy tumani", regionMap.get(13), LocalDateTime.now()),
                new District(185, "Yashnobod tumani", regionMap.get(13), LocalDateTime.now()),
                new District(186, "Chilonzor tumani", regionMap.get(13), LocalDateTime.now()),
                new District(187, "Yangihayot tumani", regionMap.get(13), LocalDateTime.now()),
                new District(188, "Toshkent shahrining tumanlari", regionMap.get(13), LocalDateTime.now()),

                // Toshkent viloyati (14)
                new District(189, "Nurafshon shahri", regionMap.get(14), LocalDateTime.now()),
                new District(190, "Olmaliq shahri", regionMap.get(14), LocalDateTime.now()),
                new District(191, "Angren shahri", regionMap.get(14), LocalDateTime.now()),
                new District(192, "Bekobod shahri", regionMap.get(14), LocalDateTime.now()),
                new District(193, "Ohangaron shahri", regionMap.get(14), LocalDateTime.now()),
                new District(194, "Chirchiq shahri", regionMap.get(14), LocalDateTime.now()),
                new District(195, "Yangiyo'l shahri", regionMap.get(14), LocalDateTime.now()),
                new District(196, "Oqqo'rg'on tumani", regionMap.get(14), LocalDateTime.now()),
                new District(197, "Ohangaron tumani", regionMap.get(14), LocalDateTime.now()),
                new District(198, "Bekobod tumani", regionMap.get(14), LocalDateTime.now()),
                new District(199, "Bo'stonliq tumani", regionMap.get(14), LocalDateTime.now()),
                new District(200, "Bo'ka tumani", regionMap.get(14), LocalDateTime.now()),
                new District(201, "Zangiota tumani", regionMap.get(14), LocalDateTime.now()),
                new District(202, "Yuqorichirchiq tumani", regionMap.get(14), LocalDateTime.now()),
                new District(203, "Qibray tumani", regionMap.get(14), LocalDateTime.now()),
                new District(204, "Parkent tumani", regionMap.get(14), LocalDateTime.now()),
                new District(205, "Piskent tumani", regionMap.get(14), LocalDateTime.now()),
                new District(206, "O'rtachirchiq tumani", regionMap.get(14), LocalDateTime.now()),
                new District(207, "Chinoz tumani", regionMap.get(14), LocalDateTime.now()),
                new District(208, "Yangiyo'l tumani", regionMap.get(14), LocalDateTime.now()),
                new District(209, "Toshkent tumani", regionMap.get(14), LocalDateTime.now()),
                new District(210, "Quyichirchiq tumani", regionMap.get(14), LocalDateTime.now())
        );

        districtRepo.saveAll(districts);
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
