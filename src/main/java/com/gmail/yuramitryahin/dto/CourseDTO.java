package com.gmail.yuramitryahin.dto;

import com.gmail.yuramitryahin.entity.user.Difficulty;
import com.gmail.yuramitryahin.entity.user.Lesson;
import com.gmail.yuramitryahin.entity.user.Tegs;
import com.gmail.yuramitryahin.entity.user.Topics;
import lombok.*;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

@AllArgsConstructor
@NoArgsConstructor
@ToString
@Getter
@Setter
public class CourseDTO {

    private long courseId;

    private String name;

    private String description;

    private boolean type;

    private Difficulty difficulty;

    private long topicId;

    private List<String> tegs;
}
