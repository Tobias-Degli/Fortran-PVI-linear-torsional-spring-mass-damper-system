set term wxt enhanced persist
set xlabel 't [s]'
set ylabel 'Posição angular [rad]'
set autoscale xy
set key top left
set title 'Dinâmica de um par engrenado em regime transitório'
set term wxt enhanced persist
plot 	'Resultado_Runge_Kutta.txt' using 1:2 with lines lw 1.3 title "RK θ_1",\
	'Resultado_Runge_Kutta.txt' using 1:3 with lines lw 1.3 title "θ_p",\
	'Resultado_Runge_Kutta.txt' using 1:4 with lines lw 1.3 title "θ_g",\
	'Resultado_Runge_Kutta.txt' using 1:5 with lines lw 1.3 title "θ_4",\
 	'problema5_from_python.txt' using 1:2 with lines dt 5 lw 2.3 title "PYθ_1",\
	'problema5_from_python.txt' using 1:3 with lines lt 0 lw 3 title "θ_p",\
	'problema5_from_python.txt' using 1:4 with lines dt 2 lw 2.3 title "θ_g",\
	'problema5_from_python.txt' using 1:5 with lines dt 4 lw 2.3 title "θ_4",\

	
	



