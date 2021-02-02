package com.gmail.yuramitryahin.repository;

import com.gmail.yuramitryahin.entity.user.Course;
import com.gmail.yuramitryahin.entity.user.Files;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CourseRepository extends JpaRepository<Course, Long> {
    Course getCourseByCourseId(long id);
}
