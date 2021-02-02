package com.gmail.yuramitryahin.services;

import com.gmail.yuramitryahin.entity.user.Files;
import com.gmail.yuramitryahin.entity.user.Lesson;
import com.gmail.yuramitryahin.entity.user.Links;
import com.gmail.yuramitryahin.repository.FileRepository;
import com.gmail.yuramitryahin.repository.LinksRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashSet;
import java.util.Set;


@Slf4j
@Service
public class LinksService {

    @Autowired
    private LinksRepository linksRepository;

    public void saveLinks(String[]links, Lesson lesson){
        linksRepository.saveAll(convertStringToLink(links,lesson));
    }

    public Set<Links> convertStringToLink(String[]links, Lesson lesson){
        Set<Links>setLinks=new HashSet<>();
        if(links==null)
            return setLinks;

        for (String s: links) {
            setLinks.add(Links.builder().link(s).lessonID(lesson).build());
        }
        return setLinks;
    }

    public void deleteByLessonId(Lesson lesson){
        linksRepository.deleteByLessonID(lesson);
    }
}
