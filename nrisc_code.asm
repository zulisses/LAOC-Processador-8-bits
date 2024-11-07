000   			# r0: tamanho do vetor
001   			# r1: auxiliar
010  		    # r2: maior valor
011 			# r3: menor valor
100   			# r4
101   			# rr: registrador de resultado geral
110  			# ra
111  			# sp: stack pointer

rst $sp                         # 00111100  # sp = 0
lw $sp                          # 00111001  # rr = 0
rst $r0                         # 00000100  # r0 = 0
add $r0, $rr                    # 01000101  # rr = 0
rst rr                          # 00101100  # rr = 0
add rr r0                       # 01101000  # rr = n
rst sp                          # 00111100  # sp = 0
add $sp, $rr                    # 01111101  # sp = n
lw $sp                   	    # 00111001  # rr = v[n-1]
rst $r2                  	    # 00010100  # r2 = 0
add $r2, $rr             	    # 01010101  # r2 += v[n-1]
rst $r3                  	    # 00011100  # r3 = 0
add $r3, $rr             	    # 01011101  # r3 = v[n-1] # TININO
#while:  addi 0                 # 10000000  # rr += 0
         rst $rr               	# 00101100  # rr = 0
         addi 1                	# 10000010  # rr += 1
         inv $rr               	# 00101101  # rr = -rr
         add $r0, $rr           # 01000101  # r0 += -1
         add $sp, $rr           # 01111101  # sp += -1
         addi 0                 # 10000000  # rr += 0
         rst $rr               	# 00101100  # rr = 0
         addi 31              	# 10111110  # rr += 31
         addi 30              	# 10111100  # rr += 30
         rst $ra              	# 00110100  # ra = 0
         add $ra, $rr       	# 01110101  # ra += rr
         addi 0                 # 10000000  # rr += 0
         beqz $r0           	# 00000110  # if(n == 0) exit()
         jr $ra                	# 00110011  # j exit
         addi 0                 # 10000000  # rr += 0
         rst $rr               	# 00101100  # rr = 0
         addi 31              	# 10111110  # rr += 31
         addi 4                	# 10001000  # rr += 3
         rst $ra               	# 00110100  # ra = 0
         add $ra, $rr      	    # 01110101  # ra += rr
         addi 0                 # 10000000  # rr += 0
         lw $sp                 # 00111001  # rr = v[n]
         rst $r1               	# 00001100  # r1 = 0
         add $r1, $rr           # 01001101  # r1 += rr
         addi 0                 # 10000000  # rr += 0
         slt $r1, $r3        	# 11001111  # rr = (v[n] < menor)
         beqz $rr               # 00101110  # if(rr != 0) => pula 2 linhas
         j 1                   	# 10000011  # pula 2 linhas
         jr $ra                	# 00110011  # j 'menor' if (v[n] < menor)
         addi 0                 # 10000000  # rr += 0
#if_2:   addi 0                 # 10000000  # rr += 0
         rst $rr               	# 00101100  # rr = 0
         addi 31              	# 10111110  # rr += 31
         addi 11                # 10010110  # rr += 11
         inv $rr               	# 00101101  # rr = -rr
         rst $ra              	# 00110100  # ra = 0
         add $ra, $rr       	# 01110101  # ra += rr
         addi 0                 # 10000000  # rr += 0
         slt $r1, $r2        	# 11001101  # rr = (v[n] < maior)
         beqz $rr               # 00101110  # bne $rr, $zero, while --> (v[n] < maior) => while
         j 1                   	# 10000011  # pula 2 linhas
         jr $ra                	# 00110011  # (v[n] < maior) => while 
         addi 0                 # 10000000  # rr += 0
         rst $rr               	# 00101100  # rr = 0
         addi 31              	# 10111110  # rr += 31
         addi 21              	# 10101010  # rr += 21
         inv $rr               	# 00101101  # rr = -rr
         rst $ra               	# 00110100  # ra = 0
         add $ra, $rr      	    # 01110101  # ra += rr
         addi 0                 # 10000000  # rr += 0
         beqr $r1, $r2    	    # 11001100  # (v[n] == maior) => linha seguinte
         jr $ra                	# 00110011  # (v[n] == maior) => while
         rst $r2               	# 00010100  # r2 = 0
         add $r2, $r1     	    # 01010001  # r2 += r1 (maior = v[n])
         addi 0                 # 10000000  # rr += 0
         rst $rr               	# 00101100  # rr = 0
         addi 22           	    # 10101100  # rr += 22
         addi 22            	# 10101100  # rr += 22
         addi 20           	    # 10101000  # rr += 20
         inv $rr              	# 00101101  # rr = -rr
         rst $ra               	# 00110100  # ra = 0
         add $ra, $rr     	    # 01110101  # ra += rr
         addi 0                 # 10000000  # rr += 0
         jr $ra                	# 00110011  # j while
         addi 0                 # 10000000  # rr += 0
#menor:  addi 0                 # 10000000  # rr += 0
         rst $r3               	# 00011100  # r3 = 0
         add $r3, $r1     	    # 01011001  # menor += v[n]
         addi 0                 # 10000000  # rr += 0
         rst $rr               	# 00101100  # rr = 0
         addi 31             	# 10111110  # rr += 31
         addi 15             	# 10011110  # rr += 15
         inv $rr              	# 00101101  # rr = -rr
         rst $ra             	# 00110100  # ra = 0
         add $ra, $rr     	    # 01110101  # ra += rr
         addi 0                 # 10000000  # rr += 0
         jr $ra                	# 00110011  # j if_2 
         addi 0                 # 10000000  # rr += 0
#exit    addi 0                 # 10000000  # rr += 0
         halt                  	# 00000000  # fim do programa