reset
set term pngcairo size 1024,768
set out "../img/quality_time_cell.png"
datfile = "../data/qualities_cell.dat"
set xlabel "Quality factor"
set ylabel "Encoding time / ms"
set key left
set title "1080x720 images of cells at different quality factors"
plot datfile using 11:3:6 index 0 title 'cv2' w yerrorbars,'' using 11:3:6 index 1 title 'simplejpeg' w yerrorbars, '' using 11:3:6 index 2 title 'PIL' w yerrorbars, '' using 11:3:6 index 3 title 'pyTurboJPEG' w yerrorbars

set out "../img/quality_time_random.png"
set title "1080x720 images of random RGB noise at different quality factors"
datfile = "../data/qualities_random.dat"
plot datfile using 11:3:6 index 0 title 'cv2' w yerrorbars,'' using 11:3:6 index 1 title 'simplejpeg' w yerrorbars, '' using 11:3:6 index 2 title 'PIL' w yerrorbars, '' using 11:3:6 index 3 title 'pyTurboJPEG' w yerrorbars
