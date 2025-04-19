package com.example.backend.Services.AuthService;

import com.example.backend.DTO.UserDTO;
import com.example.backend.Entity.User;
import org.springframework.http.HttpEntity;

public interface AuthService {
    HttpEntity<?> login(UserDTO dto);
    HttpEntity<?> refreshToken(String refreshToken);
    User decode(String token);
}
