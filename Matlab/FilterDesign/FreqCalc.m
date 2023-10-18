% initial parameters
BW0 = 5e6;
Fs0 = 11e6;
D = [2 5 5 2 2 2 2];
%
Fs = [Fs0 zeros(1,length(D))];
BW = [BW0 zeros(1,length(D))];
for i = 2:length(Fs)
    Fs(i) = Fs(i-1)/D(i-1);
    BW(i) = BW(i-1)/D(i-1);
end

%%
NumOfChannels = 80;
df = (BW0/2)/NumOfChannels;
f0 = -BW0/4:df:BW0/4-df;
%
FREQS = cell(NumOfChannels,length(D));
for i = 1:NumOfChannels
    for j = 1:length(D)
        FREQS{i,j} = [f0(i) - BW(j)/4 , f0(i) + BW(j)/4];
    end
end





