function mRGB = getReplacementColor ( im , x , y , r )
% Returns mRGB , the median RGB values of the pixels that lie in the ring
% formed between a circle centered at (x , y ) with radius r and a circle
% centered at (x , y ) with radius 2* r .
% im is a 3 - D uint8 array of the RGB values of an image .
% Scalar x is a valid column index of array im .
% Scalar y is a valid row index of array im .
% Scalar r is a non - negative integer .
% The RGB data of im is first converted to an HSV representation so that
% median calculations can be done on the hue , saturation , and value
% separately . The median values are then converted back to RGB .
% mRGB is a 1 x1x3 uint8 array storing RGB values , each in the range 0..255 ,
% inclusive. 
maxRow = size(im,1); %maximum row value for image 
maxCol = size(im,2); %maximum column value for image 
vecR = zeros(size(im)); %initializing matrix for storing values within 1 radius 
RGB = []; %initoalizing matrix for RGB value 
xMin = x-r; %min and max x and y value for circle with one radius 
xMax = x+r; 
yMin = y-r; 
yMax = y+r; 
x1Min = x-2*r; %min and max x and y  values for circle with two radius
x1Max = x+2*r;
y1Min = y-2*r; 
y1Max = y+2*r; 
for i = yMin:yMax %Loop to identify x,y coordinated for values with one radius 
    for j = xMin:xMax
        if sqrt(((j-x)^2)+((i-y)^2)) <= r && i<=maxRow && j<=maxCol 
            vecR(i,j) = 1; %assigns value of one for corrdinates within 1 radius 
        end
    end
end
count = 1; %loop counter 
HSV = rgb2hsv(im); %HSV values for entire image 
for k = y1Min:y1Max % Loop to identify x,y coordinates in two radiuses and get RGB values 
    for l = x1Min:x1Max
        if sqrt(((l-x)^2)+((k-y)^2)) <= 2*r && vecR(k,l)== 0 && k<=maxRow && l<=maxCol
           %stores values of RGB at coordinate points
           H = HSV(k,l,1); %HSV values at valid coordinates 
           S = HSV(k,l,2);
           V = HSV(k,l,3);
           count = count+1; %update counter 
        end
    end
end 
medHSV = [median(H) median(S) median(V)]; %find medians of HSV values 
mRGB = hsv2rgb(medHSV)*255; %converts values back to RGB format 

