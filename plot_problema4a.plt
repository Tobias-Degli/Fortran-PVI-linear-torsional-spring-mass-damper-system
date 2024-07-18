set term wxt enhanced persist
set xlabel 't'
set ylabel 'Posição angular'
set xrange [0:0.006]
set autoscale y
#set key top left
set title 'Dinâmica de um par engrenado em regime transitório'
set term wxt enhanced persist
plot 	'Resultado_Runge_Kutta.txt' using 1:2 with lines lt 0 lw 3 title "RK:θ_1",\
	'Resultado_Runge_Kutta.txt' using 1:3 with lines lw 1.3 title "θ_2",\
	'problema4_from_python.txt' using 1:2 with lines dt 5 lw 2.3 title "PY:θ_1",\
	'problema4_from_python.txt' using 1:3 with lines dt 4 lw 2.3 title "θ_2"	



