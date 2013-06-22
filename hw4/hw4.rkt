
#lang racket

(provide (all-defined-out)) ;; so we can put tests in a second file

;; put your code below

; sequence produces a list of numbers from low to high (including
; low and possibly high) separated by stride and in sorted order.
(define (sequence low high stride)
  (letrec ([f (lambda (num) (if (> num high) null (cons num (f (+ num stride)))))])
    (f low)))

; string-append-map that takes a list of strings xs and a string suffix and returns a
; list of strings. Each element of the output should be the corresponding element of the input appended
; with suffix (with no extra space between the element and suffix).
(define (string-append-map xs suffix)
  (map (lambda (i) (string-append i suffix)) xs))

; list-nth-mod that takes a list xs and a number n. 
; If the number is negative, terminate the computation with (error "list-nth-mod: negative number"). 
; Else if the list is empty, terminate the computation with (error "list-nth-mod: empty list"). 
; Else return the ith element of the list where we count from zero and i is the remainder produced when 
; dividing n by the length of the list
; Library functions length, remainder, car, and list-tail
(define (list-nth-mod xs n)
  (cond [(< n 0) (error "list-nth-mod: negative number")]
        [(null? xs) (error "list-nth-mod: empty list")]
        [#t (car (list-tail xs (remainder n (length xs))))]))

; stream-for-n-steps that takes a stream s and a number n. It returns a list holding
; the first n values produced by s in order.
(define (stream-for-n-steps s n)
  (letrec ([f (lambda (stream acc counter)
                (if (< counter n)
                    (let ([pr (stream)])
                      (f (cdr pr) (append acc (list (car pr))) (+ counter 1)))
                    acc))])
    (f s null 0)))
    
; funny-number-stream that is like the stream of natural numbers (i.e., 1, 2, 3, ...)
; except numbers divisble by 5 are negated (i.e., 1, 2, 3, 4, -5, 6, 7, 8, 9, -10, 11, ...).
(define funny-number-stream
  (letrec ([f (lambda (x) (if (= 0 (remainder x 5)) 
                              (cons (* x -1) (lambda () (f (+ x 1))))
                              (cons x (lambda () (f (+ x 1))))))])
    (lambda () (f 1))))

; dan-then-dog, where the elements of the stream alternate between the strings "dan.jpg"
; and "dog.jpg" (starting with "dan.jpg")
(define dan-then-dog
  (letrec ([f (lambda (x) (if (equal? "dan.jpg" x)
                              (cons "dog.jpg" (lambda () (f "dog.jpg")))
                              (cons "dan.jpg" (lambda () (f "dan.jpg")))))])
    (lambda () (f "dog.jpg"))))

; stream-add-zero that takes a stream s and returns another stream. If s would
; produce v for its ith element, then (stream-add-zero s) would produce the pair (0 . v) for its ith
; element
(define (stream-add-zero s)
  (letrec ([f (lambda (x) (let ([pr (x)])
                            (cons (cons 0 (car pr)) (lambda () (f (cdr pr))))))])
    (lambda () (f s))))

; cycle-lists that takes two lists xs and ys and returns a stream. The lists may or
; may not be the same length, but assume they are both non-empty. The elements produced by the
; stream are pairs where the first part is from xs and the second part is from ys. The stream cycles
; forever through the lists. For example, if xs is ’(1 2 3) and ys is ’("a" "b"), then the stream
; would produce, (1 . "a"), (2 . "b"), (3 . "a"), (1 . "b"), (2 . "a"), (3 . "b"), (1 . "a"),
; (2 . "b")
(define (cycle-lists xs ys)
  (letrec ([ f (lambda (n) (cons 
                            (cons (list-nth-mod xs n) (list-nth-mod ys n))
                            (lambda () (f (+ n 1)))))])
    (lambda () (f 0))))

; vector-assoc that takes a value v and a vector vec. Return #f if no vector element is a pair with 
; a car field equal to v, else return the first pair with an equal car field. 
(define (vector-assoc v vec)
  (letrec ([lenvec (vector-length vec)]
           [ f (lambda (n) 
                   (if (< n lenvec) ; if n is less than the end of the vector then
                       (let ([pr (vector-ref vec n)]) ;get the pair, return true if it is a pair and the first element = v
                        (cond [(and (pair? pr) (equal? (car pr) v)) pr] 
                               [#t (f (+ n 1))])) ;otherwise it's either not a pair or the first element != v
                       #f))])
    (f 0)))

; cached-assoc that takes a list xs and a cache size n and returns a function that takes
; one argument v and returns the same thing that (assoc v xs) would return. 
; it caches the output of previous calls.
(define (cached-assoc xs n)
  (let ([my-cache (make-vector n #f)]
        [pos 0])
    (lambda (v)
      (let ([pr (vector-assoc v my-cache)])
        (if pr 
            pr ; if vector-assoc returned a pair then return that
            (let ([ans (assoc v xs)]) ; otherwise get run assoc
              (if ans ; if assoc returned a pair then put that in our vector and update pos
                   (begin [vector-set! my-cache pos ans] ; cache the results
                          [set! pos (remainder (+ pos 1) n)] ; some modular arithmetic to set pos
                          ans)
                  ans)))))))

; while-less is a macro that loops while the return of the body is
; less than init. used with while-less e1 do e2
(define-syntax while-less
  (syntax-rules (do)
    [(while-less init do body)
     (let ([i init])
       (letrec ([loop (lambda (it)
                        (if (< it i)
                            (loop body)
                            #t))])
         (loop body)))]))
