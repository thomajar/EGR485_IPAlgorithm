function [ img2 ] = FilterImage( img,h, roi, range )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
% roi contains .left .right .top .bottom
CONTRAST = 8*range;

[tmp,N] = size(h);
N = int16(N);

[image.y, image.x, image.bpp] = size(img);

cimg = uint8(zeros(image.y,image.x,3));
cimg(:,:,1) = img;
cimg(:,:,2) = img;
cimg(:,:,3) = img;

int8(N/2)
N/2
xl = roi.left + int16(N/2)
xr = roi.right - int16(N/2)
yt = roi.top
yb = roi.bottom



isHotCrack = double(0);
isMedHotCrack = double(0);
isMedCrack = double(0);
isLowMedCrack = double(0);
isLowCrack = double(0);

for y = roi.top : 1 : roi.bottom
    isHot = 0;
    for x = roi.left + int16(floor(N/2)) : roi.right - int16(floor(N/2))
        result = 0;
        nd2 = int16(floor(double(N)/2.0));
        pixels = img(y,x- nd2:x + nd2);
        for i = 1 : N
           result = int16(result + int16(h(i)) * int16(pixels(i))); 
        end
        if (pixels(1)> pixels(4)+10) && (pixels(7) > pixels(4)+10)% > pixels(4) + CONTRAST && pixels(7) > pixels(4) + CONTRAST
        if result > CONTRAST * 3.0
            cimg(y,x,1) = 255;
            cimg(y,x,2) = 0;
            cimg(y,x,3) = 0;
            isHot = 1;
        else
            if result > CONTRAST * 2.5
                cimg(y,x,1) = 255;
                cimg(y,x,2) = 255;
                cimg(y,x,3) = 0;
                isMedHotCrack = isMedHotCrack + 1.0;
                isMedCrack = isMedCrack + 1.0;
                isLowMedCrack = isLowMedCrack + 1.0;
                isLowCrack = isLowCrack + 1.0;
            else
                if result > CONTRAST * 2.0
                    cimg(y,x,2) = 255;
                    cimg(y,x,1) = 0;
                    cimg(y,x,3) = 0;
                    isMedCrack = isMedCrack + 1.0;
                    isLowMedCrack = isLowMedCrack + 1.0;
                    isLowCrack = isLowCrack + 1.0;
                else
                    if result > CONTRAST * 1.5
                        cimg(y,x,3) = 255;
                        cimg(y,x,2) = 255;
                        cimg(y,x,1) = 0;
                        isLowMedCrack = isLowMedCrack + 1;
                        isLowCrack = isLowCrack + 1;
                    else
                        if result > CONTRAST
                            cimg(y,x,3) = 255;
                            cimg(y,x,2) = 0;
                            cimg(y,x,1) = 0;
                            isLowCrack = isLowCrack + 1.0;
                        end
                    end
                end
            end
        end
        end
    end
    if isHot
       isHotCrack = isHotCrack + 1.0; 
    end
end

probLow = double(isLowCrack) / double(roi.top - roi.bottom + 1)
probMedLow = double(isLowMedCrack) / double(roi.top - roi.bottom + 1)
probMed = double(isMedCrack) / double(roi.top - roi.bottom + 1)
probMedHot = double(isMedHotCrack) / double(roi.top - roi.bottom + 1)
probHot = double(isHotCrack) / double(roi.bottom - roi.top + 1)

if probHot > 0.CONTRAST
    display('Crack Detected.');
end

figure(); imshow(cimg);


end

