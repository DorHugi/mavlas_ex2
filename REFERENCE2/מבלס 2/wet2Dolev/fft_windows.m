function [ Xd ] = fft_windows( x, N )


%student: Gil Cherniak, id: 203126412
%student: Dolev Ofri, id: 304843659


%---question 1.c------------------------------------------------------

x1=x;
if(mod(length(x),N)~=0)
    x1 = [x zeros(1,(N-mod(length(x),N)))];
end

R=(reshape(x1,[N,ceil(length(x)/N)]));
Xd = fft(R).';

end

