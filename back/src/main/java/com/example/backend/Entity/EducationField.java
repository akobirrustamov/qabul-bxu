package com.example.backend.Entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Entity
@Table(name = "education_field")
public class EducationField {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY) // Specifies auto-increment behavior
    private Integer id;
    private String name;
    @ManyToOne
    private EducationForm educationForm;
    private Integer educationDuration;
    private String price;
    private Boolean isActive;
    private LocalDateTime createdAt;
    private Boolean ijodiy;
    @ManyToOne
    private TestEducationField testEducationField;

    public EducationField(String name, EducationForm educationForm, Integer educationDuration, String price, Boolean isActive, LocalDateTime createdAt, Boolean ijodiy) {
        this.name = name;
        this.educationForm = educationForm;
        this.educationDuration = educationDuration;
        this.price = price;
        this.isActive = isActive;
        this.createdAt = createdAt;
        this.ijodiy = ijodiy;
    }
    public EducationField(String name, EducationForm educationForm, Integer educationDuration, String price, Boolean isActive, LocalDateTime createdAt, TestEducationField testEducationField) {
        this.name = name;
        this.educationForm = educationForm;
        this.educationDuration = educationDuration;
        this.price = price;
        this.isActive = isActive;
        this.createdAt = createdAt;
        this.testEducationField = testEducationField;
    }


}
