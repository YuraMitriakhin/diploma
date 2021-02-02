package com.gmail.yuramitryahin.dto;

import lombok.*;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
@ToString
public class UserDTO {
    private String username;
    private String password;
    private String email;
}
