;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |5.8|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define-struct r3 [x y z])
; An R3 is a structure:
;   (make-r3 Number Number Number)
(define ex1 (make-r3 1 2 13))
(define ex2 (make-r3 -1 0 3))

; R3 -> Number
; determines the distance of p to the origin
(check-within (r3-distance-to-origin ex1) 13.19090595827292 13.19090595827292)

(define (r3-distance-to-origin p)
  (sqrt
   (+
    (sqr (r3-x p))
    (sqr (r3-y p))
    (sqr (r3-z p)))))

; 80
(define-struct movie [title director year])

(define-struct pet [name number])

(define-struct CD [artist title price])

(define-struct sweater [material size color])

; Movie -> Movie
(define (f-movie m)
  (...
   (movie-title m)
   ...
   (movie-director m)
   ...
   movie-year m))

; Pet -> Pet
(define (f-pet p)
  (...
   (pet-name p)
   ...
   (pet-number p)))

; CD -> CD
(define (f-CD cd)
  (...
   (CD-artist cd)
   ...
   (CD-title cd)
   ...
   (CD-price cd)))

; Sweater -> Sweater
(define (f-sweater s)
  (...
   (sweater-material s)
   ...
   (sweater-size s)
   ...
   (sweater-color s)))


; 81
(define SECONDS 60)
(define-struct time [hour min sec])
; a time is a structure:
;   (make-time 12 30 2)
(define time-ex1 (make-time 12 30 2))

; Time -> Number
; returns the number of seconds since midnight using
; a time structure t
(check-expect (time->seconds time-ex1) 45002)
(check-expect (time->seconds (make-time 0 0 1)) 1)
(define (time->seconds t)
  (...
   (time-hour t)
   ...
   (time-min t)
   ...
   (time-sec t)))
   