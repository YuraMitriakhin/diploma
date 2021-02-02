package com.gmail.yuramitryahin.entity.user;

import lombok.*;

import javax.persistence.*;


@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name="files")
public class Files {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id", nullable = false)
    private long id;

    @Column(name = "file", nullable = false)
    private String file;

    @Column(name = "description")
    private String description;

    @ManyToOne(optional = false, cascade = CascadeType.PERSIST)
    @JoinColumn(name = "lesson_id")
    private Lesson lessonId;

    @Override
    public String toString() {
        return "Files{" +
                "id=" + id +
                ", file='" + file + '\'' +
                ", description='" + description + '\'' +
                '}';
    }
}
