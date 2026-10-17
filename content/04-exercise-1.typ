#import "../metadata.typ": *

= Bài tập 1: Cấu hình GPIO Output điều khiển LED <sec:exercise1>

== Mục tiêu thí nghiệm
- Nắm vững quy trình cấu hình cổng GPIO xuất tín hiệu số.
- Thiết lập chu kỳ bật/tắt (Toggle) LED với khoảng thời gian xác định $T = 1"s"$.

== Sơ đồ kết nối phần cứng
Chân điều khiển LED được gắn vào `GPIOD Pin 12` (Green LED) trên STM32F4-Discovery board.

#figure(
  table(
    columns: (1fr, 1fr, 1fr),
    align: center,
    [Chân MCU], [Linh kiện ngoại vi], [Cấu hình hoạt động],
    [`PD12`], [LED Xanh lá (Green)], [Output Push-Pull, No-pull, High-Speed],
    [`PD13`], [LED Cam (Orange)], [Output Push-Pull, No-pull, High-Speed],
    [`PD14`], [LED Đỏ (Red)], [Output Push-Pull, No-pull, High-Speed],
    [`PD15`], [LED Xanh dương (Blue)], [Output Push-Pull, No-pull, High-Speed],
  ),
  caption: [Bảng phân bổ chân GPIO điều khiển dãy 4 LED trên Kit STM32F4],
)

== Mã nguồn thực thi

```c
#include "stm32f4xx.h"

void delay_ms(uint32_t ms) {
    for (uint32_t i = 0; i < ms * 4000; i++) {
        __NOP();
    }
}

int main(void) {
    // 1. Kich hoat clock GPIOD
    RCC->AHB1ENR |= RCC_AHB1ENR_GPIODEN;

    // 2. Cau hinh PD12, PD13, PD14, PD15 la Output (01)
    GPIOD->MODER &= ~(0xFFU << 24);
    GPIOD->MODER |=  (0x55U << 24);

    while (1) {
        GPIOD->ODR ^= (0xFU << 12); // Dao trang thai 4 LED
        delay_ms(500);
    }
}
```

== Kết quả & Nhận xét
#alert-box(kind: "success", title: "Kết quả đo lường")[
  - Đèn LED nhấp nháy đồng bộ với chu kỳ đo được trên máy hiện sóng $T = 1.002"s"$.
  - Mức logic cao đo được tại chân vi điều khiển là $3.28"V"$, đáp ứng chuẩn logic TTL/CMOS của STM32F4.
]
