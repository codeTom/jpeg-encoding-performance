reset
set term pngcairo size 1024,768
set out "../img/size_time_cell.png"
datfile = "../data/qualities_cell.dat"
set xlabel "Encoded size / 100 kB"
set ylabel "Encoding time / ms"
set key left

set title "1080x720 images of cells at different quality factors"
plot datfile using ($7/1e5):3:($10/1e5):6 index 0 title 'cv2' w xyerrorbars,'' using ($7/1e5):3:($10/1e5):6 index 1 title 'simplejpeg' w xyerrorbars, '' using ($7/1e5):3:($10/1e5):6 index 2 title 'PIL' w xyerrorbars, '' using ($7/1e5):3:($10/1e5):6 index 3 title 'pyTurboJPEG' w xyerrorbars

set out "../img/size_time_random.png"
set title "1080x720 images of random RGB noise at different quality factors"
datfile = "../data/qualities_random.dat"
plot datfile using ($7/1e5):3:($10/1e5):6 index 0 title 'cv2' w xyerrorbars,'' using ($7/1e5):3:($10/1e5):6 index 1 title 'simplejpeg' w xyerrorbars, '' using ($7/1e5):3:($10/1e5):6 index 2 title 'PIL' w xyerrorbars, '' using ($7/1e5):3:($10/1e5):6 index 3 title 'pyTurboJPEG' w xyerrorbars
