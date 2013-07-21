fun dot (a:real array,b:real array,n) = 
    let val i = ref 0 
        val result = ref 0.0 
        val sub = Array.sub
    in while ((!i)<n) do
             (result:=(!result)+(sub(a,(!i))+sub(b,(!i)));
              i:=(!i)+1)
    end
            
val _ = TextIO.print "Hello, World!"
