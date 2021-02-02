package com.gmail.yuramitryahin.entity.user;

import lombok.*;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Builder
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table
public class Tegs {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id_teg", nullable = false)
    private long tegId;

    @Column(nullable = false)
    private String name;

    @Column(nullable = false)
    private long number = 1;

    @ManyToMany(mappedBy = "tegs")
    private List<Course> courses = new ArrayList<>();

    public void addCourse(Course course){
        courses = new ArrayList<>();
        courses.add(course);
    }

    @Override
    public String toString() {
        return "Tegs{" +
                "tegId=" + tegId +
                ", name='" + name + '\'' +
                ", number=" + number +
                '}';
    }
}
