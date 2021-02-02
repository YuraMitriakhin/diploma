package com.gmail.yuramitryahin.entity.user;

import lombok.*;

import javax.persistence.*;

@Builder
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Entity
@Table
public class Links {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id_link", nullable = false)
    private long linkId;

    @Column(name = "link", nullable = false)
    private String link;

    @ManyToOne(optional = false, cascade = CascadeType.PERSIST)
    @JoinColumn(name = "id_lesson")
    private Lesson lessonID;
}
