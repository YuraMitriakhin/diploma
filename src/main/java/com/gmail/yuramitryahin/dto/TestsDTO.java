package com.gmail.yuramitryahin.dto;

import java.util.Arrays;

public class TestsDTO {
    private long lesson;
    private String[] questions;
    private String[] answers;
    private long[] numbers;
    private long[][] correct;
    private String[] types;

    public TestsDTO() {
    }

    public TestsDTO(long lesson, String[] questions, String[] answers, long[] numbers, long[][] correct, String[] types) {
        this.lesson = lesson;
        this.questions = questions;
        this.answers = answers;
        this.numbers = numbers;
        this.correct = correct;
        this.types = types;
    }

    public long[][] getCorrect() {
        return correct;
    }

    public void setCorrect(long[][] correct) {
        this.correct = correct;
    }

    public long getLesson() {
        return lesson;
    }

    public void setLesson(long lesson) {
        this.lesson = lesson;
    }

    public String[] getQuestions() {
        return questions;
    }

    public void setQuestions(String[] questions) {
        this.questions = questions;
    }

    public String[] getAnswers() {
        return answers;
    }

    public void setAnswers(String[] answers) {
        this.answers = answers;
    }

    public long[] getNumbers() {
        return numbers;
    }

    public void setNumbers(long[] numbers) {
        this.numbers = numbers;
    }

    public String[] getTypes() {
        return types;
    }

    public void setTypes(String[] types) {
        this.types = types;
    }

    @Override
    public String toString() {
        return "TestsDTO{" +
                "lesson=" + lesson +
                ", questions=" + Arrays.toString(questions) +
                ", answers=" + Arrays.toString(answers) +
                ", numbers=" + Arrays.toString(numbers) +
                ", correct=" + Arrays.toString(correct) +
                '}';
    }
}
