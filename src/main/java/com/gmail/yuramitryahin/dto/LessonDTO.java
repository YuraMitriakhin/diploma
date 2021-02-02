package com.gmail.yuramitryahin.dto;

import java.io.File;
import java.util.Arrays;
import java.util.Set;

public class LessonDTO {

    private long lessonId;
    private String name;
    private String description;
    private String text;
    private long courseId;
    private int number;
    private String[]links;
    private String[] descriptionToFiles;

    public LessonDTO() {
    }

    public LessonDTO(long lessonId, String name, String description, String text, long courseId, int number, String[] links, String[] descriptionToFiles) {
        this.lessonId = lessonId;
        this.name = name;
        this.description = description;
        this.text = text;
        this.courseId = courseId;
        this.number = number;
        this.links = links;
        this.descriptionToFiles = descriptionToFiles;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public long getCourseId() {
        return courseId;
    }

    public void setCourseId(long cruiseId) {
        this.courseId = cruiseId;
    }

    public int getNumber() {
        return number;
    }

    public void setNumber(int number) {
        this.number = number;
    }

    public String[] getLinks() {
        return links;
    }

    public void setLinks(String[] links) {
        this.links = links;
    }

    public String[] getDescriptionToFiles() {
        return descriptionToFiles;
    }

    public void setDescriptionToFiles(String[] descriptionToFiles) {
        this.descriptionToFiles = descriptionToFiles;
    }

    public long getLessonId() {
        return lessonId;
    }

    public void setLessonId(long lessonId) {
        this.lessonId = lessonId;
    }

    @Override
    public String toString() {
        return "LessonDTO{" +
                "name='" + name + '\'' +
                ", description='" + description + '\'' +
                ", text='" + text + '\'' +
                ", cruiseId='" + courseId + '\'' +
                ", number='" + number + '\'' +
                ", links=" + Arrays.toString(links) +
                ", descriptionToFiles=" + Arrays.toString(descriptionToFiles) +
                '}';
    }
}
