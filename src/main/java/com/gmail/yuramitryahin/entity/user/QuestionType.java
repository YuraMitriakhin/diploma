package com.gmail.yuramitryahin.entity.user;

import lombok.Getter;

@Getter
public enum QuestionType {
    LEC ("1"),
    GRAM ("2");

    private String value;

    QuestionType(String value) {
        this.value=value;
    }


}