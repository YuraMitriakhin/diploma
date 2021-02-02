package com.gmail.yuramitryahin.repository;

import com.gmail.yuramitryahin.entity.user.Lesson;
import com.gmail.yuramitryahin.entity.user.Links;
import com.gmail.yuramitryahin.entity.user.Result;
import com.gmail.yuramitryahin.entity.user.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ResultRepository extends JpaRepository<Result, Long> {
    List<Result> findByUserAndLesson(User user, Lesson lesson);

}
