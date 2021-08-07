#lang pollen

◊(require racket/string)

◊(define post-links
  (map (λ (filename)
         (link (format "./posts/~a" (string-trim filename ".pm"))
               (string-trim filename ".html.pm")))
    (filter (λ (x) (string-suffix? x ".html.pm"))
      (map path->string (directory-list "./posts")))))

◊p{Writings by Jay Butera}
◊ul{◊post-links}
