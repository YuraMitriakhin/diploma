package com.gmail.yuramitryahin.dto;

import com.gmail.yuramitryahin.entity.user.Difficulty;

import java.util.Arrays;

public class CourseSearchDTO {
    private long topics[];
    private boolean type;
    private Difficulty difficulty[];
    private long tegs[];

    public CourseSearchDTO(long[] topics, boolean type, Difficulty[] difficulty, long[] tegs) {
        this.topics = topics;
        this.type = type;
        this.difficulty = difficulty;
        this.tegs = tegs;
    }

    public CourseSearchDTO() {
    }

    public long[] getTopics() {
        return topics;
    }

    public void setTopics(long[] topics) {
        this.topics = topics;
    }

    public boolean isType() {
        return type;
    }

    public void setType(boolean type) {
        this.type = type;
    }

    public Difficulty[] getDifficulty() {
        return difficulty;
    }

    public void setDifficulty(Difficulty[] difficulty) {
        this.difficulty = difficulty;
    }

    public long[] getTegs() {
        return tegs;
    }

    public void setTegs(long[] tegs) {
        this.tegs = tegs;
    }

    @Override
    public String toString() {
        return "CourseSearchDTO{" +
                "topics=" + Arrays.toString(topics) +
                ", type=" + type +
                ", difficulty=" + Arrays.toString(difficulty) +
                ", tegs=" + Arrays.toString(tegs) +
                '}';
    }
}
