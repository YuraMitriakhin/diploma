package com.gmail.yuramitryahin.repository;

import com.gmail.yuramitryahin.entity.user.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;


@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    User findByUsername(String username);
    User findById(long id);

    @Query(value = "SELECT * from Users u WHERE u.user_id = ?1", nativeQuery = true)
    User findUserNative(long id);
}
