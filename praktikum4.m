% Baca gambar
img = imread('nginceng.jpg');
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
