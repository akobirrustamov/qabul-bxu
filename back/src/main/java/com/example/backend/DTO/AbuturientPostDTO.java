package com.example.backend.DTO;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class AbuturientPostDTO {
    private String firstName;
    private String lastName;
    private String fatherName;
    private String passportPin;
    private String passportNumber;
    private String phone;
    private Integer appealTypeId;
    private Integer educationFieldId;
}