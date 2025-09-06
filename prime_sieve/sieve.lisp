(defun sieve-of-eratosthenes (n)
  (if (< n 2)
      '()
      (let ((primes (make-array (1+ n) :initial-element t)))
        (setf (aref primes 0) nil)
        (setf (aref primes 1) nil)
        
        ;; Sieve algorithm
        (loop for i from 2 to (floor (sqrt n))
              when (aref primes i)
                do (loop for j from (* i i) to n by i
                         do (setf (aref primes j) nil)))
        
        ;; Collect prime numbers
        (loop for i from 2 to n
              when (aref primes i)
                collect i))))

(defun main ()
  (let* ((limit 10000000)  ; 10 million
         (primes (sieve-of-eratosthenes limit)))
    (format t "Found ~a primes up to ~a~%" (length primes) limit)
    (format t "First 10 primes: ~{~a ~}~%" (subseq primes 0 (min 10 (length primes))))
    (format t "Last 10 primes: ~{~a ~}~%" (subseq primes (max 0 (- (length primes) 10))))))

(main)
