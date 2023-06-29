package com.spring.entities;

import java.io.Serializable;
import java.util.List;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;



@Entity
@Table(name = "Account")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class Account implements Serializable{

	@Id
	@Column(name = "username" , nullable = false , length = 15)
	private String username ;
	@Column(name = "password" , length = 255)
	private String password ;
	@Column(name = "email" , length = 100)
	private String email ;
	@Column(name = "active")
	private Integer active;
	@Column(name = "role")
	private Integer role ;
	
	@OneToMany(mappedBy = "username" , fetch = FetchType.LAZY)
	private List<HoaDon> hoaDons;
	@OneToMany(mappedBy = "username", fetch = FetchType.LAZY)
	private List<Cart> carts ;
	
	
	
	
	
	
	
	
	
	
}
