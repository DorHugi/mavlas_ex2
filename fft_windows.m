function [ret_val] = fft_windows(x,N)

% calculate number of rows
len = ceil(size(x,2) / N);
% add zeros if size(x) isn't devided by len
x(end+1 : len * N) = 0;
out_mat = col2im(x, [1 1], [N len])';


ret_val=(fft(out_mat'))';