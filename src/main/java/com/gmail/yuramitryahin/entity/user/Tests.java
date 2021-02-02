package com.gmail.yuramitryahin.entity.user;

import lombok.*;

import javax.persistence.*;
import java.util.List;
import java.util.Set;

@Builder
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table
public class Tests {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id", nullable = false)
    private long id;

    @OneToOne(mappedBy = "test")
    private Lesson lesson;

    @OneToMany(mappedBy = "test", fetch = FetchType.EAGER)
    private Set<Question> questions;
}
