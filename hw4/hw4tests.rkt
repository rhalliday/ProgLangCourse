#lang racket

(require rackunit "hw4.rkt") 

;; the following are my rackunit tests although they are the rather 
;; boring check-equals ones

(check-equal? (sequence 3 11 2) '(3 5 7 9 11) "sequence returns last element")
(check-equal? (sequence 3 8 3) '(3 6) "sequence does not return last element")
(check-equal? (sequence 3 2 1) '() "sequence low higher than high no elements")

(check-equal? (string-append-map (list "sta" "evalua" "mastica") "tion") 
              '("station" "evaluation" "mastication")
              "string-append-map works on 3 element list")
(check-equal? (string-append-map (list "to" "for" "back" "up" "down") "wards")
              '("towards" "forwards" "backwards" "upwards" "downwards")
              "string-append-map works on 5 element list")

(check-equal? (list-nth-mod (list 1 2 3 4 5) 2) 3 "2 mod 5 is 2")
(check-equal? (list-nth-mod (list 1 2 3 4 5) 5) 1 "5 mod 5 is 0")
(check-equal? (list-nth-mod (list 1 2 3 4 5) 6) 2 "6 mod 5 is 1")
(check-equal? (list-nth-mod (list 1 2 3 4 5) 8) 4 "8 mod 5 is 3")
(check-exn exn:fail? (lambda () (list-nth-mod (list 1 2 3 4 5) -1)) "negative number raises error")
(check-exn exn:fail? (lambda () (list-nth-mod (null) 4)) "empty list raises error")
(define powers-of-two
  (letrec ([f (lambda (x) (cons x (lambda () (f (* x 2)))))])
    (lambda () (f 2))))
(check-equal? (stream-for-n-steps powers-of-two 4) '(2 4 8 16) "stream-for-n-steps returns first 4 elements of stream")
(check-equal? (stream-for-n-steps powers-of-two 0) '() "stream-for-n-steps returns empty list when passed 0")
(check-equal? (stream-for-n-steps funny-number-stream 11) '(1 2 3 4 -5 6 7 8 9 -10 11) "funny number negates the fifth")
(check-equal? (stream-for-n-steps dan-then-dog 5) '("dan.jpg" "dog.jpg" "dan.jpg" "dog.jpg" "dan.jpg") 
              "dan then dog returns array in right order")
(check-equal? (stream-for-n-steps (stream-add-zero dan-then-dog) 5)
              '((0 . "dan.jpg") (0 . "dog.jpg") (0 . "dan.jpg") (0 . "dog.jpg") (0 . "dan.jpg"))
              "stream-add-zero returns a 0, stream pair")
(check-equal? (stream-for-n-steps (cycle-lists (list 1 2 3) (list "a" "b")) 8)
              '((1 . "a") (2 . "b") (3 . "a") (1 . "b") (2 . "a") (3 . "b") (1 . "a") (2 . "b"))
              "stream-for-n-steps combines the two lists")

(check-equal? (vector-assoc 3 (vector (cons 1 2) (cons 4 5) (cons 3 4) (cons 5 6))) 
              '(3 . 4) 
              "vector-assoc returns found pair")
(check-equal? (vector-assoc 3 (vector (cons 1 2) (cons 4 5) (cons 3 4) (cons 5 6) (cons 3 7))) 
              '(3 . 4) 
              "vector-assoc returns first pair")
(check-equal? (vector-assoc 2 (vector (cons 1 2) (cons 4 5) (cons 3 4) (cons 5 6))) 
              #f 
              "vector-assoc returns false if v not in pair")
(check-equal? (vector-assoc "test" (vector (cons 1 2) 3 (cons "test" 4) 4)) 
              '("test" . 4) 
              "vector-assoc handles strings and none pair vectors")
(define f (cached-assoc (list (cons 1 2) (cons 3 4) (cons 4 5)) 2))
(check-equal? (f 4) '(4 . 5) "cached-assoc returns a function that mimics assoc")
(check-equal? (f 3) '(3 . 4) "cached-assoc returns a function part 2")
(check-equal? (f 5) #f "cached-assoc returns false if there is not a pair in there")

(define a 2)
(while-less (begin (print "y") 7) do (begin (set! a (+ a 1)) (print "x") a))
(check-equal? a 7 "first call to while-less sets a to 7")
(while-less (begin (print "y") 7) do (begin (set! a (+ a 1)) (print "x") a))
(check-equal? a 8 "second call to while-less sets a to 8")

;; A simple library for displaying a 2x3 grid of pictures: used
;; for fun in the tests below (look for "Tests Start Here").

(require (lib "graphics.rkt" "graphics"))

(open-graphics)

(define window-name "Programming Languages, Homework 4")
(define window-width 700)
(define window-height 500)
(define border-size 100)

(define approx-pic-width 200)
(define approx-pic-height 200)
(define pic-grid-width 3)
(define pic-grid-height 2)

(define (open-window)
  (open-viewport window-name window-width window-height))

(define (grid-posn-to-posn grid-posn)
  (when (>= grid-posn (* pic-grid-height pic-grid-width))
    (error "picture grid does not have that many positions"))
  (let ([row (quotient grid-posn pic-grid-width)]
        [col (remainder grid-posn pic-grid-width)])
    (make-posn (+ border-size (* approx-pic-width col))
               (+ border-size (* approx-pic-height row)))))

(define (place-picture window filename grid-posn)
  (let ([posn (grid-posn-to-posn grid-posn)])
    ((clear-solid-rectangle window) posn approx-pic-width approx-pic-height)
    ((draw-pixmap window) filename posn)))

(define (place-repeatedly window pause stream n)
  (when (> n 0)
    (let* ([next (stream)]
           [filename (cdar next)]
           [grid-posn (caar next)]
           [stream (cdr next)])
      (place-picture window filename grid-posn)
      (sleep pause)
      (place-repeatedly window pause stream (- n 1)))));

;; Tests Start Here



; These definitions will work only after you do some of the problems
; so you need to comment them out until you are ready.
; Add more tests as appropriate, of course.

(define nums (sequence 0 5 1))

(define files (string-append-map 
               (list "dan" "dog" "curry" "dog2") 
               ".jpg"))

(define funny-test (stream-for-n-steps funny-number-stream 16))

; a zero-argument function: call (one-visual-test) to open the graphics window, etc.
(define (one-visual-test)
  (place-repeatedly (open-window) 0.5 (cycle-lists nums files) 27))

; similar to previous but uses only two files and one position on the grid
(define (visual-zero-only)
  (place-repeatedly (open-window) 0.5 (stream-add-zero dan-then-dog) 27))
