package com.spring.entities;

import java.io.Serializable;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;


@Entity
@Table(name = "Product_KichThuoc")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class Product_KichThuoc implements Serializable{
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id", nullable = false)
	private Integer id;
	@ManyToOne
	@JoinColumn(name = "idKichThuoc")
	private KichThuoc kichThuoc;
	@ManyToOne
	@JoinColumn(name = "idProduct")
	private Product product;
	@Column(name = "soLuong")
	private Integer soLuong;
	
}
