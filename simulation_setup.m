%% Set up simulation workspace
WS = Workspace();
WS.gamma_comp = 1.4;
WS.gamma_turb = 1.3;
WS.gamma_reheat = WS.gamma_turb * WS.gamma_turb / WS.gamma_comp;
WS.cp = 1005;
WS.cpe = 1300;

%Fuel Values
LCV = 43.124e6;

%Simulation time step
WS.delta_T = 0.02;
WS.Sim_time = 600;
WS.Sim_point = 1;

%Simulation tracker
total_sim_points = WS.Sim_time/WS.delta_T + 1;
WS.Tracker = zeros(total_sim_points, 10);
WS.total_sim_points = total_sim_points;

%Set initial values
NH_0 = 25000;
NL_0 = 12000;
P02_0 = 1e5;
P025_0 = 4.5e5;
mdot3_0 = 71.43;
mdot2_0 = 100;
T04_0 = 1700;
Fg = 0;
mdot_f = 0;
mdot_f_reheat = 0;
WS.Tracker(1,:) = [NH_0 NL_0 P02_0 P025_0 mdot3_0 mdot2_0 T04_0 Fg mdot_f mdot_f_reheat];

%% Set up Scenario
this_scenario = Scenario();
% User Points contains the timestamped points for engine conditions in the
% form:
% [Simulation Time, Throttle Setting, P02, T02]
this_scenario.User_Points = ...
    [0.00,  50,  1e5, 293;...
     10.00, 50,  1e5, 293;...
     10.50, 80, 1e5, 293;...
     60.00, 80, 1e5, 293;...
     62.00, 50, 1e5, 293;...
     300.00,50, 1e5, 293;...
     301.00,20, 1e5, 293;...
     305.00,20, 1e5, 293;...
     305.50,100,1e5, 293;...
     320.00,100,1e5, 293;...
     321.00,70, 1e5, 293;...
     450.00,70, 1e5, 293;...
     451.00,100,1e5, 293;...
     600.00, 100,  1e5, 293];

% Point_Scenario contains the control parameters for the engine
% operation in the form:
% [Sim_point, Sim_time, NH_Demand, P02, T02]
this_scenario.Point_Scenario = zeros(total_sim_points, 5);
this_scenario.Points_fill(WS, HP);

% Step points
WS.Step_time =30;
this_scenario.Step_Points = ...
    [0.00,  50,  1e5, 293;...
     10.00, 50,  1e5, 293;...
     10.02, 100, 1e5, 293;...
     20.00, 100, 1e5, 293;...
     20.02, 50,  1e5, 293;...
     30.00, 50,  1e5, 293];

 this_scenario.Step_Scenario = zeros(WS.Step_time/WS.delta_T + 1, 5);
 this_scenario.Step_fill(WS, HP);
 