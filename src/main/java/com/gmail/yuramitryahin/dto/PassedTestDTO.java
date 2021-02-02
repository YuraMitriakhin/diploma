package com.gmail.yuramitryahin.dto;

import java.util.Arrays;

public class PassedTestDTO {
    private String time;
    private long lessonId;
    private long[] answersId;
    private long[] questionId;

    public PassedTestDTO() {
    }

    public PassedTestDTO(String time, long lessonId, long[] answersId, long[] questionId) {
        this.time = time;
        this.lessonId = lessonId;
        this.answersId = answersId;
        this.questionId = questionId;
    }

    public long getLessonId() {
        return lessonId;
    }

    public void setLessonId(long lessonId) {
        this.lessonId = lessonId;
    }

    public long[] getAnswersId() {
        return answersId;
    }

    public void setAnswersId(long[] answersId) {
        this.answersId = answersId;
    }

    public long[] getQuestionId() {
        return questionId;
    }

    public void setQuestionId(long[] questionId) {
        this.questionId = questionId;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    @Override
    public String toString() {
        return "PassedTestDTO{" +
                "lessonId=" + lessonId +
                ", answersId=" + Arrays.toString(answersId) +
                ", questionId=" + Arrays.toString(questionId) +
                '}';
    }
}
