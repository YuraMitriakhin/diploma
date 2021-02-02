package com.gmail.yuramitryahin.services;

import com.gmail.yuramitryahin.entity.user.Course;
import com.gmail.yuramitryahin.entity.user.Files;
import com.gmail.yuramitryahin.entity.user.Lesson;
import com.gmail.yuramitryahin.entity.user.Tegs;
import com.gmail.yuramitryahin.repository.FileRepository;
import com.gmail.yuramitryahin.repository.TegsRepository;
import lombok.extern.slf4j.Slf4j;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

@Slf4j
@Service
public class TegsService {

    @Autowired
    private TegsRepository tegsRepository;

    public List<Tegs> getAllTegs(){
        return tegsRepository.findAll();
    }

    public List<Tegs> saveTeg (List<String> tegsName, Course course){
        List<Tegs> list = new ArrayList<>();

        for (String name: tegsName) {
            Tegs teg = tegsRepository.findAllByName(name.toLowerCase());
            if(teg==null){
                Tegs t = Tegs.builder().name(name.toLowerCase()).number(1).build();
                t.addCourse(course);
                tegsRepository.save(t);
                list.add(t);
            }else{
                teg.setNumber(teg.getNumber()+1);
                teg.getCourses().add(course);
                tegsRepository.save(teg);
                list.add(teg);
            }
        }
        return list;
    }

    public String convertToJson(List<Tegs> list) throws JSONException {
        JSONArray jsonArray=new JSONArray();

        for(Tegs t: list){
            JSONObject json = new JSONObject();
            json.put("tegId",t.getTegId());
            json.put("name",t.getName());
            json.put("number",t.getNumber());

            jsonArray.put(json);
        }
        return jsonArray.toString();
    }

    public void delteTegs(Course course){
        for(Tegs t: course.getTegs()){
            t.setNumber(t.getNumber()-1);
            if(t.getNumber()==0){
                tegsRepository.delete(t);
            }else{
                tegsRepository.save(t);
            }
        }
    }
}
