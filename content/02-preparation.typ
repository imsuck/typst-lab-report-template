#import "../metadata.typ": *

= Phần chuẩn bị trước thí nghiệm (Preparation) <sec:prep>

== Khảo sát cấu trúc thanh ghi GPIO vi điều khiển STM32F4
Theo tài liệu @stm32ref, mỗi cổng GPIO gồm có các thanh ghi chính:
- `MODER`: Thanh ghi cấu hình chế độ (Input, Output, Alternate Function, Analog).
- `OTYPER`: Thanh ghi xác định kiểu ngõ ra (Push-Pull hoặc Open-Drain).
- `OSPEEDR`: Thanh ghi cấu hình tốc độ đáp ứng ngõ ra (Low, Medium, High, Very High).
- `PUPDR`: Thanh ghi điện trở kéo lên / kéo xuống (No Pull, Pull-Up, Pull-Down).
- `IDR` & `ODR`: Thanh ghi dữ liệu ngõ vào và ngõ ra.

#v(0.5em)

#question-box(
  1,
  [Tại sao cần phải kích hoạt xung nhịp (Clock Enable) trên bus AHB1 trước khi cấu hình thanh ghi GPIO?],
  solution: [Để tiết kiệm năng lượng, kiến trúc ARM Cortex-M (@armcortex) mặc định tắt clock của các ngoại vi khi khởi động. Nếu không bật bit tương ứng trong thanh ghi RCC_AHB1ENR, các thanh ghi GPIO sẽ không được cấp xung nhịp hoạt động và các thao tác ghi giá trị vào thanh ghi sẽ không có hiệu lực.],
)

#v(0.5em)

#question-box(
  2,
  [Phân biệt cấu hình Push-Pull và Open-Drain trong chế độ Output?],
  solution: [Chế độ Push-pull có thể chủ động kéo mức áp lên cao ($V_"DD"$) hoặc kéo xuống thấp ($V_"SS"$) thông qua cặp transistor P-MOS và N-MOS. Chế độ Open-drain chỉ chủ động kéo xuống thấp (N-MOS dẫn), còn khi xuất mức 1 thì ngõ ra thả nổi (high impedance) và cần có điện trở kéo ngoài (pull-up resistor) để kéo lên mức cao.],
)
