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
@Table(name = "my_test")
public class MyTest {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY) // Specifies auto-increment behavior
    private Integer id;
    @Column(length = 1000)
    private String question;
    @Column(length = 1000)
    private String answer;
    @Column(length = 1000)
    private String wrongAnswer1;
    @Column(length = 1000)
    private String wrongAnswer2;
    @Column(length = 1000)
    private String wrongAnswer3;
    @ManyToOne
    private TestSubject testSubject;


    public MyTest(String question, String answer, String wrongAnswer1, String wrongAnswer2, String wrongAnswer3, TestSubject testSubject) {
        this.question = question;
        this.answer = answer;
        this.wrongAnswer1 = wrongAnswer1;
        this.wrongAnswer2 = wrongAnswer2;
        this.wrongAnswer3 = wrongAnswer3;
        this.testSubject = testSubject;
    }


}
