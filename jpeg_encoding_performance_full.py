#!/usr/bin/env python3

import numpy as np
from simplejpeg import encode_jpeg
import time
from sys import argv
import cv2
from PIL import Image
import io
from turbojpeg import TurboJPEG


cycles = 100
iterations = 25
newImage = True
quality = 75

def randomImage(width, height, reset):
    return np.random.randint(0,255,(height,width,3), dtype=np.uint8)

imageNum = 0
def cellImage(width, height, reset = False):
    if (reset):
        global imageNum
        imageNum = 0
    im = Image.open(f"cell_images/{imageNum}.jpg").resize((width, height))
    imageNum += 1
    return np.array(im)

def cv2Process(arr, quality):
    cv2_encode_param=[int(cv2.IMWRITE_JPEG_QUALITY),quality]
    encoded = cv2.imencode(".jpg", arr, cv2_encode_param)
    return len(encoded[1])

def simpleJpegProcess(arr, quality):
    jpeg = encode_jpeg(arr, quality)
    return len(jpeg)

def pilProcess(arr, quality):
    jpeg = io.BytesIO()
    im = Image.fromarray(arr, 'RGB')
    im.save(jpeg, 'jpeg',  quality = quality)
    return jpeg.tell()

turboJpeg = TurboJPEG()
def turboProcess(arr, quality):
    jpeg = turboJpeg.encode(arr, quality)
    return len(jpeg)

def runTest(processFunc, nextImage, width, height, newImage = True, quality = quality):
    frame_time_averages = []
    sizes = []
    if not newImage:
        arr = nextImage(width, height, True)
    for i in range(cycles):
        cyclesize = 0
        if newImage:
            arr = nextImage(width, height, i == 0)
        start = time.time()
        for j in range(iterations):
            cyclesize += processFunc(arr, quality)
        duration = time.time() - start
        frame_time_averages.append(duration/iterations*1000)
        sizes.append(cyclesize/iterations)
    data = np.array(frame_time_averages)
    sizes = np.array(sizes)
    print(width, height, np.average(data), data.min(), data.max(), np.std(data), np.average(sizes), sizes.min(), sizes.max(), np.std(sizes), quality)

def testAllRes(fullProcess, nextImage):
    print("#width height average min max std sizeavg sizemin sizemas sizestd  quality")
    for width, height in ((640,480),(1280,720), (1640,922), (1640, 1232), (1920,1080), (3280,2464)):
        runTest(fullProcess, nextImage, width, height)

def testQualities(processFunc, nextImage, width, height):
    print("#width height average min max std sizeavg sizemin sizemas sizestd  quality")
    for quality in range(25, 96, 10):
        runTest(processFunc, nextImage, width, height, True, quality)

def qualities():
    width = 1080
    height = 720
    print("#cv2")
    testQualities(cv2Process, nextImage, width, height)

    print("\n")
    print("#simplejpeg")
    testQualities(simpleJpegProcess, nextImage, width, height)

    print("\n")
    print("#pil")
    testQualities(pilProcess, nextImage, width, height)

    print("\n")
    print("#turbojpeg")
    testQualities(turboProcess, nextImage, width, height)

def resolutions():
    print("#cv2")
    testAllRes(cv2Process, nextImage)

    print("\n")
    print("#simplejpeg")
    testAllRes(simpleJpegProcess, nextImage)

    print("\n")
    print("#pil")
    testAllRes(pilProcess, nextImage)

    print("\n")
    print("#turbojpeg")
    testAllRes(turboProcess, nextImage)


#nextImage = randomImage
nextImage = cellImage
qualities()
#resolutions()
