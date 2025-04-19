package com.example.backend.Repository;

import com.example.backend.Entity.QRCode;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.UUID;

public interface QRCodeRepo extends JpaRepository<QRCode, UUID> {

        // Native SQL query to check if a serial number exists
        @Query(value = "SELECT CASE WHEN COUNT(*) > 0 THEN true ELSE false END FROM qr_code WHERE serial_number = :serialNumber", nativeQuery = true)
        boolean existsBySerialNumber(@Param("serialNumber") Integer serialNumber);


        @Query(value = "select * from qr_code where agent_id=:userId", nativeQuery = true)
        List<QRCode> findByAgentId(UUID userId);
}
