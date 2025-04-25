package com.example.backend.Controller;

import com.example.backend.Entity.District;
import com.example.backend.Repository.DistrictRepo;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@CrossOrigin
@RequestMapping("/api/v1/district")
public class DistrictController {

    private final DistrictRepo districtRepo;


    @GetMapping
    public HttpEntity<?> getAllDistrict(){
        return new ResponseEntity<>(districtRepo.findAll(), HttpStatus.OK);
    }

    @GetMapping("/{regionId}")
    public HttpEntity<?> getAllDistrictRegionId(@PathVariable Integer regionId){
        List<District> districts = districtRepo.findByRegionId(regionId);
        return new ResponseEntity<>(districts, HttpStatus.OK);

    }



}
