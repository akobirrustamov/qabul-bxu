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
@Table(name = "test_education_field")
public class TestEducationField {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY) // Specifies auto-increment behavior
    private Integer id;

    @ManyToOne
    private TestSubject test1;
    @ManyToOne
    private TestSubject test2;
    @ManyToOne
    private TestSubject test3;
    @ManyToOne
    private TestSubject test4;
    @ManyToOne
    private TestSubject test5;

    public TestEducationField( TestSubject test1, TestSubject test2, TestSubject test3, TestSubject test4, TestSubject test5) {
        this.test1 = test1;
        this.test2 = test2;
        this.test4 = test4;
        this.test3 = test3;
        this.test5 = test5;
    }
}
