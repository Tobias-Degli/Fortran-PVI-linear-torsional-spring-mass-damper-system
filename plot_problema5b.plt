set term wxt enhanced persist
set xlabel 't [s]'
set ylabel 'Velocidade angular [rad/s]'
set autoscale y
set xrange [0:0.12]
#set key down left
set title 'Dinâmica de um par engrenado em regime transitório'
set term wxt enhanced persist
plot 	'Resultado_Runge_Kutta.txt' using 1:5 with lines lw 1.3 title "RK:ω_1",\
	'Resultado_Runge_Kutta.txt' using 1:6 with lines lw 1.3 title "ω_p",\
	'Resultado_Runge_Kutta.txt' using 1:7 with lines lw 1.3 title "ω_g",\
	'Resultado_Runge_Kutta.txt' using 1:8 with lines lw 1.3 title "ω_4",\
 	'problema5_from_python.txt' using 1:5 with lines dt 2 lw 2.3 title "PY:ω_1",\
	'problema5_from_python.txt' using 1:6 with lines lt 0 lw 3 title "ω_p",\
	'problema5_from_python.txt' using 1:7 with lines dt 5 lw 2.3 title "ω_g",\
	'problema5_from_python.txt' using 1:8 with lines dt 4 lw 2.3 title "ω_4",\
