set term wxt enhanced persist
set xlabel 't'
set ylabel 'Posição'
set autoscale xy
set title 'Massa-mola em série'
plot 	'Resultado_Runge_Kutta.txt' using 1:2 with lines dt 1 lw 1.3 title "RK:y",\
		'Resultado_Runge_Kutta.txt' using 1:4 with lines dt 3 lw 1.3 title "θ",\



