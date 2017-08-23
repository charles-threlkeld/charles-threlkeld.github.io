#lang racket/base
(require racket/date
         txexpr
         pollen/setup
         pollen/decode
         pollen/misc/tutorial
         racket/list)
(provide (all-defined-out))

(module setup racket/base
  (provide (all-defined-out))
  (define poly-targets '(html tex)))

(define (root . elements)
  (txexpr 'root empty (decode-elements elements
                                       #:txexpr-elements-proc decode-paragraphs
                                       #:string-proc (compose1 smart-quotes smart-dashes))))

(define latex
  (case (current-poly-target)
    [(tex) "\\LaTeX"]
    [else "LaTeX"]))

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

(define (contact . elements)
  (case (current-poly-target)
    [(tex) (apply string-append `("\\begin{minipage}[t]{0.5\\textwidth}\n"
                                  "\\vspace{0pt}\n\n"
                                  "\\colorbox{shade}{\\textcolor{text1}{\n"
                                  "\\begin{tabular}{c|p{7cm}}\n"
                                  ,@elements
                                  "\\end{tabular}}}\\\\[10pt]"))]
    [else (txexpr 'contact empty elements)]))
     
(define (address . elements)
  (case (current-poly-target)
    [(tex) (apply string-append `("\\raisebox{-4pt}{\\textifsymbol{18}} & "
                                  ,@elements
                                  " \\\\"))]
    [else ""]))
;   [else (txexpr 'address empty elements)]))

(define (telephone . elements)
  (case (current-poly-target)
    [(tex) (apply string-append `("\\raisebox{-3pt}{\\Mobilefone} & "
                                  ,@elements
                                  " \\\\"))]
    [else ""]))
;   [else (txexpr 'telephone empty elements)]))

(define (email . elements)
  (case (current-poly-target)
    [(tex) (apply string-append `("\\raisebox{-1pt}{\\Letter} & \\href{mailto:"
                                  ,@elements
                                  "}{"
                                  ,@elements
                                  "} \\\\"))]
    [else (let ([email-to (string-append "mailto:" (first elements))])
            (txexpr 'a `((href ,email-to)) elements))]))

(define (website . elements)
  (case (current-poly-target)
    [(tex) (apply string-append `("\\Keyboard & \\href{"
                                  ,@elements
                                  "}{"
                                  ,@elements
                                  "} \\\\\n"))]
    [else (txexpr 'a `((href ,@elements)) elements)]))

(define (education . elements)
  (case (current-poly-target)
    [(tex) (apply string-append `("\\section{Education}\n"
                                  "\\begin{tabular}{rl}\n"
                                  ,@elements
                                  "\\end{tabular}\\\\[10pt]\n"))]
    [else (txexpr 'education empty
                  (cons (txexpr 'h3 empty '("Education")) elements))]))
                                  
(define (edu-dates . elements)
  (case (current-poly-target)
    [(tex) (apply string-append `(""
                                  ,@elements))]
    [else (txexpr 'strong empty elements)]))

(define (edu-pursuit . elements)
  (case (current-poly-target)
    [(tex) (apply string-append `(" & \\textbf{"
                                  ,@elements
                                  "} \\\\"))]
    [else (txexpr 'em empty
                  (cons (txexpr 'br empty '()) elements))]))

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
                                  "}\\\\\n"))]
    [else (txexpr 'em empty elements)]))

(define (computer-skills . elements)
  (case (current-poly-target)
    [(tex) (apply string-append `("\\section{Computer Skills}"
                                  "\\begin{tabularx}{\\textwidth}{rX}\n"
                                  ,@elements
                                  "\\end{tabularx}\\\\[10pt]\n"))]
    [else (txexpr 'computer-skills empty
                  (cons (txexpr 'h3 empty `("Computer Skills")) elements))]))

(define (basic-skills . elements)
  (case (current-poly-target)
    [(tex) (apply string-append `("Basic Knowledge & "
                                  ,@elements
                                  "\\\\\n"))]
    [else (txexpr 'basic-skills empty
                  (cons (txexpr 'skill-level empty '("Basic: ")) elements))]))

(define (intermediate-skills . elements)
  (case (current-poly-target)
    [(tex) (apply string-append `("Intermediate Knowledge & "
                                  ,@elements
                                  "\\\\\n"))]
    [else (txexpr 'basic-skills empty
                  (cons (txexpr 'skill-level empty '("Intermediate: ")) elements))]))

(define (advanced-skills . elements)
  (case (current-poly-target)
    [(tex) (apply string-append `("Advanced Knowledge & "
                                  ,@elements
                                  "\\\\\n"))]
    [else (txexpr 'basic-skills empty
                  (cons (txexpr 'skill-level empty '("Advanced: ")) elements))]))

(define (projects . elements)
  (case (current-poly-target)
    [(tex) (apply string-append `("\\section{Projects}\n"
                                  "\\begin{itemize}\n"
                                  ,@elements
                                  "\\end{itemize}\n"
                                  "\\end{minipage}\n"))]
    [else (txexpr 'projects empty
                  (cons (txexpr 'h3 empty `("Projects")) elements))]))

(define (work-experience . elements)
  (case (current-poly-target)
    [(tex) (apply string-append `("\\begin{minipage}[t]{0.44\\textwidth}\n"
                                  "\\vspace{0pt}\n"
                                  "\\section{Work Experience}\n"
                                  ,@elements
                                  "\\end{minipage}\n"))]
    [else (txexpr 'work-experience empty
                  (cons (txexpr 'h3 empty `("Work Experience")) elements))]))

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
    [(tex) (apply string-append `("\\normalsize{\\begin{itemize}\n"
                                  ,@elements
                                  "\\end{itemize}}\n"))]
    [else (txexpr 'ul empty elements)]))

(define (title . elements)
  (case (current-poly-target)
    [(tex) (apply string-append `("\\textit{" ,@elements "}"))]
    [else (txexpr 'titl empty elements)]))

(define (item . elements)
  (case (current-poly-target)
    [(tex) (apply string-append `("\\item "
                                  ,@elements
                                  "\n"))]
    [else (txexpr 'li empty elements)]))

(define (item-name . elements)
  (case (current-poly-target)
    [(tex) (apply string-append `("\\textbf{"
                                  ,@elements
                                  "}"))]
    [else (txexpr 'item-name empty elements)]))

(define tm
  (case (current-poly-target)
    [(tex) "\\texttrademark "]
    [else (txexpr 'sup empty '("TM"))]))
