package com.spring.configuration;

import org.springframework.context.MessageSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.support.ReloadableResourceBundleMessageSource;

@Configuration
public class WebMvcConfig {
	@Bean("messageSource")
	public MessageSource getMessageSource() {
		ReloadableResourceBundleMessageSource soure = new ReloadableResourceBundleMessageSource();
		soure.setBasename("classpath:message/validation");
		soure.setDefaultEncoding("UTF-8");
		return soure;
	}
}
