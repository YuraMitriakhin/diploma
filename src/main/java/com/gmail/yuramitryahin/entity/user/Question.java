package com.gmail.yuramitryahin.entity.user;

import lombok.*;

import javax.persistence.*;
import java.util.List;
import java.util.Set;

@Builder
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Entity
@Table(name = "question")
public class Question {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id_question")
    private long questionId;

    @Column
    private String question;

    @Column
    @Enumerated(EnumType.STRING)
    private QuestionType questionType;

    @ManyToOne(optional = false, cascade = CascadeType.ALL)
    @JoinColumn(name = "id_test")
    private Tests test;

    @OneToMany(mappedBy = "question", fetch = FetchType.EAGER)
    private Set<Answer> answers;


}
