#lang pollen

◊(require pollen/cache)
◊(require racket/string)

◊(define (sort-by-published paths)
  (sort paths
        (λ (x y)
          (let ([xdate (select 'published (cached-metas x))]
                [ydate (select 'published (cached-metas y))])
            (string>? xdate ydate)))))

◊(define post-links
  (map (λ (path)
    (let ([meta-data (cached-metas path)])
         (link (string-trim path ".pm")
               (format "~a ~a"
                 (select 'published meta-data)
                 (select 'title meta-data)))))
    
    (sort-by-published
      (filter (λ (x) (string-suffix? x ".html.pm"))
        (map (λ (path) (format "./posts/~a" (path->string path))) (directory-list "./posts"))))))

◊ul{◊post-links}
◊h3{Writings by Jay Butera}
