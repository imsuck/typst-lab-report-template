#import "/metadata.typ": *

= Danh sách kiểm tra đầu buổi & cuối buổi <sec:start-checklist>

#checklist-table(
  title: [1. Kiểm tra chuẩn bị đầu buổi (Pre-lab)],
  items: (
    (task: [Đọc tài liệu hướng dẫn thí nghiệm và tài liệu tham khảo]),
    (task: [Trả lời đầy đủ các câu hỏi chuẩn bị trong Bài chuẩn bị 1 & 2]),
    (task: [Vẽ sơ đồ nguyên lý mạch kết nối GPIO và LED/Button]),
    (task: [Viết trước khung mã nguồn khởi tạo xung clock và thanh ghi]),
  ),
) <checklist-1>

#v(1em)

#checklist-table(
  signature: true,
  title: [2. Nghiệm thu & bàn giao cuối buổi (Post-lab)],
  items: (
    (
      task: [Demo chương trình chạy thực tế trên kit cho Giảng viên xem],
      status: [X],
      note: [Đạt 10/10],
    ),
    (
      task: [Lưu số liệu đo dao động ký & hình chụp dạng sóng],
      status: [X],
      note: [Đã lưu USB],
    ),
    (
      task: [Tắt nguồn kit thí nghiệm, máy hiện sóng và nguồn DC],
      status: [X],
      note: [Đã kiểm tra],
    ),
    (task: [Vệ sinh vị trí thực hành, thu dọn dây đo và bàn giao thiết bị]),
  ),
)
