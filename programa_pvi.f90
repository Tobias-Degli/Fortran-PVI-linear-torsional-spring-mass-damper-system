!gfortran modulo_rk4.f90 programa_pvi.f90 ; ./a.out problema5 ; gnuplot plot_problema5a.plt ; gnuplot plot_problema5b.plt
!gfortran modulo_rk4.f90 programa_pvi.f90 ; ./a.out problema4 ; gnuplot plot_problema4a.plt ; gnuplot plot_problema4b.plt
!gfortran modulo_rk4.f90 programa_pvi.f90 ; ./a.out problema3 ; gnuplot plot_problema3a.plt ; gnuplot plot_problema3b.plt
!gfortran modulo_rk4.f90 programa_pvi.f90 ; ./a.out problema2 ; gnuplot plot_problema2a.plt ; gnuplot plot_problema2b.plt
!gfortran modulo_rk4.f90 programa_pvi.f90 ; ./a.out problema1 ; gnuplot plot_problema1a.plt
program pvi
  use rk_4
  implicit none
  real, dimension (:,:), allocatable::Y
  real, dimension (:), allocatable::tspan,y0
  character(20)::argument
  real::h
  integer:: n,gl
  !Aqui só alterar o nome da function para o nome do modelo desejado:
  ! Ex: problema1, problema2, problema3, problema4, problema5
  interface
    function problema5(t,y) result(dydt)
      real, dimension(size(y))::y,dydt
      real::t
    end function
  end interface
  call get_command_argument(1, argument)
  open(1,file=trim(argument)//".txt",status='old')
  open(2,file="Resultado_Runge_Kutta.txt",status='unknown')
  read(1,*)
  read(1,*)gl
  read(1,*)
  read(1,*)n
  allocate(Y(n+1,gl),tspan(2),y0(gl))
  read(1,*)
  read(1,*)tspan
  read(1,*)
  read(1,*)y0
  h=(tspan(2)-tspan(1))/n
  ! Aqui só alterar o nome da function para o nome do modelo desejado:
  ! Ex: problema1, problema2, problema3, problema4, problema5
  Y=rk4(problema5,tspan,y0,h,n)
end program pvi
! MODELO PAR DE ENGRENAGENS CONSIDERANDO EIXOS
function problema5(t,y) result(dydt)
  real::rp,rg,r1,r4,E1,E2,nu1,nu2,l1,l2,l3,l4,T_in,T_out,qc,qmb, &
        &Ff,m1,mp,mg,m4,G1,G2,G3,G4,Im,Ip,Ig,IL,jp1,jp2,jp3,jp4, &
        &k1,k2,k3,k4,kc,kmb
  real, dimension (8)::y,dydt
  !                                   ---DADOS---
  rp=0.030/2  ! Raio da engrenagem motriz
  rg=0.060/2 ! Raio da engrenagem movida
  r1=0.012/2 ! Raio do eixo de entrada
  r4=r1     ! Raio do eixo de saída
  E1=209e9  ! Módulo de elasticidade do aço 1020
  E2=69e9   ! Módulo de elasticidade do alumínio
  nu1=0.33  ! Coeficiente de poisson para o alumínio
  nu2=0.29  ! Coeficiente de poisson para o aço 1020
  l1=0.1   ! Comprimento do eixo
  l2=0.006  ! Espessura da engrenagem
  l3=0.006  ! Espessura da engrenagem
  l4=l1     ! Comprimento do eixo
  qc = 0.06 ! Coeficiente de atrito nos mancais dos eixos
  qmb = 0.06! Coeficiente de atrito do engrenamento
  Ff = 88   ! Força de contato nos dentes das engrenagens (Norma AGMA)
  T_in = 4  ! Torque do motor Cruiser
  T_out = 3.92 ! Torque no eixo de saída
  pi = 3.14159 ! Valor de pi
  !                                   ---MODELO---
  m1=(pi*r1**2)*l1*7860 ! Massa do eixo de entrada
  mp=(pi*rp**2)*l2*2700 ! Massa da engrenagem motriz
  mg=(pi*rg**2)*l3*2700 ! Massa da engrenagem movida
  m4=m1 !Massa do eixo de saída
  G1=E1/(2*(1+nu1)) ! Módulo de elasticidade transversal do eixo de entrada
  G4=G1 ! Módulo de elasticidade transversal da engrenagem motriz
  G2=E2/(2*(1+nu2)) ! Módulo de elasticidade transversal da engrenagem movida
  G3=G2 ! Módulo de elasticidade transversal do eixo de saída
  Im = (1000*m1*pi*r1**2)/2  ! Momento de inércia do eixo de entrada
  Ip = (1000*mp*pi*rp**2)/2 ! Momento de inércia da engrenagem motriz
  Ig = (1000*mg*pi*rg**2)/2 ! Momento de inércia da engrenagem movida
  IL = (1000*m4*pi*r4**2)/2 ! Momento de inércia do eixo de saída
  Jp1=(pi*r1**4)/2 ! Momento de inércia polar do eixo de entrada
  Jp2=(pi*rp**4)/2 ! Momento de inércia polar da engrenagem motriz
  Jp3=(pi*rg**4)/2 ! Momento de inércia polar da engrenagem movida
  Jp4=(pi*r4**4)/2 ! Momento de inércia polar do eixo de saída
  k1 = G1*Jp1/l1 ! Rigidez do eixo de entrada
  k2 = G2*Jp2/l2 ! Rigidez da engrenagem motriz
  k3 = G3*Jp3/l3 ! Rigidez da engrenagem movida
  k4 = G4*Jp4/l4 ! Rigidez do eixo de saída
  kc=k1 ! =k4 ! Rigidez dos eixos (Nomenclatura do modelo)
  kmb=1/(1/k2+1/k3) ! Rigidez do Engrenamento segundo Rao (2001) pag13
  !                                ---REDUÇÃO DE ORDEM---
  dydt(1)=y(5)
  dydt(2)=y(6)
  dydt(3)=y(7)
  dydt(4)=y(8)
  dydt(5)=(T_in - kc*y(1) + kc*y(2) - qc*y(5) + qc*y(6))/Im
  dydt(6)=(-Ff*rp+kc*y(1)-kc*y(2)+kmb*rg*rp*y(3)-kmb*rp**2*y(2)+qc*y(5)-qc*y(6)+qmb*rg*rp*y(7)-qmb*rp**2*y(6))/Ip
  dydt(7)=(Ff*rg-kc*y(3)+kc*y(4)-kmb*rg**2*y(3)+kmb*rg*rp*y(2)-qc*y(7)+qc*y(8)-qmb*rg**2*y(7)+qmb*rg*rp*y(6))/Ig
  dydt(8)=(-T_out + kc*y(3) - kc*y(4) + qc*y(7) - qc*y(8))/IL
end function problema5
!PROBLEMA PAR DE ENGRENAGENS DESCONSIDERANDO OS EIXOS
function problema4(t,y) result(dydt)
  real, dimension (2)::b,Tq,m,k,v,x,a,I
  real, dimension (4)::y,dydt
  !                                      ---DADOS---
  b=(/0.06, 0.06/) ! Amortecimento
  Tq=(/4.0, 3.92 /) ! Torque na entrada e saída
  m=(/0.01145, 0.0458/) !massa das engrenagens
  k=(/343796.2355, 5500739.7684/) ! Rigidez das engrenagens
  I=(/0.004047, 0.0647/)  !Momento de inercia das engrenagens
  !                                ---REDUÇÃO DE ORDEM---
  dydt(1)=y(3)
  dydt(2)=y(4)
  dydt(3)=(Tq(1)-b(1)*y(3)-k(1)*y(1))/I(1)
  dydt(4)=(-Tq(2)-b(2)*y(4)-k(2)*y(2))/I(2)
end function problema4
! PROBLEMA MASSA-MOLA SIMPLES
function problema1(t,y) result(dydt)
  real::t,x,b,v,k,m,f
  real, dimension(2)::y,dydt ! grau de liberdade é propriedade de cada função
  !                                     ---DADOS---
  b=1 ! Amortecimento
  m=1 ! Massa
  k=1 ! Rigidez
  f=0 ! Força f(t)
  !                                ---REDUÇÃO DE ORDEM---
  x=y(1)
  v=y(2)
  dydt(1)=v
  dydt(2)=(f-b*v-k*x)/m
end function problema1
!! PROBLEMA DO HALTERE TRANSLAÇÃO E ROTAÇÃO
function problema2(t,y) result(dydt)
  ! MODELO MATEMÁTICO
  real::m,mu,alpha,alpha1,g,theta,L
  real, dimension(4)::y,dydt ! grau de liberdade é propriedade de cada função
  !                                        ---DADOS---
  m=0.05 ! Massa das partículas
  mu=0.1 ! !oeficiente de atrito
  g=9.81 ! Aceleração gravidade
  theta=10*3.141592/180 !inclinação da rampa fixa
  L=0.01 ! Comprimento da haste (corpo do haltere)
  !                                ---REDUÇÃO DE ORDEM---
  alpha=y(3)
  alpha1=y(4)
  dydt(1)=y(2)
  dydt(2)=-L*alpha1**2*mu*cos(alpha)/6 + L*alpha1**2*sin(alpha)/6 - &
  & g*mu*sin(alpha)*sin(alpha + theta)/3 + g*mu*cos(theta) + g*sin(alpha) - g*sin(alpha + theta)*cos(alpha)/9
      dydt(3)=y(4)
      dydt(4)=2*g*sin(alpha + theta)/(3*L)
end function problema2
!PROBLEMA MASSA-MOLA EM SÉRIE
function problema3(t,y) result(dydt)
  real, dimension (3)::y0,b,f,m,k,v,x,z !  INSERIR A DIMENSÃO
  real, dimension (size(y0),size(y0))::Mat_k,Mat_b
  real, dimension (2*size(y0))::dydt,y
  real::h
  integer:: n,gdl,i,j
        !                                                   ---DADOS---
  n=size(y0)!número de massas
  gdl=2 !Graus de liberdade para cada massa ex: posiçaõ e velocidade
  do i=1,n
    x(i)=y(i) ! Posição inicial
    v(i)=y(n+i) ! Velocidade inicial
  end do
  !                                             ---DEFININDO MATRIZES DE PARÂMETROS---
  b=(/0.2, 0.2, 0.2 /)
  f=(/0.0, 1.0, 0.0 /)
  m=(/1.0, 1.0, 1.0 /)
  k=(/100.0, 100.0, 100.0/)
  !Primeira linha
  i=1
  Mat_k(i,i)=k(i)+k(i+1)
  Mat_b(i,i)=b(i)+b(i+1)
  Mat_k(i,i+1)=-k(i+1)
  Mat_b(i,i+1)=-b(i+1)
  ! Linhas intermediárias
  do i=2,n-1
  Mat_k(i,i-1)=-k(i)
  Mat_b(i,i-1)=-b(i)
  Mat_k(i,i)=k(i)+k(i+1)
  Mat_b(i,i)=b(i)+b(i+1)
  Mat_k(i,i+1)=-k(i+1)
  Mat_b(i,i+1)=-b(i+1)
  end do
  ! Última linha
  i=n
  Mat_k(i,i-1)=-k(i)
  Mat_b(i,i-1)=-b(i)
  Mat_k(i,i)=k(i)
  Mat_b(i,i)=b(i)
  !                                             ---MODELO---
  z=f-matmul(Mat_b,v)-matmul(Mat_k,x)/m
          !                                ---REDUÇÃO DE ORDEM---
  do i=1,n
  dydt(i)=v(i)
  dydt(n+i)=z(i)
  end do
  do i=1,gdl*n
  end do
end function problema3
