library(hexSticker)
#remotes::install_github("GuangchuangYu/hexSticker")
imgurl <- system.file("figures/titel-slide-img.png", package="fml")
sticker(imgurl, package="fml", p_size=20, s_x=1, s_y=.75, s_width=.6,
          +         filename="inst/figures/imgfile.png")
