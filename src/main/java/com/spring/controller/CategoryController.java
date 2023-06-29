package com.spring.controller;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.beans.CategoryForm;
import com.spring.entities.Category;
import com.spring.services.CategoryService;

import jakarta.validation.Valid;

@Controller
@RequestMapping("/category")
public class CategoryController {
	@Autowired
	private CategoryService service;

	@GetMapping(value = { "", "/", "/index" })
	public String indexPage(Model model, @RequestParam(name = "pageNum", defaultValue = "1") Integer pageNum) {
		Integer pageSize = 5;
		List<Category> list = service.getAll(pageNum - 1, pageSize).getContent();
		List<Category> count = service.count();
		model.addAttribute("list", list);
		Integer count1 = Math.round(count.size() % pageSize) == 0 ? Math.round(count.size() / pageSize)
				: Math.round(count.size() / pageSize) + 1;
		model.addAttribute("count", count1);
		return "category/index";
	}

	@GetMapping("/add")
	public String addPage(Model model) {

		model.addAttribute("data", new CategoryForm());
		return "category/addCategory";
	}

	@PostMapping("/add")
	public String add(Model model, RedirectAttributes redirect,@Valid @ModelAttribute(name = "data") CategoryForm form,
			BindingResult result) {

		if (!result.hasErrors()) {
			Category category = form.data(null);
			category.setTrangThai(0);

			if (service.add(category) != null) {
				redirect.addFlashAttribute("message","Thêm Category thành công !");
				redirect.addFlashAttribute("type","success");
				return "redirect:/category";
			}
		}
		return "category/addCategory";
	}

	@GetMapping("/update/{id}")
	public String updatePage(Model model, @PathVariable(name = "id") Integer id) {
		Category category = service.getCatebyId(id);
		model.addAttribute("cate", category);
		model.addAttribute("data", new CategoryForm());
		return "category/updateCategory";
	}

	@PostMapping("/update")
	public String update(Model model, RedirectAttributes redirect,@Valid @ModelAttribute(name = "data") CategoryForm form,
			BindingResult result) {
		if (!result.hasErrors()) {
			Category cate = service.getCatebyId(form.getId());
			Category category = form.data(cate);
			if (service.update(category) != null) {
				redirect.addFlashAttribute("message","Sửa Category thành công !");
				redirect.addFlashAttribute("type","success");
				return "redirect:/category";
			}
		}
		return "category/updateCategory";
	}

	@GetMapping("/delete/{id}")
	public String deletePage(Model model, @PathVariable(name = "id") Integer id , RedirectAttributes redirect) {
		Category category = service.getCatebyId(id);
		if (service.delete(category) != null) {
			redirect.addFlashAttribute("message","Xóa Category thành công !");
			redirect.addFlashAttribute("type","success");
			return "redirect:/category";
		}
		return "category/index";
	}

}
