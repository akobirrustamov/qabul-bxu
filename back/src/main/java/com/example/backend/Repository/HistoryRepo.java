package com.example.backend.Repository;

import com.example.backend.Entity.History;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.UUID;

public interface HistoryRepo extends JpaRepository<History, UUID> {
}
