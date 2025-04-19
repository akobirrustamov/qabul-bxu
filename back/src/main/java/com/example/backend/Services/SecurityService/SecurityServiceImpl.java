package com.example.backend.Services.SecurityService;

import com.example.backend.Entity.User;
import com.example.backend.Services.AuthService.AuthService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpEntity;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class SecurityServiceImpl implements SecurityService {
    private final AuthService authService;
    @Override
    public HttpEntity<?> checkSecurity(String authorization){
        User decode = authService.decode(authorization);
        decode.setPassword("");
        return ResponseEntity.ok(decode);
    }
}
