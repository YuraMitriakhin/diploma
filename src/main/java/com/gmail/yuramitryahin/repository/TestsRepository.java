package com.gmail.yuramitryahin.repository;

import com.gmail.yuramitryahin.entity.user.Lesson;
import com.gmail.yuramitryahin.entity.user.Tests;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TestsRepository extends JpaRepository<Tests, Long> {
    Tests findByLesson(Lesson lesson);
    Tests findById(long id);
}
