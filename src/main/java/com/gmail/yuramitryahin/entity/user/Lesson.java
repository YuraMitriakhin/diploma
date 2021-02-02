package com.gmail.yuramitryahin.entity.user;

import lombok.*;

import javax.persistence.*;
import java.util.List;
import java.util.Set;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
@Builder
@Entity
@Table(name="lessons")
public class Lesson {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id", nullable = false)
    private long id;

    @Column(nullable = false)
    private int number;

    @Column(nullable = false)
    private String name;

    @Column(nullable = false)
    private String description;

    @Column(nullable = false, columnDefinition="MEDIUMTEXT")
    private String text;

    @OneToMany(mappedBy = "lessonID", fetch = FetchType.EAGER)
    private Set<Links> links;

    @OneToMany(mappedBy = "lessonId", fetch = FetchType.EAGER)
    private List<Files> files;

    @ManyToOne(optional = false, cascade = CascadeType.PERSIST)
    @JoinColumn(name = "id_course")
    private Course courseId;

    @OneToOne(cascade = CascadeType.PERSIST)
    @JoinColumn(name = "id_test", referencedColumnName = "id")
    private Tests test;

    @OneToMany(mappedBy = "lesson", fetch = FetchType.EAGER)
    private Set<Result> results;


}