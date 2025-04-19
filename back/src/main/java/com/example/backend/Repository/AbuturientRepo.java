package com.example.backend.Repository;

import com.example.backend.Entity.Abuturient;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.UUID;


import org.springframework.stereotype.Repository;

@Repository
public interface AbuturientRepo extends JpaRepository<Abuturient, UUID> {

    @Query(value = "SELECT * FROM abuturient WHERE phone = :phone", nativeQuery = true)
    Abuturient findByPhone(@Param("phone") String phone);

    @Query(value = "SELECT * FROM abuturient WHERE " +
            "(:fullName IS NULL OR :fullName = '' OR LOWER(CONCAT_WS(' ', last_name, first_name, father_name)) LIKE LOWER(CONCAT('%', :fullName, '%'))) AND " +
            "(:passportNumber IS NULL OR :passportNumber = '' OR passport_number LIKE CONCAT('%', :passportNumber, '%')) AND " +
            "(:passportPin IS NULL OR :passportPin = '' OR passport_pin LIKE CONCAT('%', :passportPin, '%')) AND " +
            "(:phone IS NULL OR :phone = '' OR phone LIKE CONCAT('%', :phone, '%')) AND " +
            "(COALESCE(:appealTypeId, 0) = 0 OR appeal_type_id = :appealTypeId) AND " +
            "(COALESCE(:educationFieldId, 0) = 0 OR education_field_id = :educationFieldId) AND " +
            "(COALESCE(:agentId, '00000000-0000-0000-0000-000000000000') = '00000000-0000-0000-0000-000000000000' OR agent_id = :agentId) AND " +
            "(COALESCE(:createdAt, NULL) IS NULL OR DATE(created_at) = :createdAt)",

            countQuery = "SELECT COUNT(*) FROM abuturient WHERE " +
                    "(:fullName IS NULL OR :fullName = '' OR LOWER(CONCAT_WS(' ', last_name, first_name, father_name)) LIKE LOWER(CONCAT('%', :fullName, '%'))) AND " +
                    "(:passportNumber IS NULL OR :passportNumber = '' OR passport_number LIKE CONCAT('%', :passportNumber, '%')) AND " +
                    "(:passportPin IS NULL OR :passportPin = '' OR passport_pin LIKE CONCAT('%', :passportPin, '%')) AND " +
                    "(:phone IS NULL OR :phone = '' OR phone LIKE CONCAT('%', :phone, '%')) AND " +
                    "(COALESCE(:appealTypeId, 0) = 0 OR appeal_type_id = :appealTypeId) AND " +
                    "(COALESCE(:educationFieldId, 0) = 0 OR education_field_id = :educationFieldId) AND " +
                    "(COALESCE(:agentId, '00000000-0000-0000-0000-000000000000') = '00000000-0000-0000-0000-000000000000' OR agent_id = :agentId) AND " +
                    "(COALESCE(:createdAt, NULL) IS NULL OR DATE(created_at) = :createdAt)",

            nativeQuery = true)
    Page<Abuturient> findByFilters(
            @Param("fullName") String fullName,
            @Param("passportNumber") String passportNumber,
            @Param("passportPin") String passportPin,
            @Param("phone") String phone,
            @Param("appealTypeId") Integer appealTypeId,
            @Param("educationFieldId") Integer educationFieldId,
            @Param("agentId") UUID agentId,
            @Param("createdAt") LocalDate createdAt,
            Pageable pageable);







    @Query(value = "SELECT * FROM abuturient WHERE agent_id = :agentId", nativeQuery = true)
    List<Abuturient> findByAgentId(@Param("agentId") UUID agentId);

    @Query(value = "SELECT * FROM abuturient WHERE contract_number = :contractNumber", nativeQuery = true)
    Optional<Abuturient> findByContractNumber(@Param("contractNumber") Integer contractNumber);



    @Query(value = "SELECT * FROM abuturient WHERE " +
            "(:firstName IS NULL OR :firstName = '' OR first_name LIKE CONCAT('%', :firstName, '%')) AND " +
            "(:lastName IS NULL OR :lastName = '' OR last_name LIKE CONCAT('%', :lastName, '%')) AND " +
            "(:fatherName IS NULL OR :fatherName = '' OR father_name LIKE CONCAT('%', :fatherName, '%')) AND " +
            "(:passportNumber IS NULL OR :passportNumber = '' OR passport_number LIKE CONCAT('%', :passportNumber, '%')) AND " +
            "(:passportPin IS NULL OR :passportPin = '' OR passport_pin LIKE CONCAT('%', :passportPin, '%')) AND " +
            "(:phone IS NULL OR :phone = '' OR phone LIKE CONCAT('%', :phone, '%')) AND " +
            "(COALESCE(:appealTypeId, 0) = 0 OR appeal_type_id = :appealTypeId) AND " +
            "(COALESCE(:educationFieldId, 0) = 0 OR education_field_id = :educationFieldId) AND " +
            "(COALESCE(:agentId, '00000000-0000-0000-0000-000000000000') = '00000000-0000-0000-0000-000000000000' OR agent_id = :agentId) AND " +
            "(COALESCE(:createdAt, NULL) IS NULL OR DATE(created_at) = :createdAt)",
            countQuery = "SELECT COUNT(*) FROM abuturient WHERE " +
                    "(:firstName IS NULL OR :firstName = '' OR first_name LIKE CONCAT('%', :firstName, '%')) AND " +
                    "(:lastName IS NULL OR :lastName = '' OR last_name LIKE CONCAT('%', :lastName, '%')) AND " +
                    "(:fatherName IS NULL OR :fatherName = '' OR father_name LIKE CONCAT('%', :fatherName, '%')) AND " +
                    "(:passportNumber IS NULL OR :passportNumber = '' OR passport_number LIKE CONCAT('%', :passportNumber, '%')) AND " +
                    "(:passportPin IS NULL OR :passportPin = '' OR passport_pin LIKE CONCAT('%', :passportPin, '%')) AND " +
                    "(:phone IS NULL OR :phone = '' OR phone LIKE CONCAT('%', :phone, '%')) AND " +
                    "(COALESCE(:appealTypeId, 0) = 0 OR appeal_type_id = :appealTypeId) AND " +
                    "(COALESCE(:educationFieldId, 0) = 0 OR education_field_id = :educationFieldId) AND " +
                    "(COALESCE(:agentId, '00000000-0000-0000-0000-000000000000') = '00000000-0000-0000-0000-000000000000' OR agent_id = :agentId) AND " +
                    "(COALESCE(:createdAt, NULL) IS NULL OR DATE(created_at) = :createdAt)",
            nativeQuery = true)
    List<Abuturient> findByFiltersOne(String firstName, String lastName, String fatherName, String passportNumber, String passportPin, String phone, Integer appealTypeId, Integer educationFieldId, UUID agentId, LocalDate createdAt);
}