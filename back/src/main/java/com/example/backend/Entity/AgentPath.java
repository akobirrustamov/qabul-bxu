package com.example.backend.Entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.UUID;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Entity
@Table(name = "agent_path")
public class AgentPath {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY) // Specifies auto-increment behavior
    private Integer id;
    private Integer agentNumber;
    @ManyToOne
    private User agent;

    public AgentPath(Integer agentNumber, User agent) {
        this.agentNumber = agentNumber;
        this.agent = agent;
    }
}
