package com.example.backend.Controller;

import com.example.backend.DTO.UserDTO;
import com.example.backend.Entity.User;
import com.example.backend.Repository.UserRepo;
import com.example.backend.Security.JwtService;
import com.example.backend.Services.AuthService.AuthService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpEntity;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@CrossOrigin
@RequestMapping("/api/v1/auth")
public class AuthController {
    private final AuthService service;
    private final JwtService jwtService;
    private final UserRepo userRepo;
    private final PasswordEncoder passwordEncoder;
    @PostMapping(value = "/login", consumes = "application/json")
    public HttpEntity<?> login(@RequestBody UserDTO dto) {
        return service.login(dto);
    }

    @PostMapping("/refresh")
    public HttpEntity<?> refreshUser(@RequestParam String refreshToken) {
        return service.refreshToken(refreshToken);
    }

    @GetMapping("/decode")
    public HttpEntity<?> decode(@RequestHeader("token") String token) {

        User decode = service.decode(token);

        return ResponseEntity.ok(service.decode(token));
    }

    @GetMapping("/me/{token}")
    public HttpEntity<?> getMe(@PathVariable String token){
        User decode = service.decode(token);
        decode.setPassword("");
        return ResponseEntity.ok(decode);
    }

    @PostMapping("/password/{token}")
    public HttpEntity<?> changePassword(@RequestBody UserDTO dto, @PathVariable String token) {
        User decode = service.decode(token);
        decode.setPassword(passwordEncoder.encode(dto.getPassword()));
        userRepo.save(decode);
        return ResponseEntity.ok(decode);
    }



}
