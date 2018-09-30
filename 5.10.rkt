;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |5.10|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define WIDTH 200)
(define HEIGHT 20)
(define TEXT-SIZE 16)
(define TEXT-COLOR "black")
(define CURSOR-WIDTH 1)
(define CURSOR (rectangle CURSOR-WIDTH HEIGHT "solid" "red"))
(define MT (empty-scene WIDTH HEIGHT))

(define-struct editor [pre post])
; An Editor is a structure:
;   (make-editor String String)
; interpretation (make-editor s t) describes an editor
; whose visible text is (string-append s t) with 
; the cursor displayed between s and t
(define ex1 (make-editor "" ""))
(define ex2 (make-editor "a" "b"))
(define ex3 (make-editor "abcd" "efgh"))

; Editor -> Image
; Renders an editor with cursor from s and t
(check-expect
  (editor-render
    (make-editor "hello " "world"))
    (overlay/align "left" "center"
      (beside
        (text "hello " TEXT-SIZE TEXT-COLOR)
        CURSOR
        (text "world" TEXT-SIZE TEXT-COLOR)) MT))

(define (editor-render e)
  (overlay/align "left" "center"
    (beside
      (text (editor-pre e) TEXT-SIZE TEXT-COLOR)
      CURSOR
      (text (editor-post e) TEXT-SIZE TEXT-COLOR)) MT))

; Editor KeyEvent -> Editor
; Consumes a key event and calculates a new editor
; It always adds a single character at the end of pre field
; Conditions:
; "\b": Removes a single character at the end of pre if any
; "\t \r": Ignore
; "left right": Moves cursor one character respectively if any
(check-expect (editor-edit ex1 "a") (make-editor "a" ""))
(check-expect
 (editor-edit
  (make-editor "abc" "de")
  "\b")
 (make-editor "ab" "de"))
(check-expect
 (editor-edit
  (make-editor "ab" "de")
  "left")
 (make-editor "a" "bde"))
(check-expect
 (editor-edit
  (make-editor "ab" "de")
  "right")
 (make-editor "abd" "e"))
(check-expect
 (editor-edit
  (make-editor "ab" "de")
  "\t")
 (make-editor "ab" "de"))
(check-expect
 (editor-edit
  (make-editor "ab" "de")
  "\r")
 (make-editor "ab" "de"))
(check-expect
 (editor-edit
  (make-editor "ab" "de")
  "test")
 (make-editor "ab" "de"))

(define (editor-edit e ke)
  (if (= (string-length ke) 1)
      (cond
        [(string=? ke "\b") (editor-erase e)]
        [(or (string=? ke "\t") (string=? ke "\r")) e]
        [else (editor-write e ke)])
      (if
        (or (string=? ke "left") (string=? ke "right"))
        (editor-move-cursor e ke)
        e)))

; Wishlist
; Helpers
; String -> String
; Returns the first character of a string
(check-expect (string-first "abcd") "a")
(check-expect (string-first "") "")

(define (string-first s)
  (if (> (string-length s) 0)
      (string-ith s 0)
      s))

; String -> String
; Returns the last character of a string
(check-expect (string-last "abcd") "d")
(check-expect (string-last "") "")

(define (string-last s)
  (if (> (string-length s) 0)
      (string-ith s (- (string-length s) 1))
      s))

; String -> String
; Returns the string provided minus the first char
(check-expect (string-rest "abcd") "bcd")
(check-expect (string-rest (editor-post ex3)) "fgh")
(check-expect (string-rest "") "")

(define (string-rest s)
  (if (> (string-length s) 0)
      (substring s 1)
      s))

; String -> String
; Returns the string provided minus the last char if any
(check-expect (string-remove-last "abcd") "abc")
(check-expect (string-remove-last "d") "")
(check-expect (string-remove-last "") "")

(define (string-remove-last s)
  (if (> (string-length s) 0)
      (substring s 0 (- (string-length s) 1))
      s))

; Editor -> Editor
; Removes the last character from pre if any
(check-expect (editor-erase ex2) (make-editor "" "b"))
(check-expect (editor-erase (make-editor "abcd" "ef")) (make-editor "abc" "ef"))
(check-expect (editor-erase (make-editor "" "")) (make-editor "" ""))

(define (editor-erase e)
  (make-editor
    (string-remove-last (editor-pre e))
    (editor-post e)))

; Editor KeyEvent -> Editor
; Writes a character into an editor
(check-expect
  (editor-write (make-editor "abc" "de") "x")
  (make-editor "abcx" "de"))

(define (editor-write e ke)
  (make-editor
    (string-append (editor-pre e) ke)
    (editor-post e)))

; Editor KeyEvent -> Editor
; Moves the cursor either left or right based on ke
(check-expect
 (editor-move-cursor ex3 "left")
 (make-editor "abc" "defgh"))
(check-expect
 (editor-move-cursor ex3 "right")
 (make-editor "abcde" "fgh"))
(check-expect
 (editor-move-cursor ex1 "right")
 (make-editor "" ""))
(check-expect
 (editor-move-cursor ex1 "ab")
 (make-editor "" ""))

(define (editor-move-cursor e ke)
  (cond
    [(string=? "right" ke)
     (make-editor
      (string-append
       (editor-pre e)
       (string-first (editor-post e)))
       (string-rest (editor-post e)))]
    [(string=? "left" ke)
     (make-editor
      (string-remove-last (editor-pre e))
      (string-append
       (string-last (editor-pre e))
       (editor-post e)))]
    [else e]))

; Runs a new world based on a provided pre field
(define (run pre)
  (big-bang (make-editor pre "")
    [to-draw editor-render]
    [on-key editor-edit]))
