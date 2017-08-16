#lang racket/base
(require racket/date txexpr pollen/setup pollen/decode pollen/misc/tutorial)
(provide (all-defined-out))

(module setup racket/base
  (provide (all-defined-out))
  (define poly-targets '(html tex)))

(define (root . elements)
  (txexpr 'root empty (decode-elements elements
                                       #:txexpr-elements-proc decode-paragraphs
                                       #:string-proc (compose1 smart-quotes smart-dashes))))
           
(define (get-date)
  (date->string (current-date)))

(define (author . elements)
  (case (current-poly-target)
    [(tex) (apply string-append `("\\par{\\centering{\\sffamily\\Huge "
                                  ,@elements
                                  "}\\\\"))]
    [else (txexpr 'h2 empty elements)]))

(define (doc-type . elements)
  (case (current-poly-target)
    [(tex) (apply string-append `("{\\color{headings}\\fontspec[Variant = 2]{Charter}"
                                  ,@elements
                                  "}\\\\[15pt]\\par}"))]
    [else (txexpr 'h4 empty elements)]))

(define (emph . elements)
  (case (current-poly-target)
    [(tex) (apply string-append `("{\\bf " ,@elements "}"))]
    [else (txexpr 'em empty elements)]))

(define (section . elements)
  (if (equal? elements '("Work Experience"))
      (case (current-poly-target)
        [(tex) (apply string-append `("\\begin{minipage}[t]{0.5\\textwidth}\n"
                                      "\\vspace{0pt}\n"
                                      "\\section{" ,@elements "}\n"))]
        [else (txexpr 'h3 empty elements)])
      (case (current-poly-target)
        [(tex) (apply string-append `("\\section{" ,@elements "}\n"))]
        [else (txexpr 'h3 empty elements)])))

(define (job-dates . elements)
  (case (current-poly-target)
    [(tex) (apply string-append `("{\\raggedleft\\textsc{" ,@elements "}\\par}"))]
    [else (txexpr 'em empty elements)]))

(define (job-title . elements)
  (case (current-poly-target)
    [(tex) (apply string-append `("{\\raggedright\\large " ,@elements "\\\\"))]
    [else (txexpr 'strong empty elements)]))

(define (company . elements)
  (case (current-poly-target)
    [(tex) (apply string-append `("\\textit{" ,@elements "}\\\\[5pt]}"))]
    [else (txexpr 'em empty elements)]))

(define (job-desc . elements)
  (case (current-poly-target)
    [(tex) (apply string-append `("\\normalsize{"
                                  ,@elements
                                  "}\\\\\n"))]
    [else (txexpr 'strong empty elements)]))

(define (address . elements)
  (case (current-poly-target)
    [(tex) (apply string-append `("\\end{minipage}\n"
                                  "\\hfill\n"
                                  "\\begin{minipage}[t]{0.44\\textwidth}\n"
                                  "\\vspace{0pt}\n\n"
                                  "\\colorbox{shade}{\\textcolor{text1}{\n"
                                  "\\begin{tabular}{c|p{7cm}}\n"
                                  "\\raisebox{-4pt}{\\textifsymbol{18}} & "
                                  ,@elements
                                  " \\\\"))]
    [else (txexpr 'strong empty elements)]))

(define (telephone . elements)
  (case (current-poly-target)
    [(tex) (apply string-append `("\\raisebox{-3pt}{\\Mobilefone} & "
                                  ,@elements
                                  " \\\\"))]
    [else (txexpr 'em empty elements)]))

(define (email . elements)
  (case (current-poly-target)
    [(tex) (apply string-append `("\\raisebox{-1pt}{\\Letter} & \\href{mailto:"
                                  ,@elements
                                  "}{"
                                  ,@elements
                                  "} \\\\"))]
    [else (txexpr 'strong empty elements)]))

(define (website . elements)
  (case (current-poly-target)
    [(tex) (apply string-append `("\\Keyboard & \\href{"
                                  ,@elements
                                  "}{"
                                  ,@elements
                                  "} \\\\\n"
                                  "\\end{tabular}}}\\\\[10pt]"))]
    [else (txexpr 'em empty elements)]))

(define (edu-dates . elements)
  (case (current-poly-target)
    [(tex) (apply string-append `("\\begin{tabular}{rl}\n"
                                  ,@elements))]
    [else (txexpr 'strong empty elements)]))

(define (edu-pursuit . elements)
  (case (current-poly-target)
    [(tex) (apply string-append `(" & \\textbf{"
                                  ,@elements
                                  "} \\\\"))]
    [else (txexpr 'em empty elements)]))

(define (edu-focus . elements)
  (case (current-poly-target)
    [(tex) (apply string-append `(" & \\textsc{"
                                  ,@elements
                                  "} \\\\"))]
    [else (txexpr 'strong empty elements)]))

(define (edu-name . elements)
  (case (current-poly-target)
    [(tex) (apply string-append `(" & \\textit{"
                                  ,@elements
                                  "}\\\\\n"
                                  "\\end{tabular}\\\\[10pt]"))]
    [else (txexpr 'em empty elements)]))
           
    
