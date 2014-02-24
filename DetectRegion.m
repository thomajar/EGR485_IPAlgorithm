function [ roi ] = DetectRegion( img, percentWhite)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
detectThresh = 10;
sampledistance = 10;

%img = imrotate(img,pi/2,'bilinear');
%img = rgb2gray(img);

[image.y, image.x, image.bpp] = size(img);

cimg = uint8(zeros(image.y,image.x,3));
cimg(:,:,1) = img;
cimg(:,:,2) = img;
cimg(:,:,3) = img;


[image.y,image.x] = size(img);

figure(); imhist(img);
[counts,x] = imhist(img);

[elements] = size(counts);

maxval = 0;
index = 1;
for i = 50:elements
    if maxval < counts(i)
        index = i;
        maxval = counts(i);
    end
end

leftSide = 1;
rightSide = image.x;

maxval = maxval


% find left side
 for x = 1 : image.x
    count = 0;
    for y= 1: image.y
      if img(y,x) > index * 0.50
          count = count + 1;
      end
    end
    if(double(count) / double(image.y) > percentWhite)
       leftSide = x;
       break; 
    end
 end
 
 %find right side
 for x = image.x : -1 : 1
    count = 0;
    for y= 1: image.y
      if img(y,x) > index * 0.50
          count = count + 1;
      end
    end
    if(double(count) / double(image.y) > percentWhite)
       rightSide = x;
       break; 
    end
 end
 
 leftSide = leftSide
 rightSide = rightSide
 
 topSide = 0;
 bottomSide = 0;
 % find top side
 for y = 1 : image.y
    count = 0;
    for x= 1: image.x
      if img(y,x) > index * 0.50
          count = count + 1;
      end
    end
    if(double(count) / double(image.x) > percentWhite)
       topSide = y;
       break; 
    end
 end
 
 %find bottom side
 for y = image.y : -1 : 1
    count = 0;
    for x= 1: image.x
      if img(y,x) > index * 0.50
          count = count + 1;
      end
    end
    if(double(count) / double(image.y) > percentWhite)
       bottomSide = y;
       break; 
    end
 end
 
topSide = topSide
bottomSide = bottomSide

topSide = topSide + 20;
bottomSide = bottomSide - 20;

for x = 1 : image.x
   cimg(topSide,x,1) = 255; 
   cimg(topSide+1,x,1) = 255; 
   cimg(topSide+2,x,1) = 255; 
   cimg(bottomSide,x,1) = 255; 
   cimg(bottomSide-1,x,1) = 255; 
   cimg(bottomSide-2,x,1) = 255; 
end
 
 for y = 1: image.y
    cimg(y,leftSide,1) = 255;
    cimg(y,leftSide+1,1) = 255;
    cimg(y,leftSide+3,1) = 255;
    cimg(y,rightSide,1) = 255;
    cimg(y,rightSide-1,1) = 255;
    cimg(y,rightSide-2,1) = 255;
 end
 
 figure(); imshow(img);
 figure(); imshow(cimg);
 
 roi.left = leftSide;
 roi.right = rightSide;
 roi.top = topSide;
 roi.bottom = bottomSide;
 
end

