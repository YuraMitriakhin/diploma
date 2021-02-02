package com.gmail.yuramitryahin.services;

import com.gmail.yuramitryahin.dto.LessonDTO;
import com.gmail.yuramitryahin.dto.PassedTestDTO;
import com.gmail.yuramitryahin.entity.user.*;
import com.gmail.yuramitryahin.repository.LessonRepository;
import com.gmail.yuramitryahin.repository.ResultRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@Slf4j
@Service
public class ResultService {

    private FileOutputStream os;
    private LocalDateTime localDateTime;
    private String fileName;
    private String path = "src/main/resources/videos/";
    private int lec;
    private int gram;

    @Autowired
    private ResultRepository resultRepository;
    @Autowired
    private LessonService lessonService;


    public void saveResult(PassedTestDTO passedTestDTO, User user, List<Question> mistake, boolean test){
        double time = (Long.parseLong(passedTestDTO.getTime()))/1000;
        double dtime = time/60;
        Result result = Result.builder()
                .lesson(lessonService.findById(passedTestDTO.getLessonId()))
                .time(dtime)
                .user(user)
                .testAvailable(test)
                .video(fileName)
                .build();

        if(mistake!=null){
            checkTypeMistake(mistake);
            result.setMistakes(mistake.size());
            result.setLexicalMistakes(lec);
            result.setGrammaticalMistakes(gram);
        }
        resultRepository.save(result);
    }

    private void checkTypeMistake(List<Question> mistake){
        lec = 0;
        gram = 0;
        for(Question q: mistake){
            if(q.getQuestionType() == QuestionType.LEC){
                lec++;
            }else if(q.getQuestionType() == QuestionType.GRAM){
                gram++;
            }
        }

    }

    public Result findByLessonAndUser(User user, Lesson lesson){
        List<Result> resultList = resultRepository.findByUserAndLesson(user, lesson);
        Result max = resultList.get(0);
        for (int i=1; i< resultList.size(); i++) {
            if(max.getResultId()<resultList.get(i).getResultId()){
                max = resultList.get(i);
            }
        }
        return max;
    }

    public void saveVideo(MultipartFile file, boolean end) throws IOException {
        if(end){
            if(file.getSize() !=0){
                os = new FileOutputStream(new File(path+fileName+".mp4"), true);
                os.write(file.getBytes(), 0, file.getBytes().length);
            }
            os.close();
            os = null;
            return;
        }

        if(os == null) {
            DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyyMMdd_HHmmss_");
            localDateTime = LocalDateTime.now();
            fileName = dtf.format(localDateTime)+(int)(Math.random()*1000);

            os = new FileOutputStream(path+fileName+".mp4");
            os.write(file.getBytes());

        }else{
            os = new FileOutputStream(new File(path+fileName+".mp4"), true);
            os.write(file.getBytes(), 0, file.getBytes().length);
        }
    }

    public void deleteVideo() {
        os = null;
        fileName = "";
    }

}
