package com.gmail.yuramitryahin.repository;

import com.gmail.yuramitryahin.entity.user.Files;
import com.gmail.yuramitryahin.entity.user.Lesson;
import com.gmail.yuramitryahin.entity.user.Links;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface LinksRepository extends JpaRepository<Links, Long> {

    void deleteByLessonID(Lesson lesson);

}
