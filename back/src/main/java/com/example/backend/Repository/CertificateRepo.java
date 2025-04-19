package com.example.backend.Repository;

import com.example.backend.Entity.Certificate;
import org.springframework.data.jpa.repository.JpaRepository;



public interface CertificateRepo extends JpaRepository<Certificate,Integer> {
}
