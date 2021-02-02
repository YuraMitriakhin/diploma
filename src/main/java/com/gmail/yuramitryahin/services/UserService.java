package com.gmail.yuramitryahin.services;

import com.gmail.yuramitryahin.DataSaveDBException;
import com.gmail.yuramitryahin.dto.UserDTO;
import com.gmail.yuramitryahin.dto.UsersDTO;
import com.gmail.yuramitryahin.entity.user.Role;
import com.gmail.yuramitryahin.entity.user.User;
import com.gmail.yuramitryahin.repository.UserRepository;
import lombok.NonNull;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.sql.SQLException;
import java.util.Collections;

@Slf4j
@Service
public class UserService implements UserDetailsService {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

   @Autowired
    public UserService(UserRepository userRepository, PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
    }

    public UsersDTO getAllUsers() {
        //TODO checking for an empty user list
        return new UsersDTO(userRepository.findAll());
    }

    public User findUserNative(long id) {
        //TODO checking for an empty user list
        return userRepository.findUserNative(id);
    }

    public User findByUserId (long id){
        //TODO check for user availability. password check
        return userRepository.findById(id);
    }

    public User findByUsername (String username){
        //TODO check for user availability. password check
        return userRepository.findByUsername(username);
    }

    public void saveNewUser (UserDTO userDTO) throws DataSaveDBException {
        //TODO inform the user about the replay email
        try {
            //user.setPassword(new BCryptPasswordEncoder().encode(user.getPassword()));
            User user = User
                    .builder()
                    .username(userDTO.getUsername())
                    .email(userDTO.getEmail())
                    .password(passwordEncoder.encode(userDTO.getPassword()))
                    .enabled(true)
                    //Temp usage of one hardcode role
                    .authorities(Collections.singleton(Role.USER))
                    .premium(false)
                    .build();
            userRepository.save(user);
            log.info("New user " + user);
        } catch (Exception ex){
            log.info("{Лог уже существует}");
            throw new DataSaveDBException("Log already exists");
        }

    }

    public void save(User user){
       userRepository.save(user);
    }


    @Override
    public UserDetails loadUserByUsername(@NonNull String username) throws UsernameNotFoundException {
        return userRepository.findByUsername(username);
    }
}
