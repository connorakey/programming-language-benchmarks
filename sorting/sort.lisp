(defun quicksort (arr)
  (if (<= (length arr) 1)
      arr
      (let* ((pivot (nth (floor (length arr) 2) arr))
             (left (remove-if-not (lambda (x) (< x pivot)) arr))
             (middle (remove-if-not (lambda (x) (= x pivot)) arr))
             (right (remove-if-not (lambda (x) (> x pivot)) arr)))
        (append (quicksort left) middle (quicksort right)))))

(defun main ()
  (let* ((size 1000000)
         (arr (progn
                (setf *random-state* (make-random-state t))
                (loop for i from 1 to size
                      collect (1+ (random 1000000))))))
    (let ((sorted (quicksort arr)))
      (format t "First 10: ~{~a ~}~%" (subseq sorted 0 10))
      (format t "Last 10: ~{~a ~}~%" (subseq sorted (- size 10))))))

(main)
