%-------------------------------------------------------------------------%
%----------------------------Pre-Setting----------------------------------%
%-------------------------------------------------------------------------%

% Cleaning Up
close all; clear; clc;
s = zpk(0,[],1); % setting object 's' in order to write intuitive functions
ramp = 1/s;
t = 0:0.1:20; % time stamp

%-------------------------------------------------------------------------%
%------------------------Setting Study Case-------------------------------%
%-------------------------------------------------------------------------%

IMPUT_SIGNAL_RAMP = true;


% Specify an arbitrary transfer function
G_plant  = 1/((s)*(s+3)*(s+5));
% Specify an arbitrary feedback transfer function
H  = 1;
% Specify the transfer function of your compensator
G_compc = (s + 0.3)/(s+0.03)

% Special parameters
k   = 27.9948; % Select Gain of interest
OP_ = 0; % Overshoot Percentage (put as X %)
C_  = 0; % Dumping Factor 0 < C_ < 1
t_  = 0; % Time constant

%-------------------------------------------------------------------------%
%-----------------------------Procedure-----------------------------------%
%-------------------------------------------------------------------------%

if H == 1
    % % Generating Open Loop Locus-Root Diagram: 
    % rlocus(G_plant);
    % grid on;
    % figure;

    % Searching for specifc Gain based on OP_value
    if ((k == 0) && (OP_ > 0))
        k = 1;
        G_fb = feedback(G_plant,k);
        G_fb_step = stepinfo(G_fb);
        while (G_fb_step.Overshoot < OP_)
            k = k + 0.01;
            G_fb = feedback(G_plant,k);
            G_fb_step = stepinfo(G_fb);
        end
        found_msg = "Found K = ";
        disp(found_msg);
        disp(k);
    end
    
    % Print Input
    if IMPUT_SIGNAL_RAMP == true
        step(ramp,t);
        hold on;
    end
   
    % Step Response for Closed Loop tranfer function, no compensation
    if ((k > 0) && (OP_ == 0))
        G_plant = G_plant*k
        G_fb = feedback(G_plant,1)
    end
    if IMPUT_SIGNAL_RAMP == true
        G_fb = G_fb*ramp;
    end
    step(G_fb);
    grid on;
    hold on;
      
    % Step Response for Closed Loop Compensator
    Gc = G_compc * G_plant;
    Gc_fb = feedback(Gc,1)
    if IMPUT_SIGNAL_RAMP == true
        Gc_fb = Gc_fb*ramp;
    end
    step(Gc_fb);
    hold on;
    
    %Print information 
    if IMPUT_SIGNAL_RAMP == false
        G_fb_step = stepinfo(G_fb);
        Gc_fb_step = stepinfo(Gc_fb);
        G_fb_step 
        Gc_fb_step
    end
    
end



