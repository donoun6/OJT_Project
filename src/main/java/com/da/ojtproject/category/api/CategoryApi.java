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

    private  final CategoryService categoryService;

    /**
     * 전체 카테고리 조회
     * @return
     */
    @GetMapping("/api/category")
    public List<Category> category() {
        return categoryService.getAllCategory();
    }

    /**
     * 카테고리 저장
     * @param category
     * @return
     */
    @PostMapping("/api/category")
    public HttpStatus categorySave(@RequestBody Category category) {
        categoryService.addOrResetCategory(category);
        return HttpStatus.OK;
    }

    /**
     * 카테고리 삭제 처리
     * @param categoryId
     * @return
     */
    @DeleteMapping("/api/category/{categoryId}")
    public HttpStatus categoryDelete(@PathVariable int categoryId) {
        categoryService.deleteCateogory(categoryId);
        return HttpStatus.OK;
    }

    @PutMapping("/api/category/{categoryId}")
    public HttpStatus categoryRecover(@PathVariable int categoryId) {
        categoryService.recoverCategory(categoryId);
        return HttpStatus.OK;
    }


}
