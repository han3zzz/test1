package com.spring.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.beans.ProductForm;
import com.spring.entities.Category;
import com.spring.entities.KichThuoc;
import com.spring.entities.Product;
import com.spring.entities.Product_KichThuoc;
import com.spring.services.CategoryService;
import com.spring.services.KichThuocService;
import com.spring.services.ProductKichThuocService;
import com.spring.services.ProductService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;

@Controller
@RequestMapping("/admin")
public class ProductController {
	@Autowired
	ProductService service;
	@Autowired
	CategoryService categoryService;
	@Autowired
	KichThuocService kichThuocService;
	@Autowired
	HttpServletRequest request;
	@Autowired
	ProductKichThuocService productKichThuocService;
	@Value("${upload.path}")
	private String pathFolder;

	@GetMapping(value = { "", "/", "/index" })
	public String indexPage(Model model, @RequestParam(name = "pageNum", defaultValue = "1") Integer pageNum) {
		Integer pageSize = 8;
		List<Product> list = service.getAll(pageNum - 1, pageSize).getContent();
		List<Product> count = service.count();
		model.addAttribute("list", list);
		Integer count1 = Math.round(count.size() % pageSize) == 0 ? Math.round(count.size() / pageSize)
				: Math.round(count.size() / pageSize) + 1;
		model.addAttribute("count", count1);
		return "admin/admin";
	}

	@GetMapping("/add")
	public String addPage(Model model) {
		model.addAttribute("listCategory", categoryService.count());
		model.addAttribute("listKichThuoc", kichThuocService.count());
		model.addAttribute("data", new ProductForm());
		return "admin/addProduct";
	}

	@PostMapping("/add")
	public String add(Model model,RedirectAttributes rediret, @Valid @ModelAttribute(name = "data") ProductForm form, 
			BindingResult result, @RequestParam("file") MultipartFile file) {
			model.addAttribute("listCategory", categoryService.count());
			model.addAttribute("listKichThuoc", kichThuocService.count());
		
			if (result.hasErrors()) {
				return "admin/addProduct";
			}
			if (file.isEmpty()) {
				request.setAttribute("message", "Vui lòng upload ảnh !");
				request.setAttribute("type", "error");
				return "admin/addProduct";
			}
			List<KichThuoc> kts = kichThuocService.count();
			Integer sl = 0 ;
			for (KichThuoc kt : kts) {
				sl += Integer.parseInt(request.getParameter(kt.getTenKichThuoc()));
				if (Integer.parseInt(request.getParameter(kt.getTenKichThuoc())) < 0 || Integer.parseInt(request.getParameter(kt.getTenKichThuoc())) > 9999) {
					request.setAttribute("message", "Số lượng size " + kt.getTenKichThuoc() + " phải lớn hơn 0 và nhỏ hơn hoặc bằng 9999 !");
					request.setAttribute("type", "error");
					return "admin/addProduct";
				}
			}
			if (sl == 0) {
				request.setAttribute("message", "Tổng số lượng size phải lớn hơn 0 !");
				request.setAttribute("type", "error");
				return "admin/addProduct";
			}
		
			try {
				if (!file.isEmpty()) {
					byte[] bytes;
					bytes = file.getBytes();
					Path path = Paths.get(pathFolder + file.getOriginalFilename());
					Files.write(path, bytes);
					Product p = form.data(null);
					p.setPhanLoai(form.getPhanloai());
					p.setAnh(file.getOriginalFilename());
					Category cate = categoryService.getCatebyId(Integer.parseInt(p.getPhanLoai()));
					p.setCategory(cate);
					p.setTrangThai(0);
					if (form.getGiamgia() == 0) {
						p.setGiaDaGiam(form.getGia());
					}else {
						BigDecimal giaGiam = form.getGia().multiply(BigDecimal.valueOf(form.getGiamgia()).divide(BigDecimal.valueOf(100)));
						p.setGiaDaGiam(form.getGia().subtract(giaGiam));
					}
					
					if (service.add(p) != null) {
					
						List<KichThuoc> kichThuocs = kichThuocService.count();
						for (KichThuoc kt : kichThuocs) {
							Integer soLuong = Integer.parseInt(request.getParameter(kt.getTenKichThuoc()));
							
							System.out.println(kt.getTenKichThuoc());
							Product_KichThuoc product_KichThuoc = new Product_KichThuoc();
							product_KichThuoc.setKichThuoc(kt);
							product_KichThuoc.setProduct(p);
							product_KichThuoc.setSoLuong(soLuong);
							productKichThuocService.add(product_KichThuoc);
						}
						rediret.addFlashAttribute("message", "Thêm sản phẩm thành công !");
						rediret.addFlashAttribute("type", "success");
						return "redirect:/admin";
					}
				}
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		return "admin/addProduct";
	}

	@GetMapping("/update/{id}")
	public String updatePage(Model model, @PathVariable(name = "id") Integer id, RedirectAttributes redirect) {
		Product p = service.getProductbyId(id);
		model.addAttribute("p", p);
		model.addAttribute("listCategory", categoryService.count());
		model.addAttribute("listKichThuoc", productKichThuocService.count(id));
		model.addAttribute("data", new ProductForm());
		return "admin/updateProduct";
	}

	@PostMapping("/update")
	public String update(Model model,RedirectAttributes rediret, @Valid @ModelAttribute(name = "data") ProductForm form, 
			BindingResult result, @RequestParam("file") MultipartFile file) {
		model.addAttribute("listCategory", categoryService.count());
		model.addAttribute("listKichThuoc", productKichThuocService.count(form.getId()));
		if (result.hasErrors()) {
			return "admin/updateProduct";
		}
		
		List<KichThuoc> kts = kichThuocService.count();
		for (KichThuoc kichThuoc : kts) {
			if (Integer.parseInt(request.getParameter(kichThuoc.getTenKichThuoc())) < 0 || Integer.parseInt(request.getParameter(kichThuoc.getTenKichThuoc())) > 9999) {
				request.setAttribute("message", "Số lượng size " + kichThuoc.getTenKichThuoc() + " phải lớn hơn 0 và nhỏ hơn hoặc bằng 9999 !");
				request.setAttribute("type", "error");
				return "admin/updateProduct";
			}
		}
		Integer sl = 0 ;
		for (KichThuoc kt : kts) {
			sl += Integer.parseInt(request.getParameter(kt.getTenKichThuoc()));
		}
		if (sl == 0) {
			request.setAttribute("message", "Tổng số lượng size phải lớn hơn 0 !");
			request.setAttribute("type", "error");
			return "admin/updateProduct";
		}
		if (!result.hasErrors()) {
			try {
				Product pro = service.getProductbyId(form.getId());
				Product p = form.data(pro);
				String anh = "";
				if (file.isEmpty()) {
					anh = p.getAnh();
				} else {
					anh = file.getOriginalFilename();
					byte[] bytes;

					bytes = file.getBytes();

					Path path = Paths.get(pathFolder + file.getOriginalFilename());
					Files.write(path, bytes);
				}

				p.setAnh(anh);
				p.setPhanLoai(form.getPhanloai());
				Category cate = categoryService.getCatebyId(Integer.parseInt(p.getPhanLoai()));
				p.setCategory(cate);
				p.setTrangThai(0);
				if (form.getGiamgia() == 0) {
					p.setGiaDaGiam(form.getGia());
				}else {
					BigDecimal giaGiam = form.getGia().multiply(BigDecimal.valueOf(form.getGiamgia()).divide(BigDecimal.valueOf(100)));
					p.setGiaDaGiam(form.getGia().subtract(giaGiam));
				}
				if (service.update(p) != null) {

					List<Product_KichThuoc> kichThuocs = productKichThuocService.count(p.getId());
					for (Product_KichThuoc kt : kichThuocs) {
						Integer soLuong = Integer.parseInt(request.getParameter(kt.getKichThuoc().getTenKichThuoc()));
						Product_KichThuoc product_KichThuoc = productKichThuocService.getByIdProduct(p.getId(),
								kt.getKichThuoc().getIdKichThuoc());
						product_KichThuoc.setSoLuong(soLuong);
						productKichThuocService.update(product_KichThuoc);
					}
					rediret.addFlashAttribute("message", "Sửa sản phẩm thành công !");
					rediret.addFlashAttribute("type", "success");
					return "redirect:/admin";
				}

			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return "admin/updateProduct";
	}

	@GetMapping("/delete/{id}")
	public String deletePage(Model model, @PathVariable(name = "id") Integer id , RedirectAttributes rediret) {
		Product product = service.getProductbyId(id);
		if (service.delete(product) != null) {
			rediret.addFlashAttribute("message", "Xóa sản phẩm thành công !");
			rediret.addFlashAttribute("type", "success");
			return "redirect:/admin";
		}
		return "admin/admin";
	}

}
