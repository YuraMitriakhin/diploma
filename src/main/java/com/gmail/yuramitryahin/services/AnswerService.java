package com.gmail.yuramitryahin.services;

import com.gmail.yuramitryahin.entity.user.Answer;
import com.gmail.yuramitryahin.entity.user.Question;
import com.gmail.yuramitryahin.repository.AnswerRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Slf4j
@Service
public class AnswerService {

    @Autowired
    private AnswerRepository answerRepository;

    public void save(Question question, String a, boolean correct){
        if (a != "") {
            Answer answer = Answer.builder().question(question).answer(a).correct(correct).build();
            answerRepository.save(answer);
        }
    }

}
