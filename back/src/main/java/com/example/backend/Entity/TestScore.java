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
@Table(name = "test_score")
public class TestScore {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY) // Specifies auto-increment behavior
    private Integer id;

    @OneToOne
    private Abuturient abuturient;
    private String score;
    private LocalDateTime time;
    private String rightScore;
    private Integer status;

    public TestScore(Abuturient user, String score, String rightScore, LocalDateTime time, Integer status) {
        this.abuturient = user;
        this.score = score;
        this.rightScore = rightScore;
        this.time = time;
        this.status = status;
    }
}
