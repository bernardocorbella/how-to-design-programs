;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname chapter_2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 11
;(define (distance-to-origin x y)
 ; (sqrt (+ (sqr x) (sqr y))))
;(distance-to-origin 3 4)

; Exercise 12
;(define (carea side) (sqr side))
;(define (cvolume side) (* side (carea side)))
;(cvolume 5)

; Exercise 13
;(define (string-first str) (string-ith str 0))
;(define (string-last str) (string-ith str (- (string-length str) 1)))
;(string-first "hello")
;(string-last "hello")

;(require 2htdp/batch-io)

;(define (letter fst lst signature-name)
;  (string-append
;    (opening fst)
;    "\n\n"
;    (body fst lst)
;    "\n\n"
;    (closing signature-name)))
 
;(define (opening fst)
;  (string-append "Dear " fst ","))
 
;(define (body fst lst)
;  (string-append
;   "We have discovered that all people with the" "\n"
;   "last name " lst " have won our lottery. So, " "\n"
;   fst ", " "hurry and pick up your prize."))
 
;(define (closing signature-name)
;  (string-append
;   "Sincerely,"
;   "\n\n"
;   signature-name
;   "\n"))

;(define REGULAR_ATTENDANCE 120)
;(define REGULAR_TICKET_PRICE 5)
;(define ATTENDANCE_VARIATION 15)
;(define PRICE_VARIATION 0.1)
;(define SHOW_COST 180)
;(define COST_PER_PERSON 0.04)

;(define (attendees ticket-price)
;  (- REGULAR_ATTENDANCE
;     (* (- ticket-price REGULAR_TICKET_PRICE) (/ ATTENDANCE_VARIATION PRICE_VARIATION))))

;(define (revenue ticket-price)
;  (* ticket-price (attendees ticket-price)))

;(define (cost ticket-price)
;  (+ SHOW_COST (* COST_PER_PERSON (attendees ticket-price))))

;(define (profit ticket-price)
;  (- (revenue ticket-price)
;     (cost ticket-price)))

