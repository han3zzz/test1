package com.spring.entities;

import java.io.Serializable;
import java.util.List;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;



@Entity
@Table(name = "KichThuoc")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class KichThuoc implements Serializable{
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "idKichThuoc")
	private Integer idKichThuoc;
	@Column(name = "tenKichThuoc" , length = 100, nullable = false)
	private String tenKichThuoc;
	@Column(name = "trangThai")
	private Integer trangThai;
	
	@OneToMany(mappedBy = "kichThuoc", fetch = FetchType.LAZY)
	private List<Product_KichThuoc> kichthuocs;

	
	
	
}
