package com.example.backend.DTO;

import com.example.backend.Entity.EducationType;
import jakarta.persistence.ManyToOne;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class EducationFormDTO {
    private String name;
    private Integer educationTypeId;
    private Boolean isActive;
}
