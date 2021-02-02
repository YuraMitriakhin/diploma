package com.gmail.yuramitryahin.dto;

import com.gmail.yuramitryahin.entity.user.User;
import lombok.*;

import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
public class UsersDTO {
private List<User> users;
}
