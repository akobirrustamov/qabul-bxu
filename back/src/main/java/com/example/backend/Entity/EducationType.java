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
@Table(name = "education_type")
public class EducationType {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY) // Specifies auto-increment behavior
    private Integer id;
    private String name;
    private Boolean isActive;
    private LocalDateTime createdAt;

    public EducationType(String name, Boolean isActive, LocalDateTime createdAt) {
        this.name = name;
        this.isActive = isActive;
        this.createdAt = createdAt;
    }
}
