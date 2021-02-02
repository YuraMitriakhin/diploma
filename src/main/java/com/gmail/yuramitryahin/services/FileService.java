package com.gmail.yuramitryahin.services;

import com.gmail.yuramitryahin.entity.user.Files;
import com.gmail.yuramitryahin.entity.user.Lesson;
import com.gmail.yuramitryahin.repository.FileRepository;
import lombok.extern.slf4j.Slf4j;
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
public class FileService {

    @Autowired
    private FileRepository fileRepository;

    public List<Files> getAllFiles(){
        return fileRepository.findAll();
    }

   public void saveFiles(MultipartFile[]files, String[] description, Lesson lesson) throws IOException {
        fileRepository.saveAll(convertToFiles(files, description,lesson));
   }

    private List<Files> convertToFiles(MultipartFile[]files, String[] description, Lesson lesson) throws IOException {
        List<Files> listFiles = new ArrayList<>();
        for (int i=0; i<files.length; i++) {
            if (files[i]!=null && files[i].getSize()!=0) {
                String name = getData()+"_"+files[i].getOriginalFilename();
                Path filepath = Paths.get("src/main/resources/photos", name);
                files[i].transferTo(filepath);
                Files f = Files.builder().file(name).lessonId(lesson).build();
                if(description==null || description.length==0){
                    f.setDescription("");
                }else{
                    f.setDescription(description[i]);
                }
                listFiles.add(f);
            }
        }
        return listFiles;
    }

    private String getData(){
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyyMMdd_HHmmss_"+(int)(Math.random()*100000));
        LocalDateTime now = LocalDateTime.now();
        return dtf.format(now);
    }

    public void deleteByLessonId(Lesson lesson){
        fileRepository.deleteByLessonId(lesson);
    }

}
