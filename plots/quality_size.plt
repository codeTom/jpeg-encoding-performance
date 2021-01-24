reset
set term pngcairo size 1024,768
set out "../img/quality_size_cell.png"
datfile = "../data/qualities_cell.dat"
set xlabel "Quality factor"
set ylabel "Encoded size / 100 kB"
set title "Sizes of jpeg encoded 1080x720 images of cells at different quality factors"
set key left

plot datfile using 11:($7/1e5):($10/1e5) index 0 title 'cv2' w yerrorbars,'' using 11:($7/1e5):($10/1e5) index 1 title 'simplejpeg' w yerrorbars, '' using 11:($7/1e5):($10/1e5) index 2 title 'PIL' w yerrorbars, '' using 11:($7/1e5):($10/1e5) index 3 title 'pyTurboJPEG' w yerrorbars

set title "1080x720 images of random RGB noise at different quality factors"
set out "../img/quality_size_random.png"
datfile = "../data/qualities_random.dat"
plot datfile using 11:($7/1e5):($10/1e5) index 0 title 'cv2' w yerrorbars,'' using 11:($7/1e5):($10/1e5) index 1 title 'simplejpeg' w yerrorbars, '' using 11:($7/1e5):($10/1e5) index 2 title 'PIL' w yerrorbars, '' using 11:($7/1e5):($10/1e5) index 3 title 'pyTurboJPEG' w yerrorbars
