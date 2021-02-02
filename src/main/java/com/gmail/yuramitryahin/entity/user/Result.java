package com.gmail.yuramitryahin.entity.user;

import lombok.*;

import javax.persistence.*;

@Builder
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Entity
@Table(name = "results")
public class Result {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id_result")
    private long resultId;

    @ManyToOne(optional = false, cascade = CascadeType.ALL)
    @JoinColumn(name = "id_user")
    private User user;

    @ManyToOne(optional = false, cascade = CascadeType.PERSIST)
    @JoinColumn(name = "id_lesson")
    private Lesson lesson;

    @Column
    private String video;

    @Column
    private boolean testAvailable;

    @Column
    private double time;

    @Column
    private int mistakes;

    @Column
    private int lexicalMistakes;

    @Column
    private int grammaticalMistakes;
}
