package com.example.backend.Entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Entity
@Table(name = "certificate")
public class Certificate {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY) // Specifies auto-increment behavior
    private Integer id;
    @ManyToOne
    private Attachment attachment;


    @ManyToOne
    private Abuturient abuturient;

    public Certificate(Attachment attachment, Abuturient abuturient) {
        this.attachment = attachment;
        this.abuturient = abuturient;
    }
}
