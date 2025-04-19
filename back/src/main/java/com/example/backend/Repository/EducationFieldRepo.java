package com.example.backend.Repository;

import com.example.backend.Entity.EducationField;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface EducationFieldRepo extends JpaRepository<EducationField, Integer> {

    @Query(value = "SELECT * FROM education_field WHERE education_form_id = :educationFormId ORDER BY name ASC", nativeQuery = true)
    List<EducationField> findByEducationFormId(Integer educationFormId);

    @Query(value = "SELECT * FROM education_field ORDER BY name ASC", nativeQuery = true)
    List<EducationField> findAllByOrderByName();
}
