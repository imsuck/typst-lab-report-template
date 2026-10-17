#import "../metadata.typ": *

= Danh sách kiểm tra đánh giá tại lớp (In-Class Checklist)

#checklist-table(
  title: [Tiêu chí theo dõi thực hành trong buổi học],
  items: (
    (
      task: [Thao tác kết nối đúng sơ đồ chân mạch nạp ST-Link với board vi điều khiển],
      status: [Đạt],
      note: [GV đã kiểm tra],
    ),
    (
      task: [Biên dịch mã nguồn không phát sinh lỗi hoặc cảnh báo nghiêm trọng],
      status: [Đạt],
      note: [0 warning, 0 error],
    ),
    (
      task: [Nạp chương trình điều khiển nhấp nháy LED chạy đúng chu kỳ 1s],
      status: [Đạt],
      note: [Sai số < 1%],
    ),
    (
      task: [Đo đạc kiểm chứng tín hiệu xung bằng Dao động ký (Oscilloscope)],
      status: [Đạt],
      note: [Đã chụp màn hình sóng],
    ),
    (
      task: [Xử lý hiện tượng rung phím (Key Debounce) trên nút nhấn thành công],
      status: [Đạt],
      note: [Phản hồi tốt],
    ),
  ),
)

#add-chapter(
  after: <sec:prep>,
  before: <sec:exercise1>,
  minitoc-title: i18n("toc-title"),
)[
  === Idk

  Why do we need to question things?

  ==== To verify what we know and what we don't

  Lalalalala

  ==== To think critically about what we're doing

  Wow

  === Hello, World!

  The classic introduction to any programming language.

  ==== Another heading for testing
]
