package com.gmail.yuramitryahin.repository;

import com.gmail.yuramitryahin.entity.user.Answer;
import com.gmail.yuramitryahin.entity.user.Question;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface AnswerRepository extends JpaRepository<Answer, Long> {
}
