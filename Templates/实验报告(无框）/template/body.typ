#import "../utils/style.typ": *
#import "../utils/utils.typ": *
#import "../config/thesisInfo.typ": *
#import "@preview/cuti:0.2.0": show-cn-fakebold
#show: show-cn-fakebold
#pagebreak()
#set page(numbering: "1")
#counter(page).update(1)

// 章节计数器，记录公式层级
// -----------------
// 2023/4/11 update log：
//  - 增加计数器，把元素序号转为 `x.x` 的格式
#let counter_chapter   = counter("chapter")
#let counter_equation  = counter(math.equation)
#let counter_image     = counter(figure.where(kind: image))
#let counter_table     = counter(figure.where(kind: table))

// 图片和表的格式
// -----------------
// 2023/4/11 update log：
//  - 把元素序号转为 `x.x` 的格式
#show figure: it => [
    #set text(font_size.wuhao)
    #set align(center)

    #if not it.has("kind") {
      it
    } else if it.kind == image {
      it.body
      [
        #textbf("图")
        #locate(loc => {
          [#counter_chapter.at(loc).first().#counter_image.at(loc).first()]
        })
        #it.caption
      ]
    } else if it.kind == table {
      [
        #textbf("表")
        #locate(loc => {
          [#counter_chapter.at(loc).first().#counter_table.at(loc).first()]
        })
        #it.caption
      ]
      it.body
    } else {
      it.body
    }
  ]

// 设置公式格式
// -----------------
// 2023/4/11 update log：
//  - 修复为章节号 + 公示编号
#set math.equation(
  numbering: (..nums) => locate( loc => {
      numbering("(1.1)", counter_chapter.at(loc).first(), ..nums)
  })
)

// 设置引用格式
// -----------------
// 2023/4/11 update log：
//  - 原本对公式的引用是 `Equation (x.x)`，改为 `式x.x`
#show ref: it => {
  locate(loc => {
  let elems = query(it.target, loc)

  if elems == () {
    it
  } else {
    let elem = elems.first()
    let elem_loc = elem.location()

    if numbering != none {
      if elem.func() == math.equation {
        link(elem_loc, [#textbf("式")
          #counter_chapter.at(elem_loc).first().#counter_equation.at(elem_loc).first()
        ])
      } else if elem.func() == figure{
        if elem.kind == image {
          link(elem_loc, [#textbf("图")
            #counter_chapter.at(elem_loc).first().#counter_image.at(elem_loc).first()
          ])
        } else if elem.kind == table {
          link(elem_loc, [#textbf("表")
            #counter_chapter.at(elem_loc).first().#counter_table.at(elem_loc).first()
          ])
        }
      }
    } else {
      it
    }
  }
})
}

#set heading(numbering: (..nums) => 
                          if nums.pos().len() == 1 {
                            zhnumbers(nums.pos().first()) +"、"
                          } 
                          else {
                            nums.pos().map(str).join(".")
                          })

#show heading: it =>  {
  if it.level == 1 {
    // set align(center)
    set text(font:字体.黑体, size: 字号.小四, weight: "bold")
    counter_chapter.step()
    counter_equation.update(())
    counter_image.update(())
    counter_table.update(())
    it
  } else if it.level == 2 {
    set text(font:字体.黑体, size: 字号.小四, weight: "bold")
    it
    par(leading: 1.5em)[#text(size:0.0em)[#h(0.0em)]]
  } else if it.level == 3 {
    set text(font:heiti, size: font_size.xiaosi, weight: "regular")
    it
    par(leading: 1.5em)[#text(size:0.0em)[#h(0.0em)]]
  }
}

// 设置正文格式
#set text(font: 字体.宋体, size: 字号.小四)
#set par(justify: false, leading: 1.5em, first-line-indent: 2em)
#show par: it => {
  it 
  v(5pt)
}


#let title(titles) = {
  set align(center)
  text(font:字体.黑体, size: 字号.小二, weight: "regular",titles)
}

#title("实验"+zhnumbers(experimentId)+"   "+experimentName)



#include "../contents/context.typ"  

