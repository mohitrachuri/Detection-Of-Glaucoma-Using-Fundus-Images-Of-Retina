function Op_Data = InitCent(Ip_Data,kMax,Alp)
[m,n] = size(Ip_Data);

k = 1;

% TWO D DATA TO ONE D DATA
for i=1:m
    for j=1:n
    OneDData(k) = Ip_Data(i,j);
    k = k+1;
    end 
end

% INITALIZE DATA
OrigData = OneDData;

% CLUSTER INDEX
k = 1;
OFlowFlag = 0;
while k <= kMax
% THRESHOLD VALUE - MAXIMUM COUNT
ThrVal = round(Alp*m*n/kMax);
Group  = OrigData(1);
		while (length(Group) < ThrVal) && (OFlowFlag == 0)
 		OneDData = OrigData;
		OneDData = abs(OneDData - mean(Group));

            if length(OneDData) > 1
                Sample = OneDData(2:length(OneDData));                  
                [Dummy,DesInd] = min(Sample);
           		ChosData = OrigData(DesInd+1);
            else
           		ChosData = OneDData;
            end
            Group  = [Group ChosData];

                if DesInd <= (length(OrigData)-2)
                OrigData = [OrigData(2:DesInd) OrigData((DesInd+2):length(OrigData))];
			    else
                OrigData = OrigData(2:DesInd);
			    end

            if length(OrigData)==2 
                OFlowFlag = 1;
            end 
        end
        Op_Data(k).Cent = mean(Group);
        k = k+1;
end
return