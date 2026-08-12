%% Read data

clc;
clear;


%Scenario i

i_RISpose = readmatrix("Scenario_i\a_DynamicRIS\Flight1\Scenario_i_DynamicRIS_MCS_RISPose_Flight1.csv","Range","A2:G5000");
i_DynamicRIS = readmatrix("Scenario_i\a_DynamicRIS\Flight1\Scenario_i_DynamicRIS_VNA_Magnitudes_Flight1.csv","Range","A2:G5000");
i_StaticRIS = readmatrix("Scenario_i\b_StaticRIS\Flight1\Scenario_i_StaticRIS_VNA_Magnitudes_Flight1.csv","Range","A2:G5000");
i_OffRIS = readmatrix("Scenario_i\c_OffRIS\Flight1\Scenario_i_OffRIS_VNA_Magnitudes_Flight1.csv","Range","A2:G5000");

%Scenario ii

ii_RISpose = readmatrix("Scenario_ii\a_DynamicRIS\Flight1\Scenario_ii_DynamicRIS_MCS_RISPose_Flight1.csv","Range","A2:G5000");
ii_DynamicRIS = readmatrix("Scenario_ii\a_DynamicRIS\Flight1\Scenario_ii_DynamicRIS_VNA_Magnitudes_Flight1.csv","Range","A2:G5000");
ii_StaticRIS = readmatrix("Scenario_ii\b_StaticRIS\Flight1\Scenario_ii_StaticRIS_VNA_Magnitudes_Flight1.csv","Range","A2:G5000");
ii_OffRIS = readmatrix("Scenario_ii\c_OffRIS\Flight1\Scenario_ii_OffRIS_VNA_Magnitudes_Flight1.csv","Range","A2:G5000");

%Scenario iii

iii_RISpose = readmatrix("Scenario_iii\a_DynamicRIS\Flight1\Scenario_iii_DynamicRIS_MCS_RISPose_Flight1.csv","Range","A2:G5000");
iii_DynamicRIS = readmatrix("Scenario_iii\a_DynamicRIS\Flight1\Scenario_iii_DynamicRIS_VNA_Magnitudes_Flight1.csv","Range","A2:G5000");
iii_StaticRIS = readmatrix("Scenario_iii\b_StaticRIS\Flight1\Scenario_iii_StaticRIS_VNA_Magnitudes_Flight1.csv","Range","A2:G5000");
iii_OffRIS = readmatrix("Scenario_iii\c_OffRIS\Flight1\Scenario_iii_OffRIS_VNA_Magnitudes_Flight1.csv","Range","A2:G5000");

%% Plot Results

t = 0:0.02:(10-0.02);
t_filt = 0:0.04:(10-0.04);

fontsize_plots = 12;
line_width_plots = 1.5;

figure
tlo = tiledlayout(4,3,...
    'TileSpacing','compact',...
    'Padding','compact');

% ---------------------------------------------------------
% Scenario (i)
% ---------------------------------------------------------

nexttile([2 1])
hold on

title('Scenario (i)','Interpreter','latex');

plot(t,i_DynamicRIS(:,2),...
    "LineWidth",line_width_plots,...
    "Color",[0.4660 0.6740 0.1880]);

plot(t,i_StaticRIS(:,2),...
    "LineWidth",line_width_plots,...
    "Color",[194 24 91]/255);

plot(t,i_OffRIS(:,2),...
    "LineWidth",line_width_plots,...
    "Color",[0.4940 0.1840 0.5560]);

grid on
ylim([-90 -42.5])

ylabel('S21 Parameter [dB]',...
    'Interpreter','latex');

set(gca,...
    'TickLabelInterpreter','latex',...
    'FontSize',fontsize_plots);

xticklabels([])

box on
hold off

% ---------------------------------------------------------
% Scenario (ii)
% ---------------------------------------------------------

nexttile([2 1])
hold on

title('Scenario (ii)','Interpreter','latex');

plot(t,ii_DynamicRIS(:,2),...
    "LineWidth",line_width_plots,...
    "Color",[0.4660 0.6740 0.1880]);

plot(t,ii_StaticRIS(:,2),...
    "LineWidth",line_width_plots,...
    "Color",[194 24 91]/255);

plot(t,ii_OffRIS(:,2),...
    "LineWidth",line_width_plots,...
    "Color",[0.4940 0.1840 0.5560]);

grid on
ylim([-90 -42.5])

set(gca,...
    'TickLabelInterpreter','latex',...
    'FontSize',fontsize_plots);

xticklabels([])

box on
hold off

% ---------------------------------------------------------
% Scenario (iii)
% ---------------------------------------------------------

nexttile([2 1])
hold on

title('Scenario (iii)','Interpreter','latex');

plot(t,iii_DynamicRIS(:,2),...
    "LineWidth",line_width_plots,...
    "Color",[0.4660 0.6740 0.1880]);

plot(t,iii_StaticRIS(:,2),...
    "LineWidth",line_width_plots,...
    "Color",[194 24 91]/255);

plot(t,iii_OffRIS(:,2),...
    "LineWidth",line_width_plots,...
    "Color",[0.4940 0.1840 0.5560]);

legend('(a) Dynamic RIS',...
       '(b) Static RIS',...
       '(c) Off RIS',...
       'Location','southeast',...
       'Interpreter','latex');

grid on
ylim([-90 -42.5])

set(gca,...
    'TickLabelInterpreter','latex',...
    'FontSize',fontsize_plots);

xticklabels([])

box on
hold off

% ---------------------------------------------------------
% Attitude Scenario (i)
% ---------------------------------------------------------

nexttile
hold on

plot(t,i_RISpose(:,2),...
    "LineWidth",line_width_plots,...
    "Color",[0.0000 0.4470 0.7410]);

plot(t,i_RISpose(:,3),...
    "LineWidth",line_width_plots,...
    "Color",[0.8500 0.3250 0.0980]);

plot(t,i_RISpose(:,4),...
    "LineWidth",line_width_plots,...
    "Color",[0.9290 0.6940 0.1250]);

ylim([-0.15 0.15])

ylabel('Attitude [rad]',...
    'Interpreter','latex',...
    'Color',[0.15 0.15 0.15]);

set(gca,...
    'TickLabelInterpreter','latex',...
    'FontSize',fontsize_plots);

xticklabels([])

grid on
box on
hold off

% ---------------------------------------------------------
% Attitude Scenario (ii)
% ---------------------------------------------------------

nexttile
hold on

plot(t,ii_RISpose(:,2),...
    "LineWidth",line_width_plots,...
    "Color",[0.0000 0.4470 0.7410]);

plot(t,ii_RISpose(:,3),...
    "LineWidth",line_width_plots,...
    "Color",[0.8500 0.3250 0.0980]);

plot(t,ii_RISpose(:,4),...
    "LineWidth",line_width_plots,...
    "Color",[0.9290 0.6940 0.1250]);

ylim([-0.15 0.15])

set(gca,...
    'TickLabelInterpreter','latex',...
    'FontSize',fontsize_plots);

xticklabels([])

grid on
box on
hold off

% ---------------------------------------------------------
% Attitude Scenario (iii)
% ---------------------------------------------------------

nexttile
hold on

plot(t,iii_RISpose(:,2),...
    "LineWidth",line_width_plots,...
    "Color",[0.0000 0.4470 0.7410]);

plot(t,iii_RISpose(:,3),...
    "LineWidth",line_width_plots,...
    "Color",[0.8500 0.3250 0.0980]);

plot(t,iii_RISpose(:,4),...
    "LineWidth",line_width_plots,...
    "Color",[0.9290 0.6940 0.1250]);

ylim([-0.15 0.15])

legend('$\Phi_{\mathrm{RIS}}$',...
       '$\Theta_{\mathrm{RIS}}$',...
       '$\Psi_{\mathrm{RIS}}$',...
       'Location','southeast',...
       'Interpreter','latex');

set(gca,...
    'TickLabelInterpreter','latex',...
    'FontSize',fontsize_plots);

xticklabels([])

grid on
box on
hold off

% ---------------------------------------------------------
% Position Scenario (i)
% ---------------------------------------------------------

nexttile
hold on

plot(t,i_RISpose(:,5),...
    "LineWidth",line_width_plots,...
    "Color",[0.0000 0.4470 0.7410],...
    "LineStyle",":");

plot(t,i_RISpose(:,6),...
    "LineWidth",line_width_plots,...
    "Color",[0.8500 0.3250 0.0980],...
    "LineStyle",":");

plot(t,i_RISpose(:,7),...
    "LineWidth",line_width_plots,...
    "Color",[0.9290 0.6940 0.1250],...
    "LineStyle",":");

ylabel('Position [m]',...
    'Interpreter','latex',...
    "Color",[0.15 0.15 0.15]);

xlabel('time [s]','Interpreter','latex');

ylim([-0.3 2.3])

set(gca,...
    'TickLabelInterpreter','latex',...
    'FontSize',fontsize_plots);

grid on
box on
hold off

% ---------------------------------------------------------
% Position Scenario (ii)
% ---------------------------------------------------------

nexttile
hold on

plot(t,ii_RISpose(:,5),...
    "LineWidth",line_width_plots,...
    "Color",[0.0000 0.4470 0.7410],...
    "LineStyle",":");

plot(t,ii_RISpose(:,6),...
    "LineWidth",line_width_plots,...
    "Color",[0.8500 0.3250 0.0980],...
    "LineStyle",":");

plot(t,ii_RISpose(:,7),...
    "LineWidth",line_width_plots,...
    "Color",[0.9290 0.6940 0.1250],...
    "LineStyle",":");

xlabel('time [s]','Interpreter','latex');

ylim([-0.3 2.3])

set(gca,...
    'TickLabelInterpreter','latex',...
    'FontSize',fontsize_plots);

grid on
box on
hold off

% ---------------------------------------------------------
% Position Scenario (iii)
% ---------------------------------------------------------

nexttile
hold on

plot(t,iii_RISpose(:,5),...
    "LineWidth",line_width_plots,...
    "Color",[0.0000 0.4470 0.7410],...
    "LineStyle",":");

plot(t,iii_RISpose(:,6),...
    "LineWidth",line_width_plots,...
    "Color",[0.8500 0.3250 0.0980],...
    "LineStyle",":");

plot(t,iii_RISpose(:,7),...
    "LineWidth",line_width_plots,...
    "Color",[0.9290 0.6940 0.1250],...
    "LineStyle",":");

xlabel('time [s]','Interpreter','latex');

ylim([-0.3 2.3])

legend('$x_{\mathrm{RIS}}$',...
       '$y_{\mathrm{RIS}}$',...
       '$z_{\mathrm{RIS}}$',...
       'Location','southeast',...
       'Interpreter','latex');

set(gca,...
    'TickLabelInterpreter','latex',...
    'FontSize',fontsize_plots);

grid on
box on
hold off

