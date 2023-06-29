package com.spring.beans;

import org.hibernate.validator.constraints.Length;

import jakarta.validation.constraints.NotBlank;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ForgetForm {
	@NotBlank(message = "{NotBlank.forget.username}")
	@Length(max = 15, message = "{Length.forget.username}")
	String username;
	@NotBlank(message = "{NotBlank.forget.email}")
	@Length(max = 100 , message = "{Length.forget.email}")
	String email;
}
