%% Part_I
NumChannels = 128;
Num1        = 8;        % number of channels for 1 CORE
BaseSeq = 0:NumChannels-1;
CORE_2_out  = (reshape(BaseSeq,Num1,NumChannels/Num1))';

%
FIR3_out = zeros(NumChannels/(2*Num1),2*Num1);
for i = 1:NumChannels/(2*Num1)
    for j = 1:2*Num1
        if mod(j,2) ~= 0
            FIR3_out(i,j) = CORE_2_out((i-1)*2 + 1,ceil(j/2));
        else
            FIR3_out(i,j) = CORE_2_out((i-1)*2 + 2,ceil(j/2));
        end
    end
end

%
FIR4_out = zeros(NumChannels/(4*Num1),4*Num1);
for i = 1:NumChannels/(4*Num1)
    for j = 1:4*Num1
        if mod(j,2) ~= 0
            FIR4_out(i,j) = FIR3_out((i-1)*2 + 1,ceil(j/2));
        else
            FIR4_out(i,j) = FIR3_out((i-1)*2 + 2,ceil(j/2));
        end
    end
end

%
FIR5_out = zeros(NumChannels/(8*Num1),8*Num1);
for i = 1:NumChannels/(8*Num1)
    for j = 1:8*Num1
        if mod(j,2) ~= 0
            FIR5_out(i,j) = FIR4_out((i-1)*2 + 1,ceil(j/2));
        else
            FIR5_out(i,j) = FIR4_out((i-1)*2 + 2,ceil(j/2));
        end
    end
end

%
FIR6_out = zeros(NumChannels/(16*Num1),16*Num1);
for i = 1:NumChannels/(16*Num1)
    for j = 1:16*Num1
        if mod(j,2) ~= 0
            FIR6_out(i,j) = FIR5_out((i-1)*2 + 1,ceil(j/2));
        else
            FIR6_out(i,j) = FIR5_out((i-1)*2 + 2,ceil(j/2));
        end
    end
end
