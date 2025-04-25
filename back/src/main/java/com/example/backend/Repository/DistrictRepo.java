package com.example.backend.Repository;

import com.example.backend.Entity.District;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface DistrictRepo extends JpaRepository<District, Integer> {

    @Query(value = "select * from districts where region_id=:regionId", nativeQuery = true)
    List<District> findByRegionId(Integer regionId);
}
