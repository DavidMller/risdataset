import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

# %% Read data

def read_matrix(path):
    df = pd.read_csv(
        path,
        header=None,
        skiprows=1,
        nrows=4999
    )
    return df.iloc[:, :7].to_numpy()

# Scenario i
i_RISpose   = read_matrix(r"Scenario_i\a_DynamicRIS\Flight1\Scenario_i_DynamicRIS_MCS_RISPose_Flight1.csv")
i_ActiveRIS = read_matrix(r"Scenario_i\a_DynamicRIS\Flight1\Scenario_i_DynamicRIS_VNA_Magnitudes_Flight1.csv")
i_StaticRIS = read_matrix(r"Scenario_i\b_StaticRIS\Flight1\Scenario_i_StaticRIS_VNA_Magnitudes_Flight1.csv")
i_OffRIS    = read_matrix(r"Scenario_i\c_OffRIS\Flight1\Scenario_i_OffRIS_VNA_Magnitudes_Flight1.csv")

# Scenario ii
ii_RISpose   = read_matrix(r"Scenario_ii\a_DynamicRIS\Flight1\Scenario_ii_DynamicRIS_MCS_RISPose_Flight1.csv")
ii_ActiveRIS = read_matrix(r"Scenario_ii\a_DynamicRIS\Flight1\Scenario_ii_DynamicRIS_VNA_Magnitudes_Flight1.csv")
ii_StaticRIS = read_matrix(r"Scenario_ii\b_StaticRIS\Flight1\Scenario_ii_StaticRIS_VNA_Magnitudes_Flight1.csv")
ii_OffRIS    = read_matrix(r"Scenario_ii\c_OffRIS\Flight1\Scenario_ii_OffRIS_VNA_Magnitudes_Flight1.csv")

# Scenario iii
iii_RISpose   = read_matrix(r"Scenario_iii\a_DynamicRIS\Flight1\Scenario_iii_DynamicRIS_MCS_RISPose_Flight1.csv")
iii_ActiveRIS = read_matrix(r"Scenario_iii\a_DynamicRIS\Flight1\Scenario_iii_DynamicRIS_VNA_Magnitudes_Flight1.csv")
iii_StaticRIS = read_matrix(r"Scenario_iii\b_StaticRIS\Flight1\Scenario_iii_StaticRIS_VNA_Magnitudes_Flight1.csv")
iii_OffRIS    = read_matrix(r"Scenario_iii\c_OffRIS\Flight1\Scenario_iii_OffRIS_VNA_Magnitudes_Flight1.csv")

# %% Plot Results

t = np.arange(0, 10, 0.02)
t_filt = np.arange(0, 10, 0.04)

fontsize_plots = 12
line_width_plots = 1.5

plt.rcParams['text.usetex'] = False
plt.rcParams['font.size'] = fontsize_plots

fig, axes = plt.subplots(3, 3, figsize=(24, 12),
                          gridspec_kw={'height_ratios': [1, 0.5, 0.5]})
fig.subplots_adjust(hspace=0.15, wspace=0.15)

scenarios = [
    ("Scenario (i)", i_ActiveRIS, i_StaticRIS, i_OffRIS, i_RISpose),
    ("Scenario (ii)", ii_ActiveRIS, ii_StaticRIS, ii_OffRIS, ii_RISpose),
    ("Scenario (iii)", iii_ActiveRIS, iii_StaticRIS, iii_OffRIS, iii_RISpose),
]

color_active = [0.4660, 0.6740, 0.1880]
color_static = [194/255, 24/255, 91/255]
color_off = [0.4940, 0.1840, 0.5560]

color_phi = [0.0000, 0.4470, 0.7410]
color_theta = [0.8500, 0.3250, 0.0980]
color_psi = [0.9290, 0.6940, 0.1250]

for col, (title, active, static, off, risp) in enumerate(scenarios):

    # ---------------------------------------------------------
    # S21 Magnitude Plot
    # ---------------------------------------------------------

    ax = axes[0, col]
    ax.plot(t, active[:, 1], linewidth=line_width_plots, color=color_active)
    ax.plot(t, static[:, 1], linewidth=line_width_plots, color=color_static)
    ax.plot(t, off[:, 1], linewidth=line_width_plots, color=color_off)

    ax.set_title(title)
    ax.grid(True)
    ax.set_ylim([-90, -42.5])
    ax.set_xticklabels([])
    ax.tick_params(labelsize=fontsize_plots)

    if col == 0:
        ax.set_ylabel('S21 Parameter [dB]')

    if col == 2:
        ax.legend(['(a) Dynamic RIS', '(b) Static RIS', '(c) Off RIS'],
                   loc='lower right')

    # ---------------------------------------------------------
    # Attitude Plot
    # ---------------------------------------------------------

    ax_att = axes[1, col]
    ax_att.plot(t, risp[:, 1], linewidth=line_width_plots, color=color_phi)
    ax_att.plot(t, risp[:, 2], linewidth=line_width_plots, color=color_theta)
    ax_att.plot(t, risp[:, 3], linewidth=line_width_plots, color=color_psi)
    ax_att.set_ylim([-0.15, 0.15])
    ax_att.set_xticklabels([])
    ax_att.grid(True)
    ax_att.tick_params(labelsize=fontsize_plots)

    if col == 0:
        ax_att.set_ylabel('Attitude [rad]', color=[0.15, 0.15, 0.15])

    if col == 2:
        ax_att.legend([r'$\Phi_{\mathrm{RIS}}$', r'$\Theta_{\mathrm{RIS}}$', r'$\Psi_{\mathrm{RIS}}$'],
                       loc='lower right')

    # ---------------------------------------------------------
    # Position Plot
    # ---------------------------------------------------------

    ax_pos = axes[2, col]
    ax_pos.plot(t, risp[:, 4], linewidth=line_width_plots, color=color_phi, linestyle=':')
    ax_pos.plot(t, risp[:, 5], linewidth=line_width_plots, color=color_theta, linestyle=':')
    ax_pos.plot(t, risp[:, 6], linewidth=line_width_plots, color=color_psi, linestyle=':')
    ax_pos.set_ylim([-0.3, 2.3])
    ax_pos.set_xlabel('time [s]')
    ax_pos.grid(True)
    ax_pos.tick_params(labelsize=fontsize_plots)

    if col == 0:
        ax_pos.set_ylabel('Position [m]', color=[0.15, 0.15, 0.15])

    if col == 2:
        ax_pos.legend([r'$x_{\mathrm{RIS}}$', r'$y_{\mathrm{RIS}}$', r'$z_{\mathrm{RIS}}$'],
                       loc='lower right')

plt.show()