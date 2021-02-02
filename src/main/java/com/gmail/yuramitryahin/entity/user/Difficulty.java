package com.gmail.yuramitryahin.entity.user;

import lombok.Getter;

@Getter
public enum Difficulty {
    EASY ("1"),
    MEDIUM ("2"),
    HARD ("3");

    private String value;

    Difficulty(String value) {
        this.value=value;
    }


}