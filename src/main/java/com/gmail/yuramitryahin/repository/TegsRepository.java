package com.gmail.yuramitryahin.repository;

import com.gmail.yuramitryahin.entity.user.Tegs;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TegsRepository extends JpaRepository<Tegs, Long> {
    Tegs findAllByName(String name);
}
