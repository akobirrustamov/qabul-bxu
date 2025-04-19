package com.example.backend.DTO;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.UUID;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class TestSubjectDTO {
    private String name;
    private String description;
    private Integer status;
    private LocalDateTime createdAt;
    private UUID fileId;

}
