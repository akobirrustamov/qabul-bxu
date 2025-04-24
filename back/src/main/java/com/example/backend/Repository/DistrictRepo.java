package com.example.backend.Repository;

import com.example.backend.Entity.District;
import org.springframework.data.jpa.repository.JpaRepository;

public interface DistrictRepo extends JpaRepository<District, Integer> {
}
