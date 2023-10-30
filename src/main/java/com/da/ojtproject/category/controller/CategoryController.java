package com.da.ojtproject.category.controller;


import com.da.ojtproject.category.domain.Category;
import com.da.ojtproject.category.service.CategoryService;
import com.da.ojtproject.product.domain.Product;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

// 뭔가 카테고리Id를 재정렬하는 방법이 없을까 고민이 됩니다. 뭔가 좋은 방법이 없을까요?
@Controller
@AllArgsConstructor
public class CategoryController {

    // categoryService를 등록해줍니다.
    private final CategoryService categoryService;

    // 타임리프와 연동을 하기 위해서는 아래와 같이 생성자를 적어놓는게 중요합니다. 명심하십시오!
    // 그만 물어보고 개인적으로 남아서 공부할것.
    @GetMapping("/cate")
    public String catePage(Model model) {

        model.addAttribute("category", new Category());

        return "category/category";

    }

    // 관리자가 카테고리를 프로시저를 이용하여 등록하는 페이지입니다.
    // 프로시저를 활용하는 새로운 방법에 대해서 알게 되었다.
    // 알려주신 프로시저 방법을 공부하여 간단한 프로시저를 직접 개발해 볼 것.
    @PostMapping("/category")
    public String submitCategory(@ModelAttribute Category category) {

        // 카테고리에 관리자가 등록하고 싶은 카테고리를 등록해줍니다.
        // AddOrResetCategory 프로시저를 사용합니다.
        categoryService.addOrResetCategory(category.getName());

        // 카테고리 리스트에 카테고리 목록을 등록하고 리디렉션을 통해서 페이지를 최신화해줍니다.
        return "redirect:/categoryList";
    }



    // 현재까지 등록한 카테고리의 목록을 불러옵니다.
    // 리스트 출력을 위한 것이므로 GetMapping 어노테이션을 사용해줍니다.
    @GetMapping("/categoryList")
    public String listCategories(Model model) {
        // 등록한 카테고리 리스트를 모두 불러오는 코드입니다.
        List<Category> categories = categoryService.findAllCategories();
        // 변수에 카테고리를 저장해서 타임리프 페이지에 출력해줍니다.
        model.addAttribute("categories", categories);
        // 카테고리 등록을 했으면 카테고리 리스트 목록으로 갑니다. 중요한 점은 리디렉션이 아니라 바로 뷰템플릿으로 이동한다는 점입니다.
        return "category/categoryList";
    }

    // 카테고리 메인페이지로 이동하는 버튼입니다.
    @GetMapping("/registerCategory")
    public String MainPage(Model model) {
        model.addAttribute("category", new Category());
        return "category/category";
    }

    // 카테고리 아이디를 받아와서 원하는 카테고리 목록을 삭제합니다.
    @GetMapping("/deleteCategory/{id}")
    public String deleteCategory(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            categoryService.deleteCategory(Math.toIntExact(id)); // 카테고리 삭제
            redirectAttributes.addFlashAttribute("successMessage", "Category deleted successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Error deleting category. Please try again.");
        }

        return "redirect:/categoryList";
    }

    // 관리자가 카테고리 목록을 수정합니다.
    @PostMapping("/editCategory")
    public String editCategory(@RequestParam("oldName") String oldName, @RequestParam("newName") String newName, RedirectAttributes redirectAttributes) {
        try {
            categoryService.editCategoryName(oldName, newName);
            redirectAttributes.addFlashAttribute("successMessage", "Category updated successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Error updating category. Please try again.");
        }
        return "redirect:/categoryList";
    }

}
