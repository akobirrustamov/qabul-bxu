package com.example.backend.Repository;

import com.example.backend.Entity.AgentPath;
import com.example.backend.Entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.Optional;
import java.util.UUID;

public interface AgentPathRepo extends JpaRepository<AgentPath, Integer> {
    @Query(value = "select * from agent_path where agent_number=:randomPathNumber", nativeQuery = true)
    Optional<AgentPath> findByAgentNumber(Integer randomPathNumber);


    Optional<AgentPath> findByAgentId(UUID id);
}
