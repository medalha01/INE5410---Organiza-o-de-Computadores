.data
	matA: .word 1 2 3 0 1 4 0 0 1
	matB: .word 1 -2 5 0 1 -4 0 0 1
	matRes: .word 0 0 0 0 0 0 0 0 0

.text
	# $t0 - iterar por cada linha i
	# $t1 - iterar por cada coluna j
	# $t2 - soma das multiplac��es
	# $t3 - calculo da multiplaca��o
	# $t4 - valor temporario de memoria
	# $t5 - valor temporario de memoria
	# $s0 - posi��o base de matA
	# $s1 - posi��o base de matB
	# $s2 - posi��o base de matRes
	# $s3 - valor da posicao temporaria
	# $s4 - valor da posicao temporaria
	
	la $s0, matA
	la $s1, matB
	la $s2, matRes
	
	add $t0, $zero, $zero 
	add $t1, $zero, $zero
			
	LOOPI: 	beq $t0, 36, LOOPIEXIT
		LOOPJ: 	beq $t1, 12, LOOPJEXIT
			add $t2, $zero, $zero # zera soma
			# Primeiro da linha com primeiro da coluna
			add $t4, $s0, $t0 # calcula posi��o em A
			lw $s3, 0($t4)    # l� valor em A
			add $t5, $s1, $t1 # calcula posi��o em B
			lw $s4, 0($t5)	  # l� valor em B
			mul $t3, $s3, $s4 # multiplica
			add $t2, $t2, $t3 # soma ao total
			# Segundo da linha com segundo da coluna
			lw $s3, 4($t4)    # l� pr�xima posi��o em A
			lw $s4, 12($t5)   # l� pr�xima posi��o em B
			mul $t3, $s3, $s4 # multiplica
			add $t2, $t2, $t3 # soma ao total
			# Terceiro da linha com terceiro da coluna
			lw $s3, 8($t4)    # l� pr�xima posi��o em A
			lw $s4, 24($t5)   # l� pr�xima posi��o em B
			mul $t3, $s3, $s4 # multiplica
			add $t2, $t2, $t3 # soma ao total
			# Calcula posi��o destino e armazena resultado
			add $t4, $s2, $t0 # desloca posi��o destino em MatRes de acordo com i
			add $t4, $t4, $t1 # desloca de acordo com j
			sw $t2, 0($t4)    # guarda resultado
			addi $t1, $t1, 4      #incrementa j
			j LOOPJ
		LOOPJEXIT:
		add $t1, $zero, $zero # zera i
		addi $t0, $t0, 12     # incrementa j
		j LOOPI
	LOOPIEXIT: