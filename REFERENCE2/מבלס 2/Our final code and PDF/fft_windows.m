function [x_dft] = fft_windows(x,N)

x_mat=vec2mat(x,N);

x_dft=(fft(x_mat.')).';