package com.spring.beans;

import org.hibernate.validator.constraints.Length;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotEmpty;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class RegisterForm {
	@NotBlank(message = "{NotBlank.register.username}")
	@Length(max = 15 , message = "{Length.register.username}")
	private String username;
	@NotBlank(message = "{NotBlank.register.password}")
	@Length(min = 8 , message = "{Length.register.passwordMin}")
	@Length(max = 16 , message = "{Length.register.passwordMax}")
	private String password;
	@NotBlank(message = "{NotBlank.register.repassword}")
	@Length(min = 8 , message = "{Length.register.repasswordMin}")
	@Length(max = 16 , message = "{Length.register.repasswordMax}")
	private String rePassword;
	@NotBlank(message = "{NotBlank.register.email}")
	@Length(max = 100 , message = "{Length.register.emailMax}")
	@Email(message = "{Format.register.email}")
	private String email;
	
	
}
