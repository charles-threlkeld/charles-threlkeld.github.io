#lang racket/base
(require txexpr
         pollen/setup
         pollen/decode
         pollen/misc/tutorial
         racket/list)
(provide (all-defined-out))

(module setup racket/base
  (provide (all-defined-out))
  (define poly-targets '(html tex pdf)))

(define (root . elements)
  (txexpr 'root empty (decode-elements elements
                                       #:txexpr-elements-proc decode-paragraphs
                                       #:string-proc (compose1 smart-quotes smart-dashes)
                                       #:exclude-tags '(tbody style script))))

(define latex
  (case (current-poly-target)
    [(tex pdf) "\\LaTeX"]
    [else "LaTeX"]))

(define (author . elements)
  (case (current-poly-target)
    [(tex pdf) (apply string-append `("\\par{\\centering{\\sffamily\\Huge "
                                  ,@elements
                                  "}\\\\"))]
    [else (txexpr 'h1 empty elements)]))

(define (doc-type . elements)
  (case (current-poly-target)
    [(tex pdf) (apply string-append `("{\\color{headings}\\fontspec[Variant = 2]{Charter}"
                                  ,@elements
                                  "}\\\\[15pt]\\par}"))]
    [else (txexpr 'h4 empty elements)]))

(define (contact . elements)
  (case (current-poly-target)
    [(tex pdf) (apply string-append `("\\colorbox{shade}{\\textcolor{text1}{\n"
                                  "\\begin{tabular}{c|p{7cm}}\n"
                                  ,@elements
                                  "\\end{tabular}}}\\\\[10pt]"))]
    [else (txexpr 'div '((id "contact")) elements)]))
     
(define (address . elements)
  (case (current-poly-target)
    [(tex pdf) (apply string-append `("\\raisebox{-4pt}{\\textifsymbol{18}} & "
                                  ,@elements
                                  " \\\\"))]
    [else ""]))
;   [else (txexpr 'address empty elements)]))

(define (telephone . elements)
  (case (current-poly-target)
    [(tex pdf) (apply string-append `("\\raisebox{-3pt}{\\Mobilefone} & "
                                  ,@elements
                                  " \\\\"))]
    [else ""]))
;   [else (txexpr 'telephone empty elements)]))

(define (email . elements)
  (case (current-poly-target)
    [(tex pdf) (apply string-append `("\\raisebox{-1pt}{\\Letter} & \\href{mailto:"
                                  ,@elements
                                  "}{"
                                  ,@elements
                                  "} \\\\"))]
    [else (let ([email-to (string-append "mailto:" (first elements))])
            (txexpr 'a `((href ,email-to)) elements))]))

(define (website . elements)
  (case (current-poly-target)
    [(tex pdf) (apply string-append `("\\Keyboard & \\href{"
                                  ,@elements
                                  "}{"
                                  ,@elements
                                  "} \\\\\n"))]
    [else (txexpr 'a `((href ,@elements)) elements)]))

(define (education . elements)
  (case (current-poly-target)
    [(tex pdf) (apply string-append `("\\section{Education}\n"
                                  "\\begin{tabular}{rl}\n"
                                  ,@elements
                                  "\\end{tabular}\\\\[10pt]\n"))]
    [else (txexpr 'div '((id "education"))
                  (cons (txexpr 'h2 empty '("Education")) elements))]))
                                  
(define (edu-dates . elements)
  (case (current-poly-target)
    [(tex pdf) (apply string-append `(""
                                  ,@elements))]
    [else (txexpr 'span '((class "edu-dates")) elements)]))

(define (edu-pursuit . elements)
  (case (current-poly-target)
    [(tex pdf) (apply string-append `(" & \\textbf{"
                                  ,@elements
                                  "} \\\\"))]
    [else (txexpr 'span '((class "edu-pursuit"))
                  (cons (txexpr 'br empty '()) elements))]))

(define (edu-focus . elements)
  (case (current-poly-target)
    [(tex pdf) (apply string-append `(" & \\textsc{"
                                  ,@elements
                                  "} \\\\"))]
    [else (txexpr 'span '((class "edu-focus")) elements)]))

(define (edu-name . elements)
  (case (current-poly-target)
    [(tex pdf) (apply string-append `(" & \\textit{"
                                  ,@elements
                                  "}\\\\\n"))]
    [else (txexpr 'span '((class "edu-name")) elements)]))

(define (computer-skills . elements)
  (case (current-poly-target)
    [(tex pdf) (apply string-append `("\\section{Computer Skills}"
                                  "\\begin{tabularx}{\\textwidth}{rX}\n"
                                  ,@elements
                                  "\\end{tabularx}\\\\[10pt]\n"))]
    [else (txexpr 'div '((id "computer-skills"))
                  (cons '(h2 "Computer Skills")
                        `((table (tbody ,@elements)))))]))

(define (basic-skills . elements)
  (case (current-poly-target)
    [(tex pdf) (apply string-append `("Basic Knowledge & "
                                  ,@elements
                                  "\\\\\n"))]
    [else (txexpr 'tr '((id "basic-skills"))
                  (cons '(td "Basic: ")
                        `((td ,@elements))))]))

(define (intermediate-skills . elements)
  (case (current-poly-target)
    [(tex pdf) (apply string-append `("Intermediate Knowledge & "
                                  ,@elements
                                  "\\\\\n"))]
    [else (txexpr 'tr '((id "intermediate-skills"))
                  (cons '(td "Intermediate: ")
                        `((td ,@elements))))]))

(define (advanced-skills . elements)
  (case (current-poly-target)
    [(tex pdf) (apply string-append `("Advanced Knowledge & "
                                  ,@elements
                                  "\\\\\n"))]
    [else (txexpr 'tr '((id "advanced-skills"))
                  (cons '(td "Advanced: ")
                        `((td ,@elements))))]))

(define (projects . elements)
  (case (current-poly-target)
    [(tex pdf) (apply string-append `("\\section{Projects}\n"
                                  "\\begin{itemize}\n"
                                  ,@elements
                                  "\\end{itemize}\n"))]
    [else (txexpr 'div '((id "projects"))
                  (cons (txexpr 'h2 empty `("Projects")) elements))]))

(define (work-experience . elements)
  (case (current-poly-target)
    [(tex pdf) (apply string-append `("\\section{Work Experience}\n"
                                  ,@elements))]
    [else (txexpr 'div '((id "work-experience"))
                  (cons (txexpr 'h2 empty `("Work Experience")) elements))]))

(define (job-dates . elements)
  (case (current-poly-target)
    [(tex pdf) (apply string-append `("{\\raggedleft\\textsc{" ,@elements "}\\par}"))]
    [else (txexpr 'div '((class "job-dates")) elements)]))

(define (job-title . elements)
  (case (current-poly-target)
    [(tex pdf) (apply string-append `("{\\raggedright\\large " ,@elements "\\\\"))]
    [else (txexpr 'div '((class "job-title")) elements)]))

(define (company . elements)
  (case (current-poly-target)
    [(tex pdf) (apply string-append `("\\textit{" ,@elements "}\\\\[5pt]}"))]
    [else (txexpr 'div '((class "company")) elements)]))

(define (job-desc . elements)
  (case (current-poly-target)
    [(tex pdf) (apply string-append `("\\normalsize{\\begin{itemize}\n"
                                  ,@elements
                                  "\\end{itemize}}\n"))]
    [else (txexpr 'ul empty elements)]))

(define (title . elements)
  (case (current-poly-target)
    [(tex pdf) (apply string-append `("\\textit{" ,@elements "}"))]
    [else (txexpr 'span '((class "title")) elements)]))

(define (item . elements)
  (case (current-poly-target)
    [(tex pdf) (apply string-append `("\\item "
                                  ,@elements
                                  "\n"))]
    [else (txexpr 'li empty elements)]))

(define (item-name . elements)
  (case (current-poly-target)
    [(tex pdf) (apply string-append `("\\textbf{"
                                  ,@elements
                                  "}"))]
    [else (txexpr 'span '((class "item-name")) elements)]))

(define (hobbies . elements)
  (case (current-poly-target)
    [(tex pdf) (apply string-append `("\\section{Hobbies}\n"
                                      "\\begin{itemize}\n"
                                      ,@elements
                                      "\\end{itemize}\n"))]
    [else (txexpr 'div '((id "hobbies"))
                  (cons (txexpr 'h2 empty `("Hobbies")) elements))]))

(define (hobby-name . elements)
  (case (current-poly-target)
    [(tex pdf) (apply string-append `("\\textbf{"
                                      ,@elements
                                      "}"))]
    [else (txexpr 'span '((class "hobby-name")) elements)]))

(define (hobby-description . elements)
  (case (current-poly-target)
    [(tex pdf) (apply string-append `("\\item "
                                      ,@elements
                                      "\n"))]
    [else (txexpr 'li empty elements)]))

(define tm
  (case (current-poly-target)
    [(tex pdf) "\\texttrademark\\space  "]
    [else (txexpr 'sup empty '("TM"))]))

(define begin-first-column
  (case (current-poly-target)
    [(tex pdf) "\\begin{minipage}[t]{0.5\\textwidth}\n\\vspace{0pt}\n\n"]
    [else ""]))

(define end-column
  (case (current-poly-target)
    [(tex pdf) "\\end{minipage}\n"]
    [else ""]))

(define begin-second-column
  (case (current-poly-target)
    [(tex pdf) "\\qquad\\begin{minipage}[t]{0.38\\textwidth}\n\\vspace{0pt}\n\n"]
    [else ""]))
                                  
