package com.example.backend.Entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.UUID;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Entity
@Table(name = "qr_code")
public class QRCode {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private UUID id;
    @ManyToOne
    private User agent;
    @ManyToOne
    private Attachment attachment;
    private Integer serialNumber;
    @ManyToOne
    private Abuturient abuturient;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private Integer status;
    private Integer type;

    public QRCode(User agent, Attachment attachment, Integer serialNumber, LocalDateTime createdAt, Integer status, Integer type) {
        this.agent = agent;
        this.attachment = attachment;
        this.serialNumber = serialNumber;
        this.createdAt = createdAt;
        this.status = status;
        this.type = type;
    }


}
