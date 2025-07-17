pkg load image;  % Load package untuk image processing

% 1. Baca dan konversi gambar
gambar_asli = imread('wajah.jpg');
if size(gambar_asli, 3) == 3
  gambar_asli = rgb2gray(gambar_asli);
endif
gambar_asli = im2double(gambar_asli);

% Tampilkan gambar asli dan histogram
figure('Name', 'Gambar Asli');
subplot(1,2,1); imshow(gambar_asli); title('Gambar Asli');
subplot(1,2,2); imhist(gambar_asli); title('Histogram Asli');

% 2. Definisikan noise
nama_noise = {'gaussian', 'salt_pepper', 'speckle', 'poisson', 'uniform'};
fungsi_noise = {
  @(x) imnoise(x, 'gaussian', 0, 0.01),
  @(x) imnoise(x, 'salt & pepper', 0.05),
  @(x) imnoise(x, 'speckle', 0.04),
};

% 3. Definisikan filter
sobel_x = fspecial('sobel');
sobel_y = sobel_x';
kernel_perataan = fspecial('average', [5 5]);

% 4. Proses untuk setiap noise
for i = 1:length(nama_noise)
  nama = nama_noise{i};
  noisy = fungsi_noise{i}(gambar_asli);

  % === Filter Batas (Sobel) ===
  grad_x = imfilter(noisy, sobel_x, 'replicate');
  grad_y = imfilter(noisy, sobel_y, 'replicate');
  hasil_batas = sqrt(grad_x.^2 + grad_y.^2);

  % === Filter Perataan ===
  hasil_perataan = imfilter(noisy, kernel_perataan, 'replicate');

  % === Filter Median ===
  hasil_median = medfilt2(noisy, [3 3]);

  % === Tampilkan semua dalam satu figure ===
figure('Name', ['Hasil Filter - Noise: ', nama]);

  % Filter Batas
  subplot(3,2,1); imshow(hasil_batas); title('Filter Batas');
  subplot(3,2,2); imhist(hasil_batas); title('Histogram Batas');

  % Filter Perataan
  subplot(3,2,3); imshow(hasil_perataan); title('Filter Perataan');
  subplot(3,2,4); imhist(hasil_perataan); title('Histogram Perataan');

  % Filter Median (ganti dari Mean)
  subplot(3,2,5); imshow(hasil_median); title('Filter Median');
  subplot(3,2,6); imhist(hasil_median); title('Histogram Median');
endfor

disp("Selesai: Hasil semua filter ditampilkan per jenis noise.");
