set term wxt enhanced persist
set xlabel 't'
set ylabel 'Velocidade'
set autoscale xy
set title 'Massa-mola em série'
plot 	'Resultado_Runge_Kutta.txt' using 1:3 with lines dt 1 lw 1.3 title "RK:Vy",\
		'Resultado_Runge_Kutta.txt' using 1:5 with lines dt 3 lw 1.3 title "ω"



