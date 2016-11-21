%Header
%Time(1), Measured M0(2), Command M0(3), Measured M1(4), Command M1(5),
%Measured M2(6),Command M2(7), Angle 0(8), Angle 1(9), Sensor 0(10),
%Sensor 1(11), Sensor 2(12), Sensor 3(13), Sensor 4 (14), Sensor 5 (15),
%Robot Flag(16), Motor Flag(17), AdeptX(18), AdeptY (19)
load data/postureAverages

s = size(postureAverages);
numPostures = s(1);

for i = 1 : numPostures
    muscleForceVector = squeeze(postureAverages(i,:,1:3));
    
    f0ForceVector = postureAverages(i,:,4)';
    f0CVector = muscleForceVector\f0ForceVector;
    f0PredictedForceVector = muscleForceVector*f0CVector;
    
    f1ForceVector = postureAverages(i,:,5)';
    f1CVector = muscleForceVector\f1ForceVector;
    f1PredictedForceVector = muscleForceVector*f1CVector;
    
    f2ForceVector = postureAverages(i,:,6)';
    f2CVector = muscleForceVector\f2ForceVector;
    f2PredictedForceVector = muscleForceVector*f2CVector;
    
    f3ForceVector = postureAverages(i,:,7)';
    f3CVector = muscleForceVector\f3ForceVector;
    f3PredictedForceVector = muscleForceVector*f3CVector;
    
    f4ForceVector = postureAverages(i,:,8)';
    f4CVector = muscleForceVector\f4ForceVector;
    f4PredictedForceVector = muscleForceVector*f4CVector;
    
    f5ForceVector = postureAverages(i,:,9)';
    f5CVector = muscleForceVector\f5ForceVector;
    f5PredictedForceVector = muscleForceVector*f5CVector;
end
%%
plot(f5ForceVector);
hold on;
plot(f5PredictedForceVector);
hold on;
plot(f5ForceVector - f5PredictedForceVector);
legend('Actuals','Predicted','Residuals');

%meshgrid to define x and y axis
%surf to plot surface (contribution of m on endpoint force x as a function
%of posture/thetas)
