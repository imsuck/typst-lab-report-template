typst compile main.typ report.pdf
sed -i 's/monochrome: false/monochrome: true/' metadata.typ
typst compile main.typ report-monochrome.pdf
sed -i 's/monochrome: true/monochrome: false/' metadata.typ
