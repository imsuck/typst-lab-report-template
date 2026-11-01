#import "../metadata.typ": *

#show: show-appendix

= Mã nguồn mở rộng và Thư viện hỗ trợ <sec:appx-code>

Dưới đây là mã nguồn cài đặt thư viện phần cứng cơ bản cho vi điều khiển STM32F407VG trên kit STM32F4-Discovery, bao gồm định nghĩa các hàm trễ chuẩn xác và cấu hình xung nhịp hệ thống (System Clock).

== Cấu hình hệ thống xung nhịp 168 MHz (`system_clock.c`)

```c
#include "stm32f4xx.h"

void SystemClock_Config(void) {
    // 1. Bat HSE (High Speed External Clock 8MHz)
    RCC->CR |= RCC_CR_HSEON;
    while (!(RCC->CR & RCC_CR_HSERDY));

    // 2. Cau hinh Flash Latency (5 Wait States cho 168MHz tai 3.3V)
    FLASH->ACR |= FLASH_ACR_ICEN | FLASH_ACR_DCEN | FLASH_ACR_PRFTEN | FLASH_ACR_LATENCY_5WS;

    // 3. Cau hinh bo nhan PLL: PLL_M = 8, PLL_N = 336, PLL_P = 2, PLL_Q = 7
    RCC->PLLCFGR = (8 << 0) | (336 << 6) | (0 << 16) | (RCC_PLLCFGR_PLLSRC_HSE) | (7 << 24);

    // 4. Bat PLL va cho on dinh
    RCC->CR |= RCC_CR_PLLON;
    while (!(RCC->CR & RCC_CR_PLLRDY));

    // 5. Cau hinh Bus Prescalers (AHB = 1, APB1 = 4, APB2 = 2)
    RCC->CFGR |= RCC_CFGR_HPRE_DIV1;
    RCC->CFGR |= RCC_CFGR_PPRE1_DIV4;
    RCC->CFGR |= RCC_CFGR_PPRE2_DIV2;

    // 6. Chuyen System Clock sang PLL
    RCC->CFGR &= ~RCC_CFGR_SW;
    RCC->CFGR |= RCC_CFGR_SW_PLL;
    while ((RCC->CFGR & RCC_CFGR_SWS) != RCC_CFGR_SWS_PLL);
}
```

== Định nghĩa địa chỉ Base Register ngoại vi GPIO (`gpio_registers.h`)

#figure(
  table(
    columns: (1.2fr, 1.5fr, 1fr, 2.5fr),
    align: (center, center, center, left),
    [Ngoại vi], [Vùng nhớ Base Address], [Bus], [Mô tả chức năng],
    [`GPIOA`], [`0x4002 0000`], [AHB1], [Cổng I/O A (Nút nhấn PA0 User Button)],
    [`GPIOB`], [`0x4002 0400`], [AHB1], [Cổng I/O B],
    [`GPIOC`], [`0x4002 0800`], [AHB1], [Cổng I/O C],
    [`GPIOD`], [`0x4002 0C00`], [AHB1], [Cổng I/O D (Dãy 4 LED PD12--PD15)],
    [`GPIOE`], [`0x4002 1000`], [AHB1], [Cổng I/O E],
  ),
  caption: flex-caption[Bảng địa chỉ ánh xạ bộ nhớ các ngoại vi GPIO trên vi điều khiển STM32F407VG][],
) <tab:gpio-base-addr>

= Sơ đồ chân mở rộng và Thông số kỹ thuật Kit thí nghiệm <sec:appx-pinout>

#info(title: "Lưu ý điện áp tương thích")[
  - Đa số các chân GPIO của dòng STM32F4 có khả năng chịu áp 5V (5V tolerant, ký hiệu FT trong datasheet).
  - Riêng các chân có chức năng ngoại vi phụ hoặc ngõ vào bộ biến đổi ADC (như `PA0` ở chế độ Analog) chỉ chịu được điện áp tối đa $V_"DDA" + 0.3"V" approx 3.6"V"$. Tuyệt đối không cấp trực tiếp điện áp 5V vào các chân này khi đang ở cấu hình Analog.
]

#v(0.5em)

== Bảng tra cứu chế độ GPIO MODER

Mỗi pin $x$ (với $x in [0..15]$) trên cổng GPIO được điều khiển bởi 2 bit tương ứng `MODER[2x+1 : 2x]`:

#align(center)[
  #table(
    columns: (1.5fr, 1fr, 3fr),
    align: (center, center, left),
    [Giá trị bit `MODERy[1:0]`], [Chế độ], [Diễn giải hoạt động],
    [`00`], [Input], [Cổng ở trạng thái đọc mức logic ngõ vào số],
    [`01`], [Output], [Cổng xuất tín hiệu điều khiển (Push-Pull / Open-Drain)],
    [`10`], [Alternate Function], [Kết nối tới ngoại vi chuyên dụng (USART, SPI, I2C, TIM)],
    [`11`], [Analog], [Vô hiệu hóa bộ đệm số để tiết kiệm điện và kết nối với ADC/DAC],
  )
]
