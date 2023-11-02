package com.da.ojtproject.category.api;

import com.da.ojtproject.category.domain.Category;
import com.da.ojtproject.category.service.CategoryService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

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


}
