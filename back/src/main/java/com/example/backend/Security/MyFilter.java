package com.example.backend.Security;

import com.example.backend.Repository.UserRepo;
import io.jsonwebtoken.ExpiredJwtException;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;
import java.util.UUID;

@Component
@CrossOrigin
@Configuration
@RequiredArgsConstructor
public class MyFilter extends OncePerRequestFilter {

    private final JwtService jwtService;
    private final UserRepo userRepo;

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws IOException, ServletException {
        String token = request.getHeader("Authorization");
        String requestPath = request.getRequestURI();

        System.out.println(request.getMethod());
        System.out.println(requestPath);
        filterChain.doFilter(request, response);

//        if(5>3){
//            filterChain.doFilter(request, response);
//            return;
//        }
        // Allow requests to "/api/v1/auth/login" without Authorization header
//        if (requestPath.equals("/api/v1/auth/login") || requestPath.equals("/api/v1/auth/access") || requestPath.equals("/api/v1/auth/refresh")  || requestPath.startsWith("/api/v1/file/getFile") || ( requestPath.startsWith("/api/v1/news") && request.getMethod().equals("GET") )  ) {
//            System.out.println("hi12222");
//            filterChain.doFilter(request, response);
//            return;
//        }
//
//        if (token != null) {
//            try {
//                String subject = jwtService.extractSubjectFromJwt(token);
//                UserDetails userDetails = userRepo.findById(UUID.fromString(subject)).orElseThrow();
//                UsernamePasswordAuthenticationToken authenticationToken =
//                        new UsernamePasswordAuthenticationToken(
//                                userDetails,
//                                null,
//                                userDetails.getAuthorities()
//                        );
//                SecurityContextHolder.getContext().setAuthentication(authenticationToken);
//            } catch (ExpiredJwtException e) {
//                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED); // 401 Unauthorized
//                response.getWriter().write("Token expired");
//                response.getWriter().flush();
//                return;
//            } catch (Exception e) {
//                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED); // 401 Unauthorized
//                response.getWriter().write("Invalid token");
//                response.getWriter().flush();
//                return;
//            }
//        } else {
//            // No Authorization header found, throw 401 Unauthorized error
//            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED); // 401 Unauthorized
//            response.getWriter().write("Authorization header missing");
//            response.getWriter().flush();
//            return;
//        }
    }
}
