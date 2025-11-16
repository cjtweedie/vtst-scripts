set grid
set pointsize 2
set xlabel "Reaction Coordinate [A]"
set ylabel "Energy [eV]"
set nokey
set terminal pngcairo
set output "mep.png"
plot "spline.dat"  u 2:3 w l lt rgb "blue" lw 2.4 , \
     "neb.dat" u 2:3 w p lt rgb "red" lw 3.0 pt 7 ps 1.3

