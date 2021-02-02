package com.gmail.yuramitryahin.services;

import com.gmail.yuramitryahin.entity.user.Answer;
import com.gmail.yuramitryahin.entity.user.Question;
import com.gmail.yuramitryahin.entity.user.QuestionType;
import com.gmail.yuramitryahin.entity.user.Tests;
import com.gmail.yuramitryahin.repository.QuestionRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Slf4j
@Service
public class QuestionService {

    @Autowired
    private QuestionRepository questionRepository;

    @Autowired
    private AnswerService answerService;

    @Transactional
    public void save(Tests test, String q, List<String> answers, long[] correct, String type) {
        Question question = Question.builder().test(test).question(q).questionType(QuestionType.valueOf(type)).build();
        for (int i = 0; i < answers.size(); i++) {
            boolean c = false;

            for (long l : correct) {
                if (l == (i + 1)) {
                    answerService.save(question, answers.get(i), true);
                    c = true;
                    break;
                }
            }
            if (!c) {
                answerService.save(question, answers.get(i), false);
            }
        }
        questionRepository.save(question);
    }

    public List<Question> findQuestionByTest(Tests test) {
        return questionRepository.findAllByTest(test);
    }

    public Question findById(long id) {
        return questionRepository.findByQuestionId(id);
    }

    public List<Question> checkAnswer(long[] questionId, long[] checkAnswersId) {
        List<Question> mistakeQuestion = new ArrayList<>();
        for (long id : questionId) {
            Question question = findById(id);
            boolean mistake = false;

            for (Answer answer : question.getAnswers()) {
                boolean m = true;

                if (answer.isCorrect()) {
                    for (long checkAnswer : checkAnswersId) {
                        if (answer.getAnswerId() == checkAnswer) {
                            m = false;
                        }
                    }

                }else {
                    m=false;
                    for (long checkAnswer : checkAnswersId) {
                        if (answer.getAnswerId() == checkAnswer) {
                            m = true;
                        }
                    }
                }
                if (m) {
                    mistake = true;
                    break;
                }
            }
            if(mistake){
                mistakeQuestion.add(question);
            }
        }
        return mistakeQuestion;
    }
}

