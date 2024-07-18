set term wxt enhanced persist
set xlabel 't'
set ylabel 'Velocidade'
set autoscale xy
set title 'Massa-mola em série'
plot 	'Resultado_Runge_Kutta.txt' using 1:5 with lines lw 1.3 title "RK:Vx_1",\
	'Resultado_Runge_Kutta.txt' using 1:6 with lines lw 1.3 title "Vx_2",\
	'Resultado_Runge_Kutta.txt' using 1:7 with lines lw 1.3 title "Vx_3"

	
	



