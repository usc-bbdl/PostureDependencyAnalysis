%Header
%Time(1), Measured M0(2), Command M0(3), Measured M1(4), Command M1(5),
%Measured M2(6),Command M2(7), Angle 0(8), Angle 1(9), Sensor 0(10),
%Sensor 1(11), Sensor 2(12), Sensor 3(13), Sensor 4 (14), Sensor 5 (15),
%Robot Flag(16), Motor Flag(17), AdeptX(18), AdeptY (19)
load data/data1
time = data1(:,1);
robotFlag = data1(:,16);
motorFlag = data1(:,17);

postureChange = robotFlag(2:end) - robotFlag(1:end-1);
postureSetIndex = find(postureChange == 1);
postureUnsetIndex = find(postureChange == -1);

%ignore the first posture set index as it is when robotFlag goes from
%initialized to moving, not moving to set
postureSetIndex = postureSetIndex(2:end);

forceChange = motorFlag(2:end) - motorFlag(1:end-1);
forceSetIndex = find(forceChange == 1);

%ignore the first force set index as it is when the motorFlag goes from
%initialized to adjusting, not adjusting to set
forceSetIndex = forceSetIndex(2:end);
forceUnsetIndex = find(forceChange == -1);

postureForceMap = zeros(length(postureUnsetIndex),50,2);

for i = 1 : length(postureUnsetIndex)
    a = (forceSetIndex > postureSetIndex(i) & forceSetIndex < postureUnsetIndex(i));
    b = (forceUnsetIndex > postureSetIndex(i) & forceUnsetIndex < postureUnsetIndex(i));
    c = vertcat(forceUnsetIndex(b),postureUnsetIndex(i));
    postureForceMap(i,:,:) = [forceSetIndex(a), c];
end

x = size(postureForceMap);
numPostures = x(1);

%posture averages stores
postureAverages = zeros(numPostures, 50, 9);

for i = 1 : numPostures
   for j = 1 : 50
      measuredM0 = data1(postureForceMap(i,j,1):postureForceMap(i,j,2),2);
      avgM0 = mean(measuredM0);
      postureAverages(i, j, 1) = avgM0;
      
      measuredM1 = data1(postureForceMap(i,j,1):postureForceMap(i,j,2),4);
      avgM1 = mean(measuredM1);
      postureAverages(i, j, 2) = avgM1;
      
      measuredM2 = data1(postureForceMap(i,j,1):postureForceMap(i,j,2),6);
      avgM2 = mean(measuredM2);
      postureAverages(i, j, 3) = avgM2;
      
      measuredF0 = data1(postureForceMap(i,j,1):postureForceMap(i,j,2),10);
      avgF0 = mean(measuredF0);
      postureAverages(i, j, 4) = avgF0;
      
      measuredF1 = data1(postureForceMap(i,j,1):postureForceMap(i,j,2),11);
      avgF1 = mean(measuredF1);
      postureAverages(i, j, 5) = avgF1;
      
      measuredF2 = data1(postureForceMap(i,j,1):postureForceMap(i,j,2),12);
      avgF2 = mean(measuredF2);
      postureAverages(i, j, 6) = avgF2;
      
      measuredF3 = data1(postureForceMap(i,j,1):postureForceMap(i,j,2),13);
      avgF3 = mean(measuredF3);
      postureAverages(i, j, 7) = avgF3;
      
      measuredF4 = data1(postureForceMap(i,j,1):postureForceMap(i,j,2),14);
      avgF4 = mean(measuredF4);
      postureAverages(i, j, 8) = avgF4;
      
      measuredF5 = data1(postureForceMap(i,j,1):postureForceMap(i,j,2),15);
      avgF5 = mean(measuredF5);
      postureAverages(i, j, 9) = avgF5;
   end
end

save data/postureAverages postureAverages