%Header
%Time(1), Measured M0(2), Command M0(3), Measured M1(4), Command M1(5),
%Measured M2(6),Command M2(7), Angle 0(8), Angle 1(9), Sensor 0(10),
%Sensor 1(11), Sensor 2(12), Sensor 3(13), Sensor 4 (14), Sensor 5 (15),
%Robot Flag(16), Motor Flag(17), AdeptX(18), AdeptY (19)
load data/data1
time = data1(:,1);
robotFlag = data1(:,16);
motorFlag = data1(:,17);
%subplot(2,1,1)
%plot(time,robotFlag)
%subplot(2,1,2)
%plot(time,motorFlag)
%%
postureDurationRange = [200000;400000];
xCordinate = data1(:,18);
xCordiateDiff = xCordinate(2:end)-xCordinate(1:end-1);
adeptArmMoveIndex = find(~(xCordiateDiff==0));
postureDuration = adeptArmMoveIndex(2:end) - adeptArmMoveIndex(1:end-1);
postureOnset = [];
postureEnd = [];
for i = 1 : length(postureDuration)
    if (postureDuration(i)>postureDurationRange(1))&&(postureDuration(i)<postureDurationRange(2))
        postureOnset = [postureOnset;adeptArmMoveIndex(i)];
        postureEnd = [postureEnd;adeptArmMoveIndex(i+1)];
    end
end
%%
motorFlagDiff = motorFlag(2:end)-motorFlag(1:end-1);
ff= find(motorFlagDiff==1);