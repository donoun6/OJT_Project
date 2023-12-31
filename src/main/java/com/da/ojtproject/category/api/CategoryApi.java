package com.da.ojtproject.category.api;

import com.da.ojtproject.category.domain.Category;
import com.da.ojtproject.category.service.CategoryService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
public class CategoryApi {

    private final CategoryService categoryService;

    /**
     * 전체 카테고리 조회
     */
    @GetMapping("/api/category")
    public List<Category> category() {
        return categoryService.getAllCategory();
    }

    /**
     * 카테고리 저장
     */
    @PostMapping("/api/category")
    public HttpStatus categorySave(@RequestBody Category category) {
        if (category.getName() == null || category.getName().trim().isEmpty()) {
            return HttpStatus.BAD_REQUEST;
        }
        categoryService.addOrResetCategory(category);
        return HttpStatus.OK;
    }

    /**
     * 카테고리 삭제 처리
     */
    @DeleteMapping("/api/category/{categoryId}")
    public HttpStatus categoryDelete(@PathVariable int categoryId) {
        categoryService.deleteCategory(categoryId);
        return HttpStatus.OK;
    }

    /**
     * 상품 복구
     */
    @PutMapping("/api/category/{categoryId}")
    public HttpStatus categoryRecover(@PathVariable int categoryId) {
        categoryService.recoverCategory(categoryId);
        return HttpStatus.OK;
    }


}
