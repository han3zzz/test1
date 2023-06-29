package com.spring.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.beans.CartForm;
import com.spring.beans.ChangeForm;
import com.spring.beans.ForgetForm;
import com.spring.beans.LoginForm;
import com.spring.beans.RegisterForm;
import com.spring.entities.Account;
import com.spring.entities.Cart;
import com.spring.entities.Category;
import com.spring.entities.HoaDon;
import com.spring.entities.HoaDonChiTiet;
import com.spring.entities.KichThuoc;
import com.spring.entities.Product;
import com.spring.entities.Product_KichThuoc;
import com.spring.services.AccountService;
import com.spring.services.CartService;
import com.spring.services.CategoryService;
import com.spring.services.HoaDonChiTietService;
import com.spring.services.HoaDonService;
import com.spring.services.KichThuocService;
import com.spring.services.ProductKichThuocService;
import com.spring.services.ProductService;
import com.spring.services.impl.EmailService;

import freemarker.template.TemplateException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
public class HomePage {
	@Autowired
	HttpSession session;
	@Autowired
	HttpServletRequest request;
	@Autowired
	ProductService service;
	@Autowired
	ProductKichThuocService productKichThuocService;
	@Autowired
	AccountService accountService;
	@Autowired
	CategoryService categoryService;
	@Autowired
	CartService cartService;
	@Autowired
	KichThuocService kichThuocService;
	@Autowired
	EmailService emailService;
	@Autowired
	HoaDonService hoaDonService;
	@Autowired
	HoaDonChiTietService hoaDonChiTietService;

	@GetMapping(value = {"/", "/index", "/home" })

	public String indexPage(Model model, @RequestParam(name = "pageNum", defaultValue = "1") Integer pageNum) {
		Integer pageSize = 8;
//		int start = (pageNum - 1) * pageSize + 1 ;
//		int end = start + pageSize;
//		List<Product> productPagetion = list.stream().filter(p -> {
//    		return p.getId() >= start && p.getId() < end ;
//    	}).collect(Collectors.toList());
		List<Product> list = service.getAll(pageNum - 1, pageSize).getContent();
		List<Product> count = service.count();
		model.addAttribute("list", list);
		Integer count1 = Math.round(count.size() % pageSize) == 0 ? Math.round(count.size() / pageSize)
				: Math.round(count.size() / pageSize) + 1;
		model.addAttribute("count", count1);
		return "index";
	}

	@GetMapping("/detail/{id}")
	public String detailPage(Model model, @PathVariable(name = "id") Integer id) {
		Product product = service.getProductbyId(id);
		Integer count = 0;
		List<Product_KichThuoc> list = productKichThuocService.count(id);
		for (Product_KichThuoc product_KichThuoc : list) {
			count += product_KichThuoc.getSoLuong();
		}
		model.addAttribute("data", new CartForm());
		model.addAttribute("listKT", list);
		model.addAttribute("count", count);
		model.addAttribute("p", product);
		return "detail";
	}
	@PostMapping("detail/{id}")
	public String detail(Model model , RedirectAttributes redirect ,
			@ModelAttribute(name = "data") CartForm form , BindingResult result) {
		
		Product pro = service.getProductbyId(form.getId());
		Integer count = 0;
		List<Product_KichThuoc> list = productKichThuocService.count(form.getId());
		for (Product_KichThuoc product_KichThuoc : list) {
			count += product_KichThuoc.getSoLuong();
		}
		model.addAttribute("listKT", list);
		model.addAttribute("count", count);
		model.addAttribute("p", pro);
		Account acc = accountService.getByUsername(form.getUsername());
		if (acc == null) {
			request.setAttribute("message", "Vui lòng đăng nhập trước khi thêm sản phẩm vào giỏ hàng !");
			request.setAttribute("type", "error");
			return "detail";
		}
		if (count == 0) {
			request.setAttribute("message", "Sản phẩm tạm hết hàng !");
			request.setAttribute("type", "error");
			return "detail";
		}
		if (!result.hasErrors()) {
			Account account = accountService.getByUsername(form.getUsername());	
			Product product = service.getProductbyId(form.getIdProduct());
			Integer kichThuoc = form.getKichthuoc();
			if (kichThuoc == null) {
				request.setAttribute("message", "Vui lòng chọn kích thước !");
				request.setAttribute("type", "error");
				return "detail";
			}
			BigDecimal donGia = form.getDongia();
			KichThuoc kt = kichThuocService.getKichThuocbyId(kichThuoc);
			Cart c = cartService.getById(form.getUsername(), form.getIdProduct(), kt.getTenKichThuoc());
			if (c == null) {
				Cart cart = new Cart();
				cart.setUsername(account);
				cart.setProduct(product);
				cart.setKichThuoc(kt.getTenKichThuoc());
				cart.setDonGia(donGia);
				cart.setSoLuong(1);
				if (cartService.add(cart) != null) {
					Product_KichThuoc p = productKichThuocService.getByIdProduct(product.getId(), kt.getIdKichThuoc());
					p.setSoLuong(p.getSoLuong() -1);
					productKichThuocService.update(p);
					redirect.addFlashAttribute("message" ,"Thêm vào giỏ hàng thành công !");
					redirect.addFlashAttribute("type", "success");
					return "redirect:/detail/{id}";
				}
			}
			else {
				c.setSoLuong(c.getSoLuong() + 1);
				if (cartService.update(c) != null) {
					Product_KichThuoc p = productKichThuocService.getByIdProduct(product.getId(), kt.getIdKichThuoc());
					p.setSoLuong(p.getSoLuong() -1);
					productKichThuocService.update(p);
					redirect.addFlashAttribute("message" ,"Thêm vào giỏ hàng thành công !");
					redirect.addFlashAttribute("type", "success");
					return "redirect:/detail/{id}";
				}
			}
			
			
			
		}
				return "detail";
		
	}

	@GetMapping("/login")
	public String loginPage(Model model) {
		model.addAttribute("data", new LoginForm());
		return "login";
	}

	@GetMapping("/register")
	public String registerPage(Model model) {
		model.addAttribute("data", new RegisterForm());
		return "register";
	}

	@PostMapping("/register")
	public String register(Model model, RedirectAttributes redirect,@Valid @ModelAttribute("data") RegisterForm form,
			BindingResult result) {
		String username = form.getUsername();
		String password = form.getPassword();
		String repassword = form.getRePassword();
		String email = form.getEmail();
		if (!result.hasErrors()) {
			if (accountService.getByUsername(username) != null) {
				request.setAttribute("message", "Username đã tồn tại trên hệ thống !");
				request.setAttribute("type", "error");
				return "register";
			}
			if (!password.equals(repassword)) {
				request.setAttribute("message", "Xác nhận mật khẩu chưa khớp !");
				request.setAttribute("type", "error");
				return "register";
			}
			if (request.getParameter("checkbox") == null) {
				request.setAttribute("message", "Vui lòng đồng ý với điều khoản trước khi đăng ký !");
				request.setAttribute("type", "error");
				return "register";
			}
			Account acc = new Account();
			acc.setUsername(username);
			acc.setPassword(password);
			acc.setEmail(email);
			acc.setRole(1);
			acc.setActive(0);
			if (accountService.add(acc) != null) {
				redirect.addFlashAttribute("message", "Đăng ký thành công !");
				redirect.addFlashAttribute("type", "success");
				return "redirect:/register";
			}
			
			
		}
		return "register";
	}

	@PostMapping("/login")
	public String login(Model model, RedirectAttributes redirect,@Valid @ModelAttribute("data") LoginForm form,
			BindingResult result) {
		String username = form.getUsername();
		String password = form.getPassword();

		if (!result.hasErrors()) {
			Account account = accountService.authention(username, password);
			if (account != null) {
				session.setAttribute("account", account);
				redirect.addFlashAttribute("message" ,"Đăng nhập thành công !");
				redirect.addFlashAttribute("type", "success");
				return "redirect:/index";
			}
			else {
				request.setAttribute("message", "Tài khoản hoặc mật khẩu không đúng !");
				request.setAttribute("type", "error");
			}
		}
		return "login";
	}

	@GetMapping("/logout")
	public String logout(RedirectAttributes redirect) {
		session.removeAttribute("account");

		return "redirect:/index";
	}

	@GetMapping("/product")
	public String productPage(Model model, @RequestParam(name = "pageNum", defaultValue = "1") Integer pageNum) {
		Integer pageSize = 8;
		List<Product> list = service.getAll(pageNum - 1, pageSize).getContent();
		List<Product> count = service.count();
		List<Category> listCate = categoryService.count();
		model.addAttribute("listCate", listCate);
		model.addAttribute("list", list);
		Integer count1 = Math.round(count.size() % pageSize) == 0 ? Math.round(count.size() / pageSize)
				: Math.round(count.size() / pageSize) + 1;
		model.addAttribute("count", count1);
		return "product";
	}

	@GetMapping("/product/{id}")
	public String productPage(Model model, @RequestParam(name = "pageNum", defaultValue = "1") Integer pageNum,
			@PathVariable(name = "id") Integer id) {
		Integer pageSize = 8;
		List<Product> list = service.getAllbyCate(pageNum - 1, pageSize, id).getContent();
		List<Product> count = service.countbyCate(id);
		List<Category> listCate = categoryService.count();
		model.addAttribute("id", id);
		model.addAttribute("listCate", listCate);
		model.addAttribute("list", list);
		Integer count1 = Math.round(count.size() % pageSize) == 0 ? Math.round(count.size() / pageSize)
				: Math.round(count.size() / pageSize) + 1;
		model.addAttribute("count", count1);
		return "product";
	}

	@GetMapping("/info")
	public String infoPage() {
		return "info";
	}

	@GetMapping("/manage")
	public String managePage() {
		return "manage";
	}

	@GetMapping("/forget")
	public String forgetPage(Model model) {
		model.addAttribute("data", new ForgetForm());
		return "forget";
	}
	@PostMapping("/forget")
	public String forget(Model model ,@Valid @ModelAttribute(name = "data") ForgetForm form , BindingResult result , RedirectAttributes redirect) {
		if (!result.hasErrors()) {
			try {
				Account account = accountService.getByUsername(form.getUsername());
				if (account == null) {
					request.setAttribute("message", "Username không tồn tại trên hệ thống !");
					request.setAttribute("type", "error");
					return null;
				}
				if (!account.getEmail().equals(form.getEmail())) {
					request.setAttribute("message", "Email không khớp với tài khoản của bạn !");
					request.setAttribute("type", "error");
					return null;
				}
				redirect.addFlashAttribute("message", "Đổi mật khẩu thành công ! <br>Vui lòng kiểm tra email của bạn.");
				redirect.addFlashAttribute("type", "success");
				emailService.SendMailForget(form.getUsername(), form.getEmail());
				return "redirect:/forget";
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (TemplateException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return "forget";
	}
	@GetMapping("/change")
	public String changePage(Model model) {
		model.addAttribute("data", new ChangeForm());
		return "change";
	}
	@PostMapping("/change")
	public String change(Model model , RedirectAttributes redirect , @Valid @ModelAttribute(name = "data") ChangeForm form , BindingResult result) {
		if (!result.hasErrors()) {
			Account account = (Account) session.getAttribute("account");
			if (accountService.authention(account.getUsername(), form.getPasscu()) == null) {
				request.setAttribute("message", "Mật khẩu cũ chưa chính xác !");
				request.setAttribute("type", "error");
				return "change";
			}
			if (!form.getPassmoi().equals(form.getRepassmoi())) {
				request.setAttribute("message", "Mật khẩu cũ mới và nhập lại mật khẩu mới chưa khớp !");
				request.setAttribute("type", "error");
				return "change";
			}
			account.setPassword(form.getPassmoi());
			accountService.update(account);
			redirect.addFlashAttribute("message", "Đổi mật khẩu thành công !");
			redirect.addFlashAttribute("type", "success");
			return "redirect:/change";
		}
		return "change";
	}
	@GetMapping("/403")
	public String phanQuyenPage() {
		return "403";
	}
	@GetMapping("/my-order")
	public String myOrderPage(Model model , @RequestParam(name = "pageNum" , defaultValue = "1") Integer pageNum) {
		Account account = (Account) session.getAttribute("account");
		Integer pageSize = 10;
		List<HoaDon> list = hoaDonService.getAll(pageNum - 1, pageSize, account.getUsername()).getContent();
		List<HoaDon> count = hoaDonService.count(account.getUsername());
		Integer count1 = Math.round(count.size() % pageSize) == 0 ? Math.round(count.size() / pageSize)
				: Math.round(count.size() / pageSize) + 1;
		model.addAttribute("count", count1);
		model.addAttribute("listHoaDon", list);
		return "my-order";
	}
	@GetMapping("/my-order/huy/{id}")
	public String myOrderhuyPage(Model model , RedirectAttributes redirect,@PathVariable(name = "id") Integer id) {
		HoaDon hoaDon = hoaDonService.getHoaDonbyId(id);
		hoaDon.setTrangThai(1);
		hoaDonService.update(hoaDon);
		List<HoaDonChiTiet> hdcts = hoaDonChiTietService.getbyId(id);
		for (HoaDonChiTiet hoaDonChiTiet : hdcts) {
			KichThuoc kichThuoc = kichThuocService.getKichThuocbyName(hoaDonChiTiet.getKichThuoc());
			Product_KichThuoc p = productKichThuocService.getByIdProduct(hoaDonChiTiet.getProduct().getId(), kichThuoc.getIdKichThuoc());
			p.setSoLuong(p.getSoLuong() + hoaDonChiTiet.getSoLuong());
			productKichThuocService.update(p);
			
		}
		redirect.addFlashAttribute("message", "Hủy đơn hàng thành công !");
		redirect.addFlashAttribute("type", "success");
		return "redirect:/my-order";
	}
	@GetMapping("/my-order/chitiet/{id}")
	public String myOrderchitietPage(Model model , RedirectAttributes redirect,@PathVariable(name = "id") Integer id) {
		List<HoaDonChiTiet> hoaDonChiTiets = hoaDonChiTietService.getbyId(id);
		request.setAttribute("list", hoaDonChiTiets);
		return "chitiet";
	}
	@GetMapping("/manage-order")
	public String manageOrderPage(Model model , @RequestParam(name = "pageNum" , defaultValue = "1") Integer pageNum) {
		Integer pageSize = 10;
		List<HoaDon> list = hoaDonService.getAllPage(pageNum - 1, pageSize).getContent();
		List<HoaDon> count = hoaDonService.countPage();
		Integer count1 = Math.round(count.size() % pageSize) == 0 ? Math.round(count.size() / pageSize)
				: Math.round(count.size() / pageSize) + 1;
		model.addAttribute("count", count1);
		model.addAttribute("listHoaDon", list);
		return "manage-order";
	}
	@GetMapping("/manage-order/huy/{id}")
	public String manageOrderhuyPage(Model model , RedirectAttributes redirect,@PathVariable(name = "id") Integer id) {
		HoaDon hoaDon = hoaDonService.getHoaDonbyId(id);
		hoaDon.setTrangThai(1);
		hoaDonService.update(hoaDon);
		List<HoaDonChiTiet> hdcts = hoaDonChiTietService.getbyId(id);
		for (HoaDonChiTiet hoaDonChiTiet : hdcts) {
			KichThuoc kichThuoc = kichThuocService.getKichThuocbyName(hoaDonChiTiet.getKichThuoc());
			Product_KichThuoc p = productKichThuocService.getByIdProduct(hoaDonChiTiet.getProduct().getId(), kichThuoc.getIdKichThuoc());
			p.setSoLuong(p.getSoLuong() + hoaDonChiTiet.getSoLuong());
			productKichThuocService.update(p);
			
		}
		redirect.addFlashAttribute("message", "Hủy đơn hàng thành công !");
		redirect.addFlashAttribute("type", "success");
		return "redirect:/manage-order";
	}
	@GetMapping("/manage-order/thanhtoan/{id}")
	public String manageOrderthanhtoanPage(Model model , RedirectAttributes redirect,@PathVariable(name = "id") Integer id) {
		HoaDon hoaDon = hoaDonService.getHoaDonbyId(id);
		hoaDon.setTrangThai(2);
		hoaDonService.update(hoaDon);
		
		redirect.addFlashAttribute("message", "Xác nhận đơn hàng đã giao thành công !");
		redirect.addFlashAttribute("type", "success");
		return "redirect:/manage-order";
	}
	@GetMapping("/manage-order/chitiet/{id}")
	public String manageOrderchitietPage(Model model , RedirectAttributes redirect,@PathVariable(name = "id") Integer id) {
		List<HoaDonChiTiet> hoaDonChiTiets = hoaDonChiTietService.getbyId(id);
		request.setAttribute("list", hoaDonChiTiets);
		return "chitiet2";
	}

}
