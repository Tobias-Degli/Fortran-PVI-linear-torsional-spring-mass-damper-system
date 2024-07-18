set term wxt enhanced persist
set xlabel 't'
set ylabel 'Velocidade angular'
set xrange [0:0.006]
set autoscale y
set title 'Dinâmica de um par engrenado em regime transitório'
plot 	'Resultado_Runge_Kutta.txt' using 1:4 with lines lt 0 lw 3 title "RK:ω_1",\
	'Resultado_Runge_Kutta.txt' using 1:5 with lines lw 1.3 title "ω_2",\
	'problema4_from_python.txt' using 1:4 with lines dt 5 lw 2.3 title "PY:ω_1",\
	'problema4_from_python.txt' using 1:5 with lines dt 4 lw 2.3 title "ω_2"
	
	
