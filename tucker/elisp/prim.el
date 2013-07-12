(defun temp1 (name) (insert (format "
             | Simd_Real_%s of SimdSize.t*Realsize.t (* codegen *)" name)))
(defun temp2 (name) (insert (format "
       | Simd_Real_%s (s,r) => simd_real (s,r,\"%s\")" name name)))
(defun temp3 (name) (insert (format "
    | (Simd_Real_%s (s,r), Simd_Real_%s (s',r')) => 
        SimdSize.equals (s,s') andalso RealSize.equals (r,r')" name name)))
(defun temp4 (name) (insert (format "
    | Simd_Real_%s (s,r) => Simd_Real_%s (s,r)" name name)))
(defun temp5 (name) (insert (format "
    | Simd_Real_%s _ =>" name)))
(defun temp6 (name) (insert (format "
       (Simd_Real_%s (s,r))," name)))
(defun temp7 (name) (insert (format "
       | Simd_Real_%s (r,s) => simdBinary (r,s)" name)))
(defun temp8 (name) (insert (format "
       | Simd_Real_%s _ => two \"%s\"" name name)))
(dolist (i '("add" "sub" "mul" "div" "max" "min" "sqrt" "and" "andn" "or" "xor" "hadd" "hsub" "addsub")) (temp8 i))
