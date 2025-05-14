package com.example.backend.DTO;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class ForeignAbuturientDTO {
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
    private String country;
    private String city;
}
