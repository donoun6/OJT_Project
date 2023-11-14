package com.da.ojtproject.cart.controller;

import com.da.ojtproject.cart.domain.Cart;
import com.da.ojtproject.cart.service.CartService;
import com.da.ojtproject.home.service.HomeService;
import com.da.ojtproject.inventory.domain.Inventory;
import com.da.ojtproject.inventory.service.InventoryService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequiredArgsConstructor
@RequestMapping("/cart")
public class CartController {

    private final CartService cartService;
    private final InventoryService inventoryService;
    private final HomeService homeService;

    //  장바구니에 선택한 아이템을 추가하는 메서드입니다.
    //  절대 지우면 안되는 메서드 이거 지우면 지금까지 작성했던 거 다 날라간다.
    /*
    * @ResponseBody와 @ResponseEntity의 차이?
    * 결과적으로 같은 기능을 하지만 구현 방법이 조금 틀리다.
    * @ResponseBody의 경우 파라미터로 객체를 받아 header를 변경하고,
    * @ResponseEntity의 경우 클래스 객체를 생성 후 객체에서 header값을 변경한다. */
    @ResponseBody
    @PostMapping("/cart/add")
    public List<Cart> addToCart(@RequestParam int productId) {
        // 프로시져를 통해서 장바구니에 상품을 추가합니다. 이때 productId를 참조해서 장바구니에 상품을 추가합니다.
        cartService.AddOrCountCart(productId);
        // 동작이 완료된 후 메서드를 통해 전체 장바구니 아이템을 조회해줍니다.
        return cartService.findAllCartItems();
    }

    // 장바구니에서 원하는 상품을 삭제하는 메서드입니다.
    @ResponseBody
    @PostMapping("/cart/delete/{cartId}")
    public List<Cart> deleteCartItem(@PathVariable int cartId) {
        // 장바구니에 들어있는 상품중 원하는 상품을 삭제해주는 메서드입니다.
        cartService.deleteCartItem(cartId);
        // 해당하는 상품을 장바구니에서 삭제한 후 전체 장바구니에 속한 상품들의 목록을 화면에 뿌려줍니다.
        return cartService.findAllCartItems();
    }
    // 장바구니에서 모든 아이템을 삭제하는 메서드입니다.
    // 역시나 ResponseBody를 통해서 화면에 뿌려줘야 합니다.
    @ResponseBody
    @PostMapping("/cart/deleteAll")
    public ResponseEntity<Void> deleteAllItems() {
        // cartService의 deleteCart() 메서드를 통해서 현재 장바구니 전체 목록을 비워줍니다.
        cartService.deleteCart();
        // 그 후 화면 그대로의 모습을 뿌려줍니다.
        return ResponseEntity.ok().build();
    }
    // 장바구니 전체 목록을 불러오는 메서드입니다.
    @GetMapping("/cart")
    public String viewCart(Model model) {
        List<Cart> cartItems = cartService.findAllCartItems();
        model.addAttribute("cartItems", cartItems);
        return "index";
    }

    @ResponseBody
    @PostMapping("/cart/increaseQuantity")
    public ResponseEntity<List<Cart>> increaseCartItemQuantity(@RequestParam int cartId, @RequestParam int productId) {
        /* Inventory(창고)로부터 productId(상품Id)를 통해 현재 상품의 재고량을 파악합니다. */
        Inventory inventory = inventoryService.getInventoryByProductId(productId);
        /* cartId(장바구니목록의Id)를 통해서 현재 장바구니에 담긴 상품을 조회합니다. */
        Cart cartItem = cartService.findCartItemById(cartId);
        /* 만약에 장바구니에 담긴 상품이 존재하고 재고가 존재한다면 */
        if(cartItem != null && inventory != null) {
            /* 현재 장바구니에 담긴 수량이 재고의 수량보다 적다면 */
            if (cartItem.getQuantity() < inventory.getQuantity()) {
                /* 장바구니에 담긴 상품의 수량을 증가시킬수 있습니다. */
                cartService.updateQuantity(cartId);
            } else {
                /* 그렇지 않다면 아무 동작을 할수 없게 응답을 보냅니다. */
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(null);
            }
        }
        /* 최종적으로 상품의 수량을 정했다면 ResponseEntity.ok 값을 통해 장바구니에 담긴 모든 상품들의 목록을 업데이트 해줍니다. */
        /* ResponseEntity란, httpentity를 상속받는, 결과 데이터와 HTTP 상태 코드를 직접 제어할 수 있는 클래스입니다. */
        /* ResponseEntity에는 사용자의 HttpRequest에 대한 응답 데이터가 포함됩니다. */
        return ResponseEntity.ok(cartService.findAllCartItems());
    }
    @ResponseBody
    @PostMapping("/cart/decreaseQuantity")
    // 상품수량을 감소시키는 메서드.
    public List<Cart> decreaseCartItemQuantity(@RequestParam int cartId) {
        // cartId로 해당 항목을 찾습니다.
        Cart cartItem = cartService.findCartItemById(cartId); // cartId로 해당 항목 찾기

        // cartItem객체가 0이 아니라는 가정하에 아래 알고리즘이 돌아갑니다.
        if(cartItem != null) {
            // 만약 장바구니 객체의 수량이 0보다 적으면
            if(cartItem.getQuantity() <= 1) {
                // 0보다 해당 수량이 작다는 가정하에 해당 항목을 장바구니 목록에서 삭제합니다.
                cartService.deleteCartItem(cartId);// 해당 항목 삭제
            } else {
                // 장바구니 수량이 0보다는 크다면 수량을 계속 감소 시킬 수 있게 합니다.
                cartService.decreaseQuantity(cartId); // 그렇지 않으면 수량 감소
            }
        }
        // 그런 다음 장바구니의 전체 목록을 찾아서 출력해줍니다.
        return cartService.findAllCartItems(); // 갱신된 장바구니 목록 반환
    }

}
