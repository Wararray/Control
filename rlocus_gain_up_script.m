%-------------------------------------------------------------------------%
%----------------------------Pre-Setting----------------------------------%
%-------------------------------------------------------------------------%

% Cleaning Up
close all; clear; clc;
% setting object 's' in order to write intuitive functions
s = zpk(0,[],1);

%-------------------------------------------------------------------------%
%------------------------Setting Study Case-------------------------------%
%-------------------------------------------------------------------------%

% Specify an arbitrary transfer function
G  = 1/((s+2)*(s+3)*(s+7));
k  = 0; % Select Gain of interest
OP = 0; % Overshoot Percentage (put as X %)
C_ = 0; % Dumping Factor 0 < C_ < 1
t_ = 0; % Time constant
%-------------------------------------------------------------------------%
%-----------------------------Procedure-----------------------------------%
%-------------------------------------------------------------------------%

% Generating Open Loop Locus-Root Diagram: 
rlocus(G);
grid on;
figure;

% Step Response for Open Loop tranfer function
step(G);
grid on;




% ylabel('Imaginary Axis');
% xlabel('Real Axis');

% Pick gain to mark on root locus
% gainToMark = 5;

% % The rlocus function can output the values normally plotted and the gains
% % associated with each value on the complex plane
% [complexVec,gainsVec] = rlocus(G);
% % Recall: the root locus is displayed on the complex plane (s = \sigma +
% % j*\omega)
% realPart = real(complexVec);
% imagPart = imag(complexVec);
% % First closed loop pole with increasing gain, K
% realCLpole1 = realPart(1,:);
% imagCLpole1 = imagPart(1,:);
% % Second closed loop pole with increasing gain, K
% realCLpole2 = realPart(2,:);
% imagCLpole2 = imagPart(2,:);
% % Plot the closed loop poles as varying with gain K
% plot(realCLpole1,imagCLpole1,realCLpole2,imagCLpole2);


% Plot open loop poles
% plot(realCLpole1(1),imagCLpole1(1),'bx'); hold on;
% plot(realCLpole2(1),imagCLpole2(1),'bx');
% % Plot open loop zeros
% plot(realCLpole1(end),imagCLpole1(end),'bo'); hold on;
% plot(realCLpole2(end),imagCLpole2(end),'bo');
% % Find the the location of the gain of interest on the root locus
% indexOfGain = find(gainsVec >= gainToMark,1,'first');
% markedGain = gainsVec(indexOfGain);
% % Form the closed-loop feedback system with selected gain
% CLsystem = feedback(G,markedGain);
% % Acquire step response values of interest from the closed-loop system
% stepResponse = stepinfo(CLsystem);
% percentOvershoot = stepResponse.Overshoot;
% % Plot test box with results onto plot
% gainString = ['Gain: ' num2str(markedGain)];
% osString   = ['%OS: ' num2str(percentOvershoot) ' %'];
% text(-2.25,1.5,gainString);
% text(-2.25,1.0,osString)
% % Plot closed-loop poles arising from feedback gain selection
% plot(realCLpole1(indexOfGain),imagCLpole1(indexOfGain),'r+');
% plot(realCLpole2(indexOfGain),imagCLpole2(indexOfGain),'r+');
% xlim([-10 2]); ylim([-4 4]);