package com.example.backend.Entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.UUID;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Entity
@Table(name = "history")
public class History {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private UUID id;

    @ManyToOne
    private User user;
    @ManyToOne
    private Abuturient abuturient;

    private String firstName;
    private String lastName;
    private String fatherName;
    @Column( unique = true)
    @Size(min = 14, max = 14, message = "Passport number must be exactly 14 characters long")
    private String passportNumber;
    @Size(min = 9, max = 9, message = "Passport PIN must be exactly 9 characters long")
    private String passportPin;
    private String additionalPhone;
    @ManyToOne
    private AppealType appealType;
    @ManyToOne
    private EducationField educationField;
    private String newFirstName;
    private String newLastName;
    private String newFatherName;
    @Column( unique = true)
    @Size(min = 14, max = 14, message = "Passport number must be exactly 14 characters long")
    private String newPassportNumber;
    @Size(min = 9, max = 9, message = "Passport PIN must be exactly 9 characters long")
    private String newPassportPin;
    private String newAdditionalPhone;
    @ManyToOne
    private AppealType newAppealType;
    @ManyToOne
    private EducationField newEducationField;

    private LocalDateTime createAt;


    public History(User user, Abuturient abuturient, String firstName, String lastName, String passportNumber, String fatherName, String passportPin, String additionalPhone, AppealType appealType, EducationField educationField, String newFirstName, String newLastName, String newFatherName, String newPassportNumber, String newPassportPin, String newAdditionalPhone, AppealType newAppealType, EducationField newEducationField, LocalDateTime createAt) {
        this.user = user;
        this.abuturient = abuturient;
        this.firstName = firstName;
        this.lastName = lastName;
        this.passportNumber = passportNumber;
        this.fatherName = fatherName;
        this.passportPin = passportPin;
        this.additionalPhone = additionalPhone;
        this.appealType = appealType;
        this.educationField = educationField;
        this.newFirstName = newFirstName;
        this.newLastName = newLastName;
        this.newFatherName = newFatherName;
        this.newPassportNumber = newPassportNumber;
        this.newPassportPin = newPassportPin;
        this.newAdditionalPhone = newAdditionalPhone;
        this.newAppealType = newAppealType;
        this.newEducationField = newEducationField;
        this.createAt = createAt;
    }
}
