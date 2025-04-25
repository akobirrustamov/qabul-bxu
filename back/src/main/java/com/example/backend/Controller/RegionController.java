package com.example.backend.Controller;

import com.example.backend.Entity.Region;
import com.example.backend.Repository.RegionRepo;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequiredArgsConstructor
@CrossOrigin
@RequestMapping("/api/v1/region")
public class RegionController {

    private final RegionRepo regionRepo;
    @GetMapping
    public HttpEntity<?> getAllRegions(){
        List<Region> all = regionRepo.findAll();
        System.out.println(all);
        return new ResponseEntity<>(all, HttpStatus.OK);
    }

}
