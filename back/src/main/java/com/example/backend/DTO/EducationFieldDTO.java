package com.example.backend.DTO;

import com.example.backend.Entity.EducationForm;
import jakarta.persistence.ManyToOne;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class EducationFieldDTO {
    private String name;
    private Integer educationFormId;
    private Integer educationDuration;
    private String price;
    private Boolean isActive;
}
