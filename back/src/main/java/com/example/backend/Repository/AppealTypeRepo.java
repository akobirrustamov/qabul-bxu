package com.example.backend.Repository;

import com.example.backend.Entity.AppealType;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AppealTypeRepo extends JpaRepository<AppealType, Integer> {
}
