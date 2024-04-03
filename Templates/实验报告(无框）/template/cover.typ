#import "../utils/style.typ":*
#import "../utils/utils.typ":*
#import "../config/thesisInfo.typ":*
#set page(footer: none)

#counter(page).update(0)

  #let info_value(body) = {
    rect(
      width: 100%,
      inset: 2pt,
      stroke: (
        bottom: 1pt + black
      ),
      text(
        font: 字体.宋体,
        size: 字号.小二,
        weight: "medium",
        bottom-edge: "descender"
      )[
        #body
      ]
    ) 
  }
  
  #let info_key(body) = {
    rect(width: 100%, inset: 2pt, 
      stroke: none,
      text(
      font: 字体.黑体,
      size: 字号.小二,
      weight: "bold",
      overhang: false,
      body
    ))
  }

#align(center)[
  #v(40pt)
  #image("../imgs/jishoulogo_black.png",width:70%)
  #v(20pt)
  #table(
    columns: (auto),
    rows: (auto, auto ,auto),
    stroke: none,
    gutter: 9pt,
    text(
      font: 字体.宋体,
      size:  1.7cm,
      weight: "bold",
      tracking: 5pt
    )[Java Web 开发],
    text(
      font: 字体.宋体,
      size:  1.7cm,
      weight: "bold",
      tracking: 5pt
    )[实验报告]
  ),
    #grid(
    columns: (80pt, 250pt),
    rows : (35pt, 35pt),
    //gutter: 3pt,
    // row : (auto ,auto, auto, auto, auto, auto),
    info_key("题　　目"),
    info_value("实验"+zhnumbers(experimentId) +" "+experimentName),
    info_key("姓　　名"),
    info_value(name),
    info_key("学　　号"),
    info_value(stuId),
    info_key("专业年级"),
    info_value(majorGrade),
    info_key("指导老师"),
    info_value(guideTeacher),
    info_key("完成时间"),   
    info_value(finishTime),
  )
]