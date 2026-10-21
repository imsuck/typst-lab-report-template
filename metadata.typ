#import "template/lib.typ": (
  add-chapter, alert-box, apply-styles, checklist-table, cover-page,
  grading-sheet, lab-report, minitoc, question-box,
)
#import "template/i18n.typ": create-i18n

#let metadata = (
  title: [Báo Cáo Thí Nghiệm Vi Xử Lý],
  subtitle: [Bài 1: Khảo sát tập lệnh và lập trình GPIO trên vi điều khiển STM32],
  school-name: [Đại học Quốc gia TP. Hồ Chí Minh \ Trường Đại học Bách Khoa],
  faculty-name: [Khoa Điện -- Điện Tử \ Bộ môn Kỹ thuật Máy tính -- Viễn thông],
  course-name: [Thí nghiệm Vi Xử Lý],
  course-code: "EE3051",
  class: "L01",
  group: "04",
  semester: "HK 242",
  academic-year: "2024 - 2025",
  location: "Phòng 304 B1, Cơ sở Lý Thường Kiệt",
  date: "17 Tháng 10, 2026",
  instructor: "TS. Nguyễn Văn Hướng",
  lang: "vi", // "en|vi"
  monochrome: false,
  draft: true,
  show-grading-sheet: true,
  show-toc: true,
  show-lof: true,
  show-lot: true,
  // Font configurations
  fonts: (
    body: ("Times New Roman", "STIX Two Text"),
    code: "Fira Code",
    heading: ("Times New Roman", "STIX Two Text"),
  ),
  members: (
    (name: "Nguyễn Văn An", id: "2110001", role: "Trưởng nhóm / Phần cứng"),
    (
      name: "Trần Thị Bình",
      id: "2110002",
      role: "Lập trình / Thu thập dữ liệu",
    ),
    (name: "Lê Hoàng Cường", id: "2110003", role: "Báo cáo / Xử lý kết quả"),
  ),
)

// Project-wide i18n instance configured with metadata's language
#let i18n = create-i18n(default-lang: metadata.at("lang", default: "vi"))
