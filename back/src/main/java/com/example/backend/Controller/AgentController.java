package com.example.backend.Controller;

import com.example.backend.DTO.AddUserDto;
import com.example.backend.Entity.Abuturient;
import com.example.backend.Entity.AgentPath;
import com.example.backend.Entity.Role;
import com.example.backend.Entity.User;
import com.example.backend.Enums.UserRoles;
import com.example.backend.Repository.AbuturientRepo;
import com.example.backend.Repository.AgentPathRepo;
import com.example.backend.Repository.RoleRepo;
import com.example.backend.Repository.UserRepo;
import com.example.backend.Services.AuthService.AuthService;
import lombok.RequiredArgsConstructor;
import org.aspectj.weaver.loadtime.Agent;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;

import javax.swing.*;
import java.time.LocalDate;
import java.util.*;
import java.util.concurrent.ThreadLocalRandom;

@RestController
@RequiredArgsConstructor
@CrossOrigin
@RequestMapping("/api/v1/agent")
public class AgentController {
    private final AuthService service;

    private final UserRepo userRepo;
    private final RoleRepo roleRepo;
    private final PasswordEncoder passwordEncoder;
    private final AgentPathRepo agentPathRepo;
    private final AbuturientRepo abuturientRepo;

    @GetMapping
    public HttpEntity<?> getAllAgents(){
        List<AgentPath> users = agentPathRepo.findAll();
        return ResponseEntity.ok(users);

    }

    @GetMapping("/me/{token}")
    public HttpEntity<?> getMeAgent(@PathVariable String token){
        User decode = service.decode(token);
        decode.setPassword("");
        return ResponseEntity.ok(decode);
    }

    @GetMapping("/appeals/{token}")
    public HttpEntity<?> decode(@PathVariable String token) {
        User decode = service.decode(token);
        List<Abuturient> abuturients = abuturientRepo.findByAgentId(decode.getId());
        return ResponseEntity.ok(abuturients);
    }

    @PostMapping
    public HttpEntity<?> addAgent(@RequestBody AddUserDto agent) {
        Role byName = roleRepo.findByName(UserRoles.ROLE_AGENT);
        List<Role> roles = new ArrayList<>();
        roles.add(byName);
        User user = new User(agent.getLogin(), passwordEncoder.encode(agent.getPassword()), roles, agent.getName());
        Optional<User> byPhone = userRepo.findByPhone(agent.getLogin());
        if (byPhone.isPresent()) {
            Optional<AgentPath> agentPath = agentPathRepo.findByAgentId(byPhone.get().getId());
            return ResponseEntity.ok(agentPath);
        }
        User savedUser = userRepo.save(user);
        AgentPath save = agentPathRepo.save(new AgentPath(agentNumber(), savedUser));

        return ResponseEntity.ok(save);
    }

    public Integer agentNumber(){
        Integer randomPathNumber = ThreadLocalRandom.current().nextInt(1000, 10000);
        Optional<AgentPath> byAgentNumber = agentPathRepo.findByAgentNumber(randomPathNumber);
        if (byAgentNumber.isPresent()) {
            agentNumber();
        }
        return randomPathNumber;
    }


    @PutMapping("/{id}")
        public HttpEntity<?> updateAgent(@RequestBody AddUserDto agent, @PathVariable UUID id){
            Optional<User> byId = userRepo.findById(id);
            if (byId.isPresent()){
                User user = byId.get();
                if (!Objects.equals(agent.getPassword(), "")){
                   user.setPassword(passwordEncoder.encode(agent.getPassword()));
                }
                user.setPassword(passwordEncoder.encode(agent.getPassword()));
                user.setPhone(agent.getLogin());
                user.setName(agent.getName());
                userRepo.save(user);
            }
            return ResponseEntity.ok(null);
        }



        @DeleteMapping("/{id}")
    public HttpEntity<?> deleteAgent(@PathVariable UUID id){
        Optional<User> byId = userRepo.findById(id);
        if (byId.isPresent()){
            User user = byId.get();
            userRepo.delete(user);
            return ResponseEntity.ok(null);
        }
        return ResponseEntity.ok(null);
    }




    @GetMapping("/statistic")
    public HttpEntity<?> getAllAgentsStatistic() {
        List<User> allAgents = userRepo.findAllByRoles_Name(UserRoles.ROLE_AGENT);
        List<Abuturient> allAbuturients = abuturientRepo.findAll();

        Map<String, Map<String, Object>> statisticsMap = new HashMap<>();

        // Initialize all agents with zero count
        for (User agent : allAgents) {
            Map<String, Object> entry = new HashMap<>();
            entry.put("name", agent.getName());
            entry.put("phone", agent.getPhone());
            entry.put("count", 0);
            statisticsMap.put(agent.getName(), entry);
        }

        for (Abuturient abuturient : allAbuturients) {
            String agentName;
            String agentPhone;

            if (abuturient.getAgent() != null) {
                agentName = abuturient.getAgent().getName();
                agentPhone = abuturient.getAgent().getPhone();
            } else {
                agentName = "Universitet havolasi";
                agentPhone = "university";
            }

            // If agent not in map yet (e.g. first abiturient), add them
            statisticsMap.putIfAbsent(agentName, new HashMap<>(Map.of(
                    "name", agentName,
                    "phone", agentPhone,
                    "count", 0
            )));

            Map<String, Object> entry = statisticsMap.get(agentName);
            entry.put("count", (int) entry.get("count") + 1);
        }

        return ResponseEntity.ok(statisticsMap.values()); // returns as a list
    }

    @GetMapping("/daily-statistic")
    public HttpEntity<?> getDailyAgentsStatistic() {
        List<Abuturient> allAbuturients = abuturientRepo.findAll();
        Map<LocalDate, Integer> dailyStatistics = new HashMap<>();
        for (Abuturient abuturient : allAbuturients) {
            if (abuturient.getCreatedAt() != null) {
                LocalDate createdDate = abuturient.getCreatedAt().toLocalDate();
                dailyStatistics.put(createdDate, dailyStatistics.getOrDefault(createdDate, 0) + 1);
            }
        }
        return ResponseEntity.ok(dailyStatistics);
    }

    @GetMapping("/daily-agent-statistic")
    public HttpEntity<?> getDailyAppealsPerAgent() {
        List<Abuturient> allAbuturients = abuturientRepo.findAll();

        Map<String, Map<String, Object>> agentMap = new HashMap<>();

        for (Abuturient abuturient : allAbuturients) {
            String agentName = abuturient.getAgent() != null ? abuturient.getAgent().getName() : "Universitet havolasi";
            String agentPhone = abuturient.getAgent() != null ? abuturient.getAgent().getPhone() : "university";

            String date = abuturient.getCreatedAt() != null
                    ? abuturient.getCreatedAt().toLocalDate().toString()
                    : "unknown";

            // Initialize if absent
            agentMap.putIfAbsent(agentName, new HashMap<>(Map.of(
                    "name", agentName,
                    "phone", agentPhone,
                    "daily", new HashMap<String, Integer>()
            )));

            Map<String, Object> entry = agentMap.get(agentName);
            Map<String, Integer> dailyMap = (Map<String, Integer>) entry.get("daily");
            dailyMap.put(date, dailyMap.getOrDefault(date, 0) + 1);
        }

        return ResponseEntity.ok(agentMap.values());
    }




}
