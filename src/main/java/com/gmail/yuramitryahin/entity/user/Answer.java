package com.gmail.yuramitryahin.entity.user;

import lombok.*;

import javax.persistence.*;

@Builder
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Entity
@Table(name = "answers")
public class Answer {

    @Id
    @GeneratedValue (strategy = GenerationType.AUTO)
    @Column(name = "id_answer")
    private long answerId;

    @Column
    private String answer;

    @Column
    private boolean correct;

    @ManyToOne(optional = false, cascade = CascadeType.ALL)
    @JoinColumn(name = "id_question")
    private Question question;
}
