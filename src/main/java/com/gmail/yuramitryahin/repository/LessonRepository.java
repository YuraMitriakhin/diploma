package com.gmail.yuramitryahin.repository;

import com.gmail.yuramitryahin.entity.user.Course;
import com.gmail.yuramitryahin.entity.user.Lesson;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface LessonRepository extends JpaRepository<Lesson, Long> {
     Lesson findById(long id);
     void deleteById(long id);
     List<Lesson> findAllByCourseId(Course course);

}
