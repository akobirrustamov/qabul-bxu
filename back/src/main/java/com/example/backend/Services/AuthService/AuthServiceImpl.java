package com.example.backend.Services.AuthService;

import com.example.backend.DTO.UserDTO;
import com.example.backend.Entity.User;
import com.example.backend.Repository.UserRepo;
import com.example.backend.Security.JwtService;
import com.example.backend.exceptions.InvalidCredentialsException;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpEntity;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;
import java.util.Optional;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class AuthServiceImpl implements AuthService {
    private final UserRepo userRepo;
    private final JwtService jwtService;
    private final UserDetailsService userDetailsService;
    private final AuthenticationManager authenticationManager;

    @Override
    public HttpEntity<Map<String, Object>> login(UserDTO userDTO) {
        Optional<User> userOpt = userRepo.findByPhone(userDTO.getPhone());
        if (userOpt.isEmpty()) throw new InvalidCredentialsException();

        try {
            authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(userDTO.getPhone(), userDTO.getPassword()));
        } catch (BadCredentialsException e) {
            throw new InvalidCredentialsException();
        }

        User user = userOpt.get();
        Map<String, Object> response = new HashMap<>();
        response.put("access_token", jwtService.generateJwtToken(user));

        if (userDTO.isRememberMe()) {
            response.put("refresh_token", jwtService.generateJwtRefreshToken(user));
        }

        response.put("roles", user.getRoles());
        return ResponseEntity.ok(response);
    }

    @Override
    public HttpEntity<?> refreshToken(String refreshToken) {
        String userId = jwtService.extractSubjectFromJwt(refreshToken);
        User user = userRepo.findById(UUID.fromString(userId)).orElseThrow(() -> new RuntimeException("User not found"));

        String newAccessToken = jwtService.generateJwtToken(user);
        return ResponseEntity.ok(Map.of("access_token", newAccessToken));
    }

    @Override
    public User decode(String token) {
        if (!jwtService.validateToken(token)) {
            throw new RuntimeException("Token is expired or invalid");
        }

        String userId = jwtService.extractSubjectFromJwt(token);
        return userRepo.findById(UUID.fromString(userId)).orElseThrow(() -> new RuntimeException("User not found"));
    }
}
