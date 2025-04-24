package com.example.backend.Repository;

import com.example.backend.Entity.Region;
import org.springframework.data.jpa.repository.JpaRepository;

public interface RegionRepo extends JpaRepository<Region,Integer> {
}
