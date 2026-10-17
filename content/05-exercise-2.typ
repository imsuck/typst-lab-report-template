#import "/metadata.typ": *

= Bài tập 2: Đọc trạng thái nút nhấn (GPIO Input & Debounce) <sec:exercise2>

== Mục tiêu thí nghiệm
- Cấu hình GPIO ở chế độ ngõ vào số (Digital Input).
- Khảo sát hiện tượng rung phím cơ học và hiện thực thuật toán lọc nhiễu phần mềm.

== Sơ đồ kết nối
Nút nhấn User Button trên kit được nối với chân `PA0`. Khi nhấn nút, chân `PA0` được kéo lên mức $V_"DD"$ (Active High).

== Mã nguồn lọc rung nút nhấn

```c
#include "stm32f4xx.h"

uint8_t read_button_debounced(void) {
    if ((GPIOA->IDR & GPIO_IDR_ID0) != 0) {
        for (volatile int i = 0; i < 8000; i++); // Tro delay khoang 20ms
        if ((GPIOA->IDR & GPIO_IDR_ID0) != 0) {
            return 1;
        }
    }
    return 0;
}
```

== Thảo luận kết quả
Khi nhấn nút không có thuật toán lọc rung, quan sát trên máy hiện sóng ghi nhận chuỗi xung nhiễu kéo dài khoảng $5"ms" - 15"ms"$ do tiếp điểm cơ khí đàn hồi. Việc áp dụng thời gian trễ lọc rung $20"ms"$ đã loại bỏ hoàn toàn các xung kích sai, giúp đếm chính xác số lần nhấn phím.
