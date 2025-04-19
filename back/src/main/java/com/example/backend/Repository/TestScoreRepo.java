package com.example.backend.Repository;

import com.example.backend.Entity.Abuturient;
import com.example.backend.Entity.TestScore;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.UUID;

public interface TestScoreRepo extends JpaRepository<TestScore,Integer> {
    @Query(value = "select * from test_score where abuturient_id=:byPhone",  nativeQuery = true)
    TestScore findByAbuturientId(UUID byPhone);
}
