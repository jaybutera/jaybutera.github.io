#lang racket

(require pollen/decode txexpr)
;(require pollen/tag)
(provide root
         code-inline
         code-block
         ul
         epigraph
         link)

(define (root . elements)
   (txexpr 'root empty (decode-elements elements
     #:txexpr-elements-proc decode-paragraphs
     #:string-proc (compose1 smart-quotes smart-dashes))))

(define (code-block . elements)
  (txexpr 'code empty elements))

(define (code-inline . elements)
  (txexpr 'code empty elements))

(define (link a name)
  `(a ((href ,a)) ,name))

(define (ul elements)
  `(ul ,@(map (λ (x) `(li ,x)) elements)))

(define (epigraph txt)
  `(div ((class "epigraph"))
     (blockquote (p ,txt))))
