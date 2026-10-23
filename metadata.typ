#import "template/lib.typ": *

#let my-school = (
  name: [Đại học Quốc gia TP. Hồ Chí Minh \ Trường Đại học Bách Khoa],
  faculty: [Khoa Điện -- Điện tử \ Bộ môn Kỹ thuật Máy tính -- Viễn thông],
  location: "TP. HCM",
  instructor: "TS. Nguyễn Văn Hưởng",
  class: "L01",
  group: "04",
  group-members: (
    (name: "Nguyễn Văn An", id: "2110001", role: "Trưởng nhóm / Phần cứng"),
    (
      name: "Trần Thị Bình",
      id: "2110002",
      role: "Lập trình / Thu thập dữ liệu",
    ),
    (name: "Lê Hoàng Cường", id: "2110003", role: "Báo cáo / Xử lý kết quả"),
  ),
)

#let doc = (
  title: "Bài 1: Khảo sát tập lệnh và lập trình GPIO trên vi điều khiển STM32",
  subtitle: "Báo Cáo Thí Nghiệm Vi Xử Lý",
  date: "01/2021",
)

#let doc-format = (
  draft: true,
  fancy-cover: false,
  margin: (
    left: 2.5cm,
    right: 1.5cm,
    top: 1.5cm,
    bottom: 1.5cm,
  ),
)

#let configure() = config.update(conf => {
  (
    ..conf,
    lang: "vi", // "en|vi"
    school: my-school,
    doc: doc,
    format: conf.format + doc-format,
  )
})

// you have to manually style the custom functions
#let checklist-table = checklist-table.with(signature: false)
