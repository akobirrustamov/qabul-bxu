package com.example.backend.Services.SecurityService;

import org.springframework.http.HttpEntity;

public interface SecurityService {
    HttpEntity<?> checkSecurity(String authorization);
}
