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
      (p (link (string-trim path ".pm")
               (select 'title meta-data))
         (br)
         (format "~a"
              (select 'published meta-data)))))
    
    (sort-by-published
      (filter (λ (x) (string-suffix? x ".html.pm"))
        (map (λ (path) (format "./posts/~a" (path->string path))) (directory-list "./posts"))))))

◊ul{◊post-links}
