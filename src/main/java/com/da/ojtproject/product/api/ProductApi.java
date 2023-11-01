package com.da.ojtproject.product.api;

import com.da.ojtproject.category.domain.Category;
import com.da.ojtproject.product.domain.Product;
import com.da.ojtproject.product.service.ProductService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Map;

@RestController
@RequestMapping("api")
@RequiredArgsConstructor
public class ProductApi {

    private final ProductService productService;
    private static final String UPLOAD_DIR = "src/main/resources/static/img/";

//    @PostMapping("/product/save")
//    public void productSave(Model model,
//                              @RequestBody Map<String, Object> allData
//                            ) throws IOException {
//        System.out.println(allData);
//    }

    @PostMapping("/product/save")
    public ResponseEntity<String> productSave(@RequestPart("imageFile") MultipartFile imageFile,
                                              @RequestParam("categoryId") int categoryId,
                                              @RequestParam("name") String name,
                                              @RequestParam("code") String code,
                                              @RequestParam("sellPrice") int sellPrice) throws IOException {

        Product product = new Product();
        product.setCategoryId(categoryId);
        product.setName(name);
        product.setCode(code);
        product.setSellPrice(sellPrice);

        if (!imageFile.isEmpty()) {

            String fileName = imageFile.getOriginalFilename();
            Path filePath = Paths.get(UPLOAD_DIR, fileName);

            Files.write(filePath, imageFile.getBytes());

            product.setImage("img/" + fileName);
        }
        productService.saveProduct(product);
        return ResponseEntity.ok("상품이 등록되었습니다.");
    }
}
