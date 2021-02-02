package com.gmail.yuramitryahin.entity.user;

import lombok.*;

import javax.persistence.*;
import java.util.Collection;

@Builder
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "topics")
public class Topics {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id_topic", nullable = false)
    private long topicId;

    @Column(nullable = false)
    private String name;

    @OneToMany(mappedBy = "topic", fetch = FetchType.EAGER)
    private Collection<Course> course;

}
