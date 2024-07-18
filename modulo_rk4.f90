module rk_4
implicit none
contains
function rk4(arg_f,tspan,y0,h,len) result(val)
real, dimension(:)::tspan
real,dimension(:)::y0
real, dimension(len+1)::t
real, dimension(len+1,size(y0))::y,val,k1,k2,k3,k4,k
real::h
integer::i,len
interface
  function arg_f(arg_x,arg_y) result(val)
    real, dimension(size(y0))::arg_y,val
    real::arg_x
  end function
end interface
do i=1,size(y0)
  y(1,i)=y0(i)
end do
t(1)=tspan(1)
do i=1,len
  k1(i,:)=arg_f(t(i),y(i,:))
  k2(i,:)=arg_f(t(i)+h/2,y(i,:)+k1(i,:)*h/2)
  k3(i,:)=arg_f(t(i)+h/2,y(i,:)+k2(i,:)*h/2)
  k4(i,:)=arg_f(t(i)+h,y(i,:)+k3(i,:)*h)
  k(i,:)=(k1(i,:)+2*k2(i,:)+2*k3(i,:)+k4(i,:))/6
  t(i+1)=t(i)+h
  y(i+1,:)=y(i,:)+k(i,:)*h
end do
do i=1,len+1
  write(2,*)t(i),y(i,:)
  end do
val=y
end function rk4
end module rk_4
