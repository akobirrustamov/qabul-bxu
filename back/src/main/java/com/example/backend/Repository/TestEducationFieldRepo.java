package com.example.backend.Repository;

import com.example.backend.Entity.TestEducationField;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface TestEducationFieldRepo extends JpaRepository<TestEducationField,Integer> {
    @Query(value = "select * from test_education_field where education_field_id=:educationFieldId", nativeQuery = true)
    TestEducationField findByEducationFieldId(Integer educationFieldId);
}
