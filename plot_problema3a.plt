set term wxt enhanced persist
set xlabel 't'
set ylabel 'Posição'
set autoscale xy
set title 'Massa-mola em série'
plot 	'Resultado_Runge_Kutta.txt' using 1:2 with lines lw 1.3 title "RK:x_1",\
	'Resultado_Runge_Kutta.txt' using 1:3 with lines lw 1.3 title "x_2",\
	'Resultado_Runge_Kutta.txt' using 1:4 with lines lw 1.3 title "x_3"
	
	



