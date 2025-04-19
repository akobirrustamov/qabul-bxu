package com.example.backend.Repository;


import com.example.backend.Entity.Role;
import com.example.backend.Enums.UserRoles;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface RoleRepo extends JpaRepository<Role, Integer> {
    List<Role> findAllByName(String name);
    Role findByName(UserRoles name);
}
