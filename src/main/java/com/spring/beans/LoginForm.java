package com.spring.beans;

import org.hibernate.validator.constraints.Length;

import jakarta.validation.constraints.NotBlank;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class LoginForm {
	@NotBlank(message = "{NotBlank.login.username}")
	@Length(max = 15 , message = "{Length.login.username}")
	private String username;
	@NotBlank(message = "{NotBlank.login.password}")
	@Length(max = 16 , message = "{Length.login.password}")
	private String password;
}
