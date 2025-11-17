set xlabel "Reaction coordinate [Å]"
set ylabel "Energy [eV]"
set tics out nomirror
set grid
set pointsize 2
set key right top
set terminal pdfcairo
set output "mep.pdf"

plot "spline.dat" u 2:3 t "Path" w l lt rgb "#4169e1" lw 2.4, \
     "neb.dat" u 2:3 t "Images" w p lt rgb "#ff4500" lw 3.0 pt 7 ps 1.3