package com.gmail.yuramitryahin.repository;

import com.gmail.yuramitryahin.entity.user.Files;
import com.gmail.yuramitryahin.entity.user.Topics;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TopicsRepository extends JpaRepository<Topics, Long> {

       Topics getTopicsByTopicId(long id);

}
