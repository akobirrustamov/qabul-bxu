package com.example.backend.Entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.UUID;
import jakarta.validation.constraints.Size;
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Entity
@Table(name = "abuturient", uniqueConstraints = {
        @UniqueConstraint(columnNames = "phone"),
        @UniqueConstraint(columnNames = "passportPin")
})

public class Abuturient {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private UUID id;

    private String firstName;
    private String lastName;
    private String fatherName;

    @Column( unique = true)
    @Size(min = 14, max = 14, message = "Passport number must be exactly 14 characters long")
    private String passportNumber;

    @Size(min = 9, max = 9, message = "Passport PIN must be exactly 9 characters long")
    private String passportPin;

    @Column(nullable = false, unique = true)
    private String phone;

    private String additionalPhone;
    private Boolean language;

    @ManyToOne
    private AppealType appealType;

    @ManyToOne
    private EducationField educationField;
    private LocalDateTime createdAt;
    private LocalDateTime enrolledAt;
    @ManyToOne
    private User agent;
    @Column(unique = true)
    private Integer contractNumber;
    private Boolean isActive;
    private Integer status;
    private String ball;
    private Boolean getContract;
    @ManyToOne
    private District district;
    private Boolean isForeign;
    private String country;
    private String city;

    public Abuturient(String firstName, String lastName, String fatherName, String phone, String additionalPhone, Boolean language, AppealType appealType, EducationField educationField, LocalDateTime createdAt, User agent, Boolean isActive, Integer status, LocalDateTime enrolledAt, Integer contractNumber, String passportNumber, String passportPin) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.fatherName = fatherName;
        this.phone = phone;
        this.additionalPhone = additionalPhone;
        this.language = language;
        this.appealType = appealType;
        this.educationField = educationField;
        this.createdAt = createdAt;
        this.agent = agent;
        this.isActive = isActive;
        this.status = status;
        this.enrolledAt = enrolledAt;
        this.contractNumber = contractNumber;
        this.passportNumber = passportNumber;
        this.passportPin = passportPin;
    }

    public Abuturient(String phone, User agent, Integer status, LocalDateTime createdAt, Integer contractNumber) {
        this.phone = phone;
        this.agent = agent;
        this.status = status;
        this.createdAt = createdAt;
        this.contractNumber = contractNumber;

    }
}
