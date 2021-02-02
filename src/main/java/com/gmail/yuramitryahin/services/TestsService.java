package com.gmail.yuramitryahin.services;

import com.gmail.yuramitryahin.dto.PassedTestDTO;
import com.gmail.yuramitryahin.dto.TestsDTO;
import com.gmail.yuramitryahin.entity.user.Lesson;
import com.gmail.yuramitryahin.entity.user.Question;
import com.gmail.yuramitryahin.entity.user.Tests;
import com.gmail.yuramitryahin.repository.TestsRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Slf4j
@Service
public class TestsService {

    @Autowired
    private TestsRepository testsRepository;

    @Autowired
    private QuestionService questionService;

    @Autowired
    private LessonService lessonService;

    @Transactional
    public void save(TestsDTO testsDTO){
        Tests test = Tests.builder().lesson(lessonService.findById(testsDTO.getLesson())).build();
          for(int i=0; i<testsDTO.getQuestions().length; i++){
              if(testsDTO.getQuestions()[i]!=""){
                List<String> answer = new ArrayList<>();

                for(int j=0; j<testsDTO.getNumbers().length; j++){
                    if(testsDTO.getNumbers()[j]==(i+1)){
                        answer.add(testsDTO.getAnswers()[j]);
                    }else if(testsDTO.getNumbers()[j]>(i+1)){
                        break;
                    }
                }
                questionService.save(test, testsDTO.getQuestions()[i], answer, testsDTO.getCorrect()[i], testsDTO.getTypes()[i]);
              }
          }
        testsRepository.save(test);
        Lesson lesson = lessonService.findById(testsDTO.getLesson());
        lesson.setTest(test);
        lessonService.save(lesson);
    }

    public Tests findByLessonId(Lesson lesson){
        return testsRepository.findByLesson(lesson);
    }

    public Tests findById(long id){
        return testsRepository.findById(id);
    }

    public List<Question> checkTest(PassedTestDTO passedTestDTO){
        Tests test = lessonService.findById(passedTestDTO.getLessonId()).getTest();
            List<Question> mistake = questionService.checkAnswer(passedTestDTO.getQuestionId(), passedTestDTO.getAnswersId());
           // System.out.println("Помилки;");
           // for(Question q: mistake){
           //     System.out.println(q.getQuestion());
           // }
        return mistake;
    }


}
