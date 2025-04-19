package com.example.backend.Controller;

import com.example.backend.DTO.AddUserDto;
import com.example.backend.Entity.Role;
import com.example.backend.Entity.User;
import com.example.backend.Enums.UserRoles;
import com.example.backend.Repository.RoleRepo;
import com.example.backend.Repository.UserRepo;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;

import java.util.*;

@RestController
@RequiredArgsConstructor
@CrossOrigin
@RequestMapping("/api/v1/operator")
public class OperatorController {

    private final UserRepo userRepo;
    private final RoleRepo roleRepo;
    private final PasswordEncoder passwordEncoder;

    @GetMapping
    public HttpEntity<?> getAllOperators(){
        Role byName = roleRepo.findByName(UserRoles.ROLE_OPERATOR);
        List<User> users = userRepo.findAllByRole(byName);
        return ResponseEntity.ok(users);
    }

    @PostMapping
    public HttpEntity<?> addAgent(@RequestBody AddUserDto agent){
        Role byName = roleRepo.findByName(UserRoles.ROLE_OPERATOR);
        List<Role> roles = new ArrayList<>();
        roles.add(byName);
        User user = new User(agent.getLogin(), passwordEncoder.encode(agent.getPassword()),roles , agent.getName());
        userRepo.save(user);
        return ResponseEntity.ok(user);
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

}
