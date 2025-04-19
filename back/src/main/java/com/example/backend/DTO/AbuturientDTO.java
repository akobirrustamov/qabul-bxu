package com.example.backend.DTO;

import com.example.backend.Entity.AppealType;
import com.example.backend.Entity.EducationField;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class AbuturientDTO {
    private String phone;
    private Integer agentId;
    private String firstName;
    private String lastName;
    private String fatherName;
    private String additionalPhone;
    private Boolean language;
    private Integer appealTypeId;
    private Integer educationFieldId;
    private Boolean isActive;
    private Integer status;
}
