reset
set term pngcairo size 1024,768
set out "../img/resolution_time_cell.png"
datfile = "../data/resolutions_cell_pi.dat"
set xlabel "Resolution"
set ylabel "Encoding time / ms"
set xrange [-0.3:5.3]
set title "Cell images at various resolutions at quality factor = 75"
set key left

plot datfile using 0:3:6:xticlabels((sprintf("%dx%d", $1, $2))) index 0 title 'cv2' w yerrorbars,'' using 0:3:6:xticlabels((sprintf("%dx%d", $1, $2))) index 1 title 'simplejpeg' w yerrorbars, '' using 0:3:6:xticlabels((sprintf("%dx%d", $1, $2))) index 2 title 'PIL' w yerrorbars, '' using 0:3:6:xticlabels((sprintf("%dx%d", $1, $2))) index 3 title 'pyTurboJPEG' w yerrorbars
set out "../img/resolution_time_nomax_cell.png"
set xrange [-0.3:4.3]
rep

set xrange [-0.3:5.3]
set autoscale y
set title "Images of random RGB noise at various resolutions at quality factor = 75"
set out "../img/resolution_time_random.png"
datfile = "../data/resolutions_random_pi.dat"
plot datfile using 0:3:6:xticlabels((sprintf("%dx%d", $1, $2))) index 0 title 'cv2' w yerrorbars,'' using 0:3:6:xticlabels((sprintf("%dx%d", $1, $2))) index 1 title 'simplejpeg' w yerrorbars, '' using 0:3:6:xticlabels((sprintf("%dx%d", $1, $2))) index 2 title 'PIL' w yerrorbars, '' using 0:3:6:xticlabels((sprintf("%dx%d", $1, $2))) index 3 title 'pyTurboJPEG' w yerrorbars

set out "../img/resolution_time_nomax_random.png"
set xrange [-0.3:4.3]
set yrange [10:200]
rep
