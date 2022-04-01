   implicit none

   integer :: n
   character (len=20) :: fname

   write(*, *) 'Enter the number of significant digits to calculate: '
   read(*, *) n
   write(*, *) "Enter the output location file-name: "
   read(*, *) fname
   call keepe(n, fname)

contains

subroutine keepe(n, fname)

   implicit none

   integer, intent(in) :: n
   character (len=20), intent(in) :: fname
   integer :: m = 4
   real :: test
   integer, dimension(:), allocatable :: coef
   integer :: i, j, carry, temp
   integer, dimension(n + 1) :: d
   logical :: lexist
   
   test = (n + 1) * 2.30258509

   do while ((real(m) * (log(real(m)) - 1.0) + 0.5 * log(6.2831852 * real(m))) <= test)
      m = m + 1
   end do

   allocate(coef(m + 1))
   do j = 2, m, 1
      coef(j - 1) = 1
   end do
   d(1) = 2
   do i = 2, n, 1
      carry = 0
      do j = m, 2, -1
         temp = coef(j - 1) * 10 + carry
         carry = temp/j
         coef(j - 1) = temp - carry * j
      end do
      d(i) = carry;
   end do

   inquire(file=fname, exist=lexist)
   if (.not. lexist) then
      open(1, file=fname, status='new')
   else
      open(1, file=fname, status='old')
   end if

   write(1, "(i0, A)", advance="no") d(1), "."

   do i = 2, n
      write(1, "(i0)", advance="no") d(i)
   end do

   close(1)
   deallocate(coef)
end subroutine keepe

end