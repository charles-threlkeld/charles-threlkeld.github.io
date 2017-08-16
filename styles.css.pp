#lang pollen

◊(define inner 2)
◊(define edge (* inner 2))
◊(define color "grey")
◊(define multiplier 1.3)

@font-face{
    font-family: "Charter-Regular";
    src: url('charter_regular-webfont.ttf');
}

@font-face{
    font-family: "Charter-Bold";
    src: url('charter_bold-webfont.ttf');
}

@font-face{
    font-family: "Charter-Italic";
    src: url('charter_italic-webfont.ttf');
}

body {
    margin: ◊|edge|em;
    border: ◊|inner|em double ◊|color|;
    padding: ◊|inner|em;
    font-size: ◊|multiplier|em;
    line-height: ◊|multiplier|;
    font-family: "Charter-Regular";
}

em {
    font-family: "Charter-Italic";
}

b {
    font-family: "Charter-Bold";
}

h1 {
    font-size: ◊|multiplier|em;
}

#prev, #next {
    position: fixed;
    top: ◊|(/ edge 2)|em;
}

#prev {
    left: ◊|edge|em;
}

#next {
    right: ◊|edge|em;
}
