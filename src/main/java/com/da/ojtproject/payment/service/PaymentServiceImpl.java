package com.da.ojtproject.payment.service;

import com.da.ojtproject.payment.dao.PaymentDao;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class PaymentServiceImpl implements PaymentService {

    private final PaymentDao paymentDao;

    @Override
    public boolean processPayment(String imp_uid) {
        // 여기서 아임포트 API로부터 결제 상태와 정보를 확인해야 합니다.
        // 예를 들면, 아임포트 API로부터 받아온 결제 금액과 데이터베이스에 저장된 금액을 비교하는 등의 로직이 필요합니다.
        boolean paymentVerified = true; // 예시로 true를 설정하였습니다.
        if (paymentVerified) {
            return paymentDao.addSellingAndClearCart();
        } else {
            return false;
        }
    }
}
