(TeX-add-style-hook "technical_manual"
 (lambda ()
    (TeX-add-symbols
     '("tabincell" 2))
    (TeX-run-style-hooks
     "geometry"
     "float"
     "graphicx"
     "graphics"
     "bm"
     "amssymb"
     "amsmath"
     "fontspec"
     "latex2e"
     "art11"
     "article"
     "11pt"
     "a4paper")))

