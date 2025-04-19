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
@Table(name = "education_form")
public class EducationForm {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY) // Specifies auto-increment behavior
    private Integer id;
    private String name;
    @ManyToOne
    private EducationType educationType;
    private Boolean isActive;
    private LocalDateTime createdAt;

    public EducationForm(String name, EducationType educationType, Boolean isActive, LocalDateTime createdAt) {
        this.name = name;
        this.educationType = educationType;
        this.isActive = isActive;
        this.createdAt = createdAt;
    }
}
