%TUGAS PRAKTIKUM 1%

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
