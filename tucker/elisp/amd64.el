;;this might be harder than I thought
(defmacro insert-instr (name &rest args)
(let*((src "src: Operand.t")
      (dst "dst: Operand.t")
      (oper (lambda (oper) (format "oper: %s" oper)))
      (size "size: Size.t")
      (misc (lambda (str) str)))
(insert (format ""))))


(defun insert-layout (prefix name &rest args)
"insert a layout for an instruction datatype"
(insert (format "
      val %s_%s_layout
          = let
               open Layout
            in
               fn %s_%s => str \"%s\""
(downcase prefix) name (upcase prefix)
(upcase (car args)) (downcase (car args))))
(dolist (fn (cdr args))
(insert (format "
                | %s_%s => str \"%s\"" (upcase prefix)
(upcase fn) (downcase fn))))
(insert "
            end"))
