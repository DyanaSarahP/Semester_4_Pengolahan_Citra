% UTS PENGOLAHAN CITRA %

% NO 1%
%Membaca Citra %
Img = imread('kucing1.jpg');

%Menampilkan Citra %
subplot(1,3,1), imshow(Img), title('Citra RGB');

%Menampilkan Ukuran Citra %
Ukuran = size(Img);

%Mengkonversi Citra RGB ke Grayscale %
RGB = imread('kucing1.jpg');
Abu = rgb2gray(RGB);
subplot(1,3,2), imshow(Abu), title('Citra Grayscale');

%Mengkonversi Citra Grayscale ke Biner %
Img = imread('kucing1.jpg');
[tinggi, lebar] = size(Img);
ambang = 210; % Nilai ini bisa diubah-ubah
biner = zeros(tinggi, lebar);
for baris=1 : tinggi
for kolom=1 : lebar
if Img(baris, kolom) >= ambang
Biner(baris, kolom) = 0;
else
Biner(baris, kolom) = 1;
end
end
end
subplot(1,3,3), imshow(Biner), title('Citra Biner');

%Menyimpan Citra %
imwrite(Img, 'citra_RGB.png');
imwrite(Abu, 'citra_grayscale.png');
Biner = logical(Biner);
imwrite(Biner, 'citra_biner.png');

% NO 2 %
% Membaca citra
img = imread('mata.jpeg');

% Konversi ke grayscale jika belum
if size(img, 3) == 3
    img_gray = rgb2gray(img);
else
    img_gray = img;
end

% Fungsi untuk mengkuantisasi citra ke n tingkat keabuan
function quantized_img = quantize_gray(img_gray, levels)
    step = 256 / levels;
    quantized_img = floor(double(img_gray) / step) * step;
    quantized_img = uint8(quantized_img);
end

% Kuantisasi menjadi 2, 4, dan 8 tingkat keabuan
img_2 = quantize_gray(img_gray, 2);
img_4 = quantize_gray(img_gray, 4);
img_8 = quantize_gray(img_gray, 8);

% Tampilkan hasil
figure;
subplot(2,2,1), imshow(img_gray), title('Asli - Grayscale');
subplot(2,2,2), imshow(img_2), title('2 Tingkat Keabuan');
subplot(2,2,3), imshow(img_4), title('4 Tingkat Keabuan');
subplot(2,2,4), imshow(img_8), title('8 Tingkat Keabuan');

% NO 3 %
pkg load image

% Membaca gambar
img = imread('langit.jpg');

% Mengubah gambar RGB ke grayscale
imgray = rgb2gray(img);

% Meningkatkan kecerahan
cerah = imgray + 100;
cerah(cerah > 255) = 255; % Menjaga agar nilai pixel tidak melebihi 255
cerah = uint8(cerah);

% Menampilkan gambar sebelum dan sesudah cerah
figure;
subplot(2,2,1);
imshow(imgray);
title('Gambar Sebelum Dicerahkan');

subplot(2,2,2);
imshow(cerah);
title('Gambar Sesudah Dicerahkan');

% Menampilkan histogram
subplot(2,2,3);
imhist(imgray);
title('Histogram Sebelum Dicerahkan');

subplot(2,2,4);
imhist(cerah);
title('Histogram Sesudah Dicerahkan');

% NO 4 %
pkg load image

% Baca dan konversi ke grayscale
Img = imread('merem.jpg');
Img = rgb2gray(Img);  % Konversi ke grayscale

[jum_baris, jum_kolom] = size(Img);
L = 256;  % Jumlah level intensitas
Histog = zeros(L, 1);

% Hitung histogram citra asli
for baris = 1 : jum_baris
    for kolom = 1 : jum_kolom
        nilai = Img(baris, kolom);
        Histog(nilai + 1) = Histog(nilai + 1) + 1;
    end
end

% Hitung distribusi kumulatif (CDF)
alpha = (L - 1) / (jum_baris * jum_kolom);
C(1) = alpha * Histog(1);
for i = 2 : L
    C(i) = C(i - 1) + round(alpha * Histog(i));
end

% Transformasi piksel berdasarkan CDF
Hasil = Img;
for baris = 1 : jum_baris
    for kolom = 1 : jum_kolom
        Hasil(baris, kolom) = C(Img(baris, kolom) + 1);
    end
end

Hasil = uint8(Hasil);

% Tampilkan citra sebelum dan sesudah ekualisasi
figure;
subplot(2,2,1);
imshow(Img);
title('Citra Asli (Grayscale)');

subplot(2,2,2);
imshow(Hasil);
title('Setelah Ekualisasi Histogram');

% Tampilkan histogram sebelum dan sesudah
subplot(2,2,3);
imhist(Img);
title('Histogram Asli');

subplot(2,2,4);
imhist(Hasil);
title('Histogram Setelah Ekualisasi');

% NO 5 %
pkg load image;
% Membaca gambar
gambar = imread('noise.jpg');

% Konversi ke grayscale jika perlu
if size(gambar, 3) == 3
    gambar_gray = rgb2gray(gambar);
else
    gambar_gray = gambar;
end

% Terapkan median filter 3x3
gambar_median = medfilt2(gambar_gray, [3 3]);

% Terapkan mean filter 3x3 (menggunakan konvolusi)
kernel_mean = ones(3,3) / 9;
gambar_mean = conv2(double(gambar_gray), kernel_mean, 'same');
gambar_mean = uint8(gambar_mean);

% Tampilkan hasil
figure;
subplot(1,3,1), imshow(gambar_gray), title('Asli (Grayscale)');
subplot(1,3,2), imshow(gambar_median), title('Median Filter 3x3');
subplot(1,3,3), imshow(gambar_mean), title('Mean Filter 3x3');

% NO 6 &
kg load image;

% Load gambar grayscale
img = imread('Flowers.jpg');
img_gray = im2double(rgb2gray(img));

% Parameter
A = 1.5;  % Faktor boost (>1)

% Buat kernel low-pass (misalnya Gaussian)
h = fspecial('gaussian', [5 5], 1);

% Blur gambar (low-pass filter)
img_blur = imfilter(img_gray, h, 'replicate');

% High-boost filter: hasil = A * original - blur
img_highboost = A * img_gray - img_blur;

% Tampilkan hasil
figure;
subplot(1,3,1), imshow(img_gray), title('Original');
subplot(1,3,2), imshow(img_blur), title('Low-pass (blur)');
subplot(1,3,3), imshow(img_highboost), title('High-Boost Result');

% NO 7 &
pkg load image;

% Membaca gambar
img = imread('papanhitam.jpg');

% Rotasi gambar (misalnya 15 derajat ke kanan, sesuaikan jika perlu)
angle = -15; % Sesuaikan agar gambar tegak lurus
img_rotated = imrotate(img, angle, 'bilinear');

% Perbesar gambar (misalnya 2x)
scale = 2;
img_resized = imresize(img_rotated, scale, 'bilinear');

% Tampilkan gambar asli dan hasil transformasi dalam satu figure
figure;

subplot(1, 2, 1);
imshow(img);
title('Gambar Asli');

subplot(1, 2, 2);
imshow(img_resized);
title('Setelah Rotasi dan Pembesaran');

% NO 8 %
% Baca gambar
img = imread('pink.jpg');
img = im2double(img); % Ubah ke tipe double untuk manipulasi

% Ukuran gambar
[rows, cols, ch] = size(img);

% Parameter ripple
x_amplitude = 5;
y_amplitude = 5;
x_frequency = 0.05;
y_frequency = 0.05;

% Buat meshgrid untuk koordinat asli
[x, y] = meshgrid(1:cols, 1:rows);

% Hitung koordinat baru dengan efek ripple
x_disp = x + x_amplitude * sin(2 * pi * y_frequency * y);
y_disp = y + y_amplitude * sin(2 * pi * x_frequency * x);

% Interpolasi dan hasil akhir
ripple_img = zeros(size(img));
for c = 1:ch
    ripple_img(:,:,c) = interp2(x, y, img(:,:,c), x_disp, y_disp, 'linear', 0);
end

% Tampilkan hasil sebelum dan sesudah
figure;
subplot(1,2,1); imshow(img); title('Original Image');
subplot(1,2,2); imshow(ripple_img); title('Ripple Effect Applied');

% NO 9 %
kg load image;

% Membaca gambar
img = imread('parkiran.jpg');

% Konversi ke grayscale jika RGB
if ndims(img) == 3
  img = rgb2gray(img);
endif

% Buat filter Gaussian
sigma = 10; % Standar deviasi Gaussian (semakin besar, semakin blur)
kernel_size = 2 * ceil(3 * sigma) + 1; % Ukuran kernel berdasarkan sigma
h = fspecial('gaussian', kernel_size, sigma); % Buat kernel Gaussian

% Terapkan filter ke gambar
blurred_img = imfilter(img, h, 'replicate');

% Tampilkan hasil
figure;
subplot(1,2,1), imshow(img), title('Asli');
subplot(1,2,2), imshow(blurred_img), title('Gaussian Blur');

% NO 10 %
function trans
    % Baca gambar grayscale
    F = imread('bangunan.jpg'); % Gambar bawaan MATLAB

    % Parameter transformasi
    theta = pi / 6;   % Rotasi 30 derajat (dalam radian)
    scale = 0.8;      % Skala
    tx = 20;          % Translasi x
    ty = -10;         % Translasi y

    % Matriks transformasi affine: rotasi + skala
    a11 = scale * cos(theta);
    a12 = -scale * sin(theta);
    a21 = scale * sin(theta);
    a22 = scale * cos(theta);

    % Lakukan transformasi affine
    G = taffine(F, a11, a12, a21, a22, tx, ty);

    % Tampilkan hasil transformasi
    figure;
    subplot(1,2,1); imshow(F); title('Citra Asli');
    subplot(1,2,2); imshow(G); title('Citra Hasil Transformasi Affine');
end

function G = taffine(F, a11, a12, a21, a22, tx, ty)
    % TAFFINE Melakukan transformasi affine pada citra grayscale F
    [tinggi, lebar] = size(F);
    G = zeros(tinggi, lebar); % Inisialisasi citra hasil

    for y = 1 : tinggi
        for x = 1 : lebar
            % Hitung koordinat hasil transformasi
            x2 = a11 * x + a12 * y + tx;
            y2 = a21 * x + a22 * y + ty;

            % Pastikan koordinat masih di dalam citra
            if (x2 >= 1) && (x2 <= lebar - 1) && ...
               (y2 >= 1) && (y2 <= tinggi - 1)

                % Interpolasi bilinear
                p = floor(y2);
                q = floor(x2);
                a = y2 - p;
                b = x2 - q;

                intensitas = (1 - a) * ((1 - b) * F(p, q) + b * F(p, q + 1)) + ...
                             a * ((1 - b) * F(p + 1, q) + b * F(p + 1, q + 1));
                G(y, x) = intensitas;
            else
                G(y, x) = 0;
            end
        end
    end

    G = uint8(G); % Konversi ke format citra
end
