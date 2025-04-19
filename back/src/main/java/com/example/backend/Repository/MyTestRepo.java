package com.example.backend.Repository;

import com.example.backend.Entity.MyTest;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface MyTestRepo extends JpaRepository<MyTest, Integer> {

    @Query(value = "SELECT * FROM my_test WHERE test_subject_id = :testSubject ORDER BY RANDOM() LIMIT :limit", nativeQuery = true)
    List<MyTest> findRandomByTestSubject(Integer testSubject, Integer limit);
}
