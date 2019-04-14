%-------------------------------------------------------------------------%
%----------------------------Pre-Setting----------------------------------%
%-------------------------------------------------------------------------%

% Cleaning Up
close all; clear; clc;
% setting object 's' in order to write intuitive functions
s = zpk(0,[],1);
LOADING_ = "."

%-------------------------------------------------------------------------%
%------------------------Setting Study Case-------------------------------%
%-------------------------------------------------------------------------%

% Specify an arbitrary transfer function
G  = 1/((s+2)*(s+3)*(s+7));
% Specify an arbitrary feedback transfer function
H  = 1;

% Special parameters
k   = 0; % Select Gain of interest
OP_ = 10; % Overshoot Percentage (put as X %)
C_  = 0; % Dumping Factor 0 < C_ < 1
t_  = 0; % Time constant

%-------------------------------------------------------------------------%
%-----------------------------Procedure-----------------------------------%
%-------------------------------------------------------------------------%

if H == 1
    % % Generating Open Loop Locus-Root Diagram: 
    % rlocus(G);
    % grid on;
    % figure;

    % Applying feedback and Gain, if there is one
    if ((k > 0) && (OP_ == 0))
        G_f1 = feedback(G,k);
    end
    % Searching for specifc Gain based on OP_value
    if ((k == 0) && (OP_ > 0))
        k = 1;
        G_f1 = feedback(G,k);
        get_step = stepinfo(G_f1);
        while (get_step.Overshoot < OP_)
            k = k + 0.01;
            G_f1 = feedback(G,k);
            get_step = stepinfo(G_f1);
        end
        found_msg = "Found K = ";
        disp(found_msg);
        disp(k);
    end

    % Step Response for Closed Loop tranfer function
    step(G_f1);
    get_step = stepinfo(G_f1);
    grid on;
    
    %Print information 
    get_step
end



