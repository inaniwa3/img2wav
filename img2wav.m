% img2wav.m

% read
imgrgb = imread('B4aQmy0CEAAThc8.jpg');

% rgb to gray
imggray = uint8(mean(imgrgb, 3));

% trim
imggray(206:248, 508:550) = 255;  % delete icon
imggray = imggray(125:229, 18:563);

% gray to bw
imgbw = imggray > 148;  % threshold
% imwrite(imgbw, 'imgbw.png');

% bw to wav
wav = zeros(2 * size(imgbw, 2) , 1);
for t = 1:size(imgbw, 2)
  wav(2 * t - 1) = find(diff(imgbw(:, t)) == -1)(1) + 1;
  wav(2 * t    ) = find(diff(imgbw(:, t)) == 1)(end);
end
wav = -wav + ceil(size(imgbw, 1) / 2);  % offset
% wav = wav / floor(size(imgbw, 1) / 2);  % normalize ver.1
wav = wav / max(abs(wav));  % normalize ver.2

% write
wavwrite(wav, 4000, 'out.wav');
