(switch-to-buffer "*Help*")

(if () "yes" "no")
(if '() "yes" "no")
(if [] "yes" "no")

(= 1 1)
(not (string-equal "abc" "Abc"))

(setq x 3)

(setq y "test")

(equal x y)

(defvar xx 4 "its maybe a 4")

(let ((a 3) (b 4))
  (message "%d" (+ a b)))

(let* ((xa 3) (xb xa))
  (message "%d;%d;" xa xb))

(progn
  (message "hello")
  (message "world"))

(if (< 3 2)
    (message "true")
  (message "false"))

(when (> 3 2)
  (print "test")
  (print "blub"))

(let ((x 0))
  (while (< x 4)
    (print (format "number is %d" x))
    (setq x (+ x 1))))

(let ((xx '(a b c)))
  (while xx
    (message "%s" (pop xx))
    (sleep-for 1)))

(let (xx ii)
  (setq xx [0 1 2 3 4 5])
  (setq ii 0)

  (while (< ii (length xx))
    (insert (format "%d" (aref xx ii)))
    (setq ii (+ ii 1))
    (sleep-for 1)))

(let (xx)
  (setq xx '(a b c))
  (push 'b xx)
  (setq xx (cons 'c xx))
  (message "%s" (cdr xx)))

(let (xx)
  (setq xx '(3 . (4 . 5)))
  (message "left: %S" (car xx))
  (message "right: %S" (car (cdr xx)))
  nil)

(let (xx)
  (setq xx '(0 1 2 3 4))
  (setcdr xx '(1 . nil))
  (setq xx (delq 2 xx))
  (message "%S" xx))

(let (xx (a 2) (b 3))
  (setq xx `(1 ,a ,b))
  (message "%S" xx))

(let (xx)
  (setq xx '((a . 2) (b . 3)))
  (message "%S" (cdr xx)))
