#import "../utils/style.typ": *


#set page(footer: [
    #set align(center)
    #set text(size: 10pt, baseline: -3pt)
    #counter(page).display(
      "I",
    )
] )


// 目录
#v(1em)
#align(center)[
  #text(font: 字体.宋体, size: 字号.三号, "目    录")
]

#parbreak();

#show outline: it => {
  set text(font: 字体.宋体, size: 字号.小四)
  set par(leading: 1em )
  it
}
#outline(
  title: none,
  indent : true,
)