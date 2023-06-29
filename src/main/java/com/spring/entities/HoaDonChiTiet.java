package com.spring.entities;

import java.io.Serializable;
import java.math.BigDecimal;

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
@Table(name = "HoaDonChiTiet")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class HoaDonChiTiet implements Serializable{
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "idHoaDonChiTiet")
	private Integer id;
	@ManyToOne
	@JoinColumn(name = "idHoaDon" , nullable = false)
	private HoaDon hoaDon ;
	@ManyToOne
	@JoinColumn(name = "idProduct" , nullable = false)
	private Product product ;
	@Column(name = "soLuong")
	private Integer soLuong;
	@Column(name = "donGia")
	private BigDecimal donGia ;
	@Column(name = "kichThuoc",  length = 50)
	private String kichThuoc;
	
	
	
	
	
	
	
}
