#lang pollen

◊(define inner 2)
◊(define edge (* inner 2))
◊(define color "grey")
◊(define multiplier 1.3)

@font-face {
    font-family: "Charter";
    src: url('fonts/charter_regular-webfont.woff') format('woff'),
    url('fonts/charter_regular-webfont.ttf') format('truetype');
    font-weight: normal;
    font-style: normal;
}

@font-face {
    font-family: "Charter";
    src: url('fonts/charter_bold-webfont.woff') format('woff'),
    url('fonts/charter_bold-webfont.ttf') format('truetype');
    font-weight: bold;
    font-style: normal;
}

@font-face {
    font-family: "Charter";
    src: url('fonts/charter_italic-webfont.woff') format('woff'),
    url('fonts/charter_italic-webfont.ttf') format('truetype');
    font-weight: normal;
    font-style: italic;
}

@font-face {
    font-family: "Charter";
    src: url('fonts/charter_bold_italic-webfont.woff') format('woff'),
    url('fonts/charter_bold_italic-webfont.ttf') format('truetype');
    font-weight: bold;
    font-style: italic;
}

body {
    margin: ◊|edge|em;
    border: ◊|inner|em double ◊|color|;
    padding: ◊|inner|em;
    font-size: ◊|multiplier|em;
    line-height: ◊|multiplier|;
    font-family: "Charter";
    max-width: 50em;
    color: #555;
}

td {
    font-size: ◊|multiplier|em;
    font-family: "Charter";
    color: #555;
    font-weight: normal;
    text-align: left;
    margin: 20px auto;
}

table {
    width: 100%;
    margin: 20px auto;
    table-layout: auto;
    border-collapse: collapse;
}


sup {
    font-size: 0.4em;
}

titl {
    font-style: italic;
}

education {
    background-color: #eee;
}

h1, strong {
    color: #333;
}

h2 {
    color: #701112;
}

h4 {
    color: #701112;
}

li {
    margin-bottom: 0.2em;
    padding-bottom: 0.2em;
}

item-name {
    font-weight: bold;
    color: #333;
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
