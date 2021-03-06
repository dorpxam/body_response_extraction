% Inverse Short-Time Fourier Transform
%     x_ = ISTFT(X_,m_,N) returns the Inverse Short-Time Fourier Transform
%     (ISTFT) of the matrix X_ of short-time spectra corresponding to time
%     indices m_ and taken with a window of length N. The function was written
%     to work with the short-time spectra of multi-channel signals. The size of
%     X_ should therefore be (M,chans,U), where M is the FFT length, chans the
%     number of channels of the corresponding time-domain signal, and U, the
%     number of STFT frames.
% 
%     It is likely that, for transparency of the STFT, the time index vector m_
%     includes negative-time values. Values of x_ corresponding to negative
%     time indices are, after inverse transformation, discarded.

function x_ = ISTFT(X_,m_,N)

[M,chans,U] = size(X_);
if U~=length(m_)
   error('The number of columns of STFT must equal the length of time indices');
end

out_N = m_(end)+N-m_(1);
x_ = zeros(out_N,chans);
for u=1:U
   n_ = m_(u)-m_(1)+(0:N-1)';
   tmp = real(ifft(X_(:,:,u)));
   x_(n_+1,:) = x_(n_+1,:) + tmp(1:N,:);
end

x_ = x_(1-m_(1):end,:);