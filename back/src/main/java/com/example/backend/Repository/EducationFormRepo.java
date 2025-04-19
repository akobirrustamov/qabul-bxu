package com.example.backend.Repository;

import com.example.backend.Entity.EducationForm;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;
import java.util.Optional;

public interface EducationFormRepo extends JpaRepository<EducationForm,Integer> {

    @Query(value = "SELECT * FROM education_form where education_type_id=:id", nativeQuery = true)
    List<EducationForm> findByEducationTypeId(Integer id);
}
