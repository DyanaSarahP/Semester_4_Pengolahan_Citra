%Tugas praktikum2%
pkg load image;
%histogram%
img = imread ('kelinci.jpg');
img = im2uint8(img);

figure;
imhist (img);

%1. pisahkan channel RGB%
R= img(:,:,1);
G = img(:,:,2);
B =img (:,:,3);

%tampilkan Histogram untuk masing-masing Channel%
figure;
subplot (3,1,1);
imhist (R);
title('Histogram merah');
xlim([0 255]);

subplot (3,1,2);
imhist (G);
title('Histogram hijau');
xlim([0 255]);

subplot (3,1,3);
imhist (B);
title('Histogram biru');
xlim([0 255]);

%2. meningkatkan kecerahan%
% Baca gambar
img = imread('kelinci.jpg');

% Konversi ke grayscale jika berwarna
if size(img, 3) == 3
    imgray = rgb2gray(img);
else
    imgray = img;
end

% Tambahkan brightness (+100), pastikan tidak lebih dari 255
cerah = imgray + 100;
cerah(cerah > 255) = 255;  % Hindari overflow
cerah = uint8(cerah);      % Pastikan tipe data uint8

% Tampilkan gambar dan histogram
figure('Name', 'Brightness Adjustment');

subplot(2,2,1);
imshow(imgray);
title('Gambar Asli (Grayscale)');

subplot(2,2,2);
imshow(cerah);
title('Setelah Penambahan Kecerahan (+100)');

subplot(2,2,3);
imhist(imgray);
title('Histogram Asli');

subplot(2,2,4);
imhist(cerah);
title('Histogram Setelah Dicerahkan');

%3. meregangkan kontras%
% Baca gambar
img = imread('kelinci.jpg');
if size(img,3) == 3
    img_gray = rgb2gray(img);  % Ubah ke grayscale jika berwarna
else
    img_gray = img;
end

% Hitung gambar hasil peregangan kontras (+3%)
% Normalisasi terlebih dulu
img_double = im2double(img_gray);
kont = imadjust(img_double, stretchlim(img_double, [0.03 0.97]), []);

% Tampilkan gambar before dan after
figure;
subplot(2,2,1);
imshow(img_gray);
title('Before (Original)');

subplot(2,2,2);
imshow(kont);
title('After (Contrast Stretched)');

% Tampilkan histogram before
subplot(2,2,3);
imhist(img_gray);
title('Histogram Before');

% Tampilkan histogram after
subplot(2,2,4);
imhist(kont);
title('Histogram After');


%4. kombinasi kecerahan dan kontras%
% Baca gambar
img = imread('kelinci.jpg');
if size(img,3) == 3
    img_gray = rgb2gray(img);  % Ubah ke grayscale jika berwarna
else
    img_gray = img;
end

% Konversi ke double untuk perhitungan
img_double = im2double(img_gray);

% Pengurangan kecerahan
komb = img_double - 0.04;  % 4% dari skala [0,1], setara dengan -10 di skala 0-255
komb(komb < 0) = 0;  % Hindari nilai negatif

% Peregangan kontras (misal kalikan 1.25 = +25%)
k = komb * 1.25;
k(k > 1) = 1;  % Hindari nilai di atas 1

% Tampilkan gambar before dan after
figure;
subplot(2,2,1);
imshow(img_gray);
title('Before (Original)');

subplot(2,2,2);
imshow(k);
title('After (Brightness & Contrast Adjusted)');

% Tampilkan histogram before
subplot(2,2,3);
imhist(img_gray);
title('Histogram Before');

% Tampilkan histogram after
subplot(2,2,4);
imhist(im2uint8(k));  % Konversi ke uint8 agar histogram benar
title('Histogram After');


%5. membalik citra%
balik = 255 - img;
imshow (balik);

%6. pemetaan nonlinier%
% Baca gambar
img = imread('kelinci.jpg');
if size(img, 3) == 3
    img_gray = rgb2gray(img);  % Ubah ke grayscale jika berwarna
else
    img_gray = img;
end

% Pemetaan nonlinier: transformasi log
img_double = double(img_gray);              % Ubah ke tipe double
meta_log = log(1 + img_double);             % Pemetaan log
meta_norm = mat2gray(meta_log);             % Normalisasi ke [0,1]
meta_uint8 = im2uint8(meta_norm);           % Ubah ke uint8 untuk ditampilkan

% Tampilkan hasil
figure('Name', 'Pemetaan Nonlinier (Log Transform)');
subplot(2,2,1);
imshow(img_gray);
title('Gambar Asli');

subplot(2,2,2);
imshow(meta_uint8);
title('Setelah Transformasi Log');

subplot(2,2,3);
imhist(img_gray);
title('Histogram Asli');

subplot(2,2,4);
imhist(meta_uint8);
title('Histogram Setelah Transformasi Log');


%7. Pemotongan aras keabuan%
function [Hasil] = potong(berkas, f1, f2)
    Img = imread(berkas);
    Img = rgb2gray(Img);                 % Konversi ke grayscale
    [tinggi, lebar] = size(Img);
    Hasil = Img;

    % Proses pemotongan aras keabuan
    for baris = 1 : tinggi
        for kolom = 1 : lebar
            if Hasil(baris, kolom) <= f1
                Hasil(baris, kolom) = 0;
            elseif Hasil(baris, kolom) >= f2
                Hasil(baris, kolom) = 255;
            end
        end
    end

    % Tampilkan gambar dan histogram sebelum dan sesudah
    figure; clf;

    subplot(2,2,1);
    imshow(Img);
    title('Gambar Asli (Grayscale)');

    subplot(2,2,2);
    imhist(Img);
    title('Histogram Asli');

    subplot(2,2,3);
    imshow(Hasil);
    title(['Gambar Setelah Pemotongan [' num2str(f1) '-' num2str(f2) ']']);

    subplot(2,2,4);
    imhist(Hasil);
    title('Histogram Setelah Pemotongan');
end

% Panggil fungsi
H = potong('kelinci.jpg', 30, 170);


%8. Ekualisasi histogram%
% === Ekualisasi Histogram ===
Img = imread('kelinci.jpg');
Img = rgb2gray(Img);  % Ubah ke grayscale

[jum_baris, jum_kolom] = size(Img);
L = 256;
Histog = zeros(L, 1);

% Hitung histogram asli
for baris = 1 : jum_baris
    for kolom = 1 : jum_kolom
        nilai = Img(baris, kolom);
        Histog(nilai + 1) = Histog(nilai + 1) + 1;
    end
end

% Hitung transformasi kumulatif (CDF)
alpha = (L - 1) / (jum_baris * jum_kolom);
C = zeros(L, 1);
C(1) = alpha * Histog(1);
for i = 2 : L
    C(i) = C(i - 1) + round(alpha * Histog(i));
end

% Terapkan transformasi ke gambar
Hasil = zeros(jum_baris, jum_kolom);
for baris = 1 : jum_baris
    for kolom = 1 : jum_kolom
        Hasil(baris, kolom) = C(Img(baris, kolom) + 1);
    end
end

Hasil = uint8(Hasil);  % Konversi ke uint8 agar bisa ditampilkan

% === Tampilkan gambar dan histogram ===
figure(9); clf;

subplot(2,2,1);
imshow(Img);
title('Gambar Asli (Grayscale)');

subplot(2,2,2);
imhist(Img);
title('Histogram Asli');

subplot(2,2,3);
imshow(Hasil);
title('Gambar Setelah Ekualisasi');

subplot(2,2,4);
imhist(Hasil);
title('Histogram Setelah Ekualisasi');

