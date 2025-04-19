package com.example.backend.Repository;

import com.example.backend.Entity.TestSubject;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface TestSubjectRepo extends JpaRepository<TestSubject, Integer> {

    @Query(value = "SELECT * FROM test_subject WHERE name = :name AND status = :status LIMIT 1", nativeQuery = true)
    Optional<TestSubject> findByNameAndStatus( String name, String status);

    @Query(value = "select  * from test_subject where status=:status", nativeQuery = true)
    List<TestSubject> findByStatus(String status);

}
