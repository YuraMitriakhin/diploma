package com.gmail.yuramitryahin.entity.user;

import lombok.*;
import org.hibernate.internal.build.AllowSysOut;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Set;

@Builder
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@Entity
@Table(name = "corses")
public class Course {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id_course", nullable = false)
    private long courseId;

    @Column(nullable = false)
    private String name;

    @Column(nullable = false, columnDefinition="MEDIUMTEXT")
    private String description;

    @Column(nullable = false)
    private boolean type;

    @Column(nullable = false)
    @Enumerated(EnumType.STRING)
    private Difficulty difficulty;

    @OneToMany(mappedBy = "courseId", fetch = FetchType.EAGER)
    private Collection<Lesson> lessons;

    @ManyToOne(optional = false, cascade = CascadeType.ALL)
    @JoinColumn(name = "id_topic")
    private Topics topic;

    @ManyToMany(cascade = {
            CascadeType.PERSIST,
            CascadeType.MERGE
    })
    @JoinTable(name = "id_tegs",
            joinColumns = @JoinColumn(name = "course_id"),
            inverseJoinColumns = @JoinColumn(name = "tegs_id")
    )
    private List<Tegs> tegs = new ArrayList<>();

    @Override
    public String toString() {
        return "Course{" +
                "courseId=" + courseId +
                ", name='" + name + '\'' +
                ", description='" + description + '\'' +
                ", type=" + type +
                ", difficulty=" + difficulty +
                ", topic=" + topic +
                ", tegs=" + tegs +
                '}';
    }
}
