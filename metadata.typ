#import "template/lib.typ": *

#let my-school = (
  name: [Đại học Quốc gia TP. Hồ Chí Minh \ Trường Đại học Bách Khoa],
  faculty: [Khoa Điện -- Điện tử \ Bộ môn Kỹ thuật Máy tính -- Viễn thông],
  location: "TP. HCM",
  instructor: "TS. Nguyễn Văn Hướng",
  class: "L01",
  group: "04",
)

#let doc = (
  title: "Bài 1: Khảo sát tập lệnh và lập trình GPIO trên vi điều khiển STM32",
  subtitle: "Báo Cáo Thí Nghiệm Vi Xử Lý",
  date: "01/2021",
)

#let my-margin = (
  left: 2.5cm,
  right: 1.5cm,
  top: 1.5cm,
  bottom: 1.5cm,
)

#let configure() = config.update(conf => {
  conf.school = my-school
  conf.doc = doc

  conf.monochrome = false
  conf.margin = my-margin

  conf
})
