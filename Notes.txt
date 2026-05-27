All attitude and position information are provided in the NWU frame.
All experiments are conducted in a flight lab under the same environmental conditions.
We consider three scenarios with varying Tx, Rx, and UAV-mounted RIS locations to capture both optimal and non ideal relative geometries.
This accounts for practical deployment conditions, where a UAV-mounted RIS cannot always be positioned optimally with respect to the Tx and Rx.
We are treating hover flight in all scenarios, i.e. the UAV is commanded to maintain a fixed target position using guided mode\footnote{https://ardupilot.org/copter/docs/ac2\_guidedmode.html}.
We restart the UAV and calibrate the IMUs on the flight controller before every flight to ensure the same initial conditions.
In the first scenario (i), the UAV-mounted RIS is positioned at the midpoint of the direct link between Tx and Rx.
The target position of the UAV-mounted RIS is set to $(0,0,2)$. The Tx and Rx are located at $(-1.36,0,0.7)$ and $(1.34,0,0.7)$, respectively.
In the second scenario (ii), the UAV-mounted RIS is positioned directly above the Rx, with the target position set to $(1.2,0,2)$. The Tx and Rx are located at $(-1.36,0,0.66)$ and $(1.55,0,0.75)$, respectively.
In the third scenario (iii) the UAV-mounted RIS is not deployed along the direct path between Tx and Rx.
Similar to scenario (i), the target position of the UAV-mounted RIS is set to $(0,0,2)$. The Tx and Rx are positioned at $(-1.55,0.75,0.7)$ and $(1.65,0.77,0.69)$, respectively.
In each scenario, the Tx and Rx are oriented towards the target position of the UAV-mounted RIS.
All scenarios are schematically illustrated in Fig.~\ref{fig:scenarios}.

------------------------------------------------------------------------------

We measure the performance of the UAV-mounted RIS for three different RIS configurations in each scenario.
For each configuration, two flights are conducted, resulting in a total of six flights per scenario.
The first RIS configuration is obtained by continuously updating the RIS according to the optimal phase profile, computed based on the most recent UAV's EKF estimate using the optimization in Sec.~\ref{sec:OPtimization}.
The update is performed at the RIS frequency of \SI{50}{\hertz}.
The second configuration is determined by solving \eqref{eq:optProblem} once prior to flight for the respective target position.
The RIS configuration is then kept constant throughout the entire flight.
For the third configuration, the RIS is deactivated, i.e., no phase shifts are applied to the reflecting elements.
This effectively corresponds to a passive metallic reflector.

Configurations are given as a binary vector. // Leave space for adding Information About vector to Hardware mapping

------------------------------------------------------------------------------

Hardware Overview:

Holybro X500 Quadcopter:

The UAV carrying the RIS is a customized Holybro X500 Quadcopter with a rotor-to-rotor diameter of 500\si{\milli\meter} (see Fig.~\ref{fig:UAVSetup}). It can carry payload of up to 1\si{\kilogram} and is controlled by a Pixhawk Cube Orange flight controller.
The flight controller holds three different inertial measurement units (IMU), where three IMUs are used for redundancy (the primary IMU is a ICM20602, the secondary one a ICM20948 and the third one a ICM20649\footnote{https://ardupilot.org/copter/docs/common-thecubeorange-overview.html}).
The primary and secondary IMUs are mounted on a separate temperature-controlled, vibration-isolated board, while the third IMU is located directly on the flight controller.
The open-source software ArduPilot\footnote{https://ardupilot.org/} (V4.6.3) is installed on the flight controller, running an individual EKF for every IMU.
This enables the UAV to use lane-switching, a transition between multiple EKFs in case variances exceed a certain threshold\footnote{https://ardupilot.org/dev/docs/common-ek3-affinity-lane-switching.html}. The active EKF is selected in the same order as the IMUs.
Three different IMUs are installed on the flight controller, as they have different frequency responses and will therefore respond differently to vibrations\footnote{https://docs.cubepilot.org/user-guides/autopilot/the-cube-module-overview}.
We tuned filter parameters for better filtering of vibrations by running an in-flight Fast Fourier Transform on the UAV and analyzing spectra for characteristic frequencies.
Measurements of the IMU are then fused with other sensors by the EKF.

Since the experiments are conducted inside a laboratory, GNSS position information are not available. To enable autonomous indoor flight, we replace the position measurements received by the GNSS antenna with position measurements from a Motion Capture System (MCS).
We use an ESP8266 microcontroller connected to the flight controller running MAVESP8266\footnote{https://github.com/BeyondRobotix/mavesp8266} firmware to send the position information via an additional WiFi connection to the UAV during flight.
The EKF processes the MCS measurements with a frequency of \SI{5}{\hertz}, equivalent to the nominal GNSS update rate.
Details on the MCS are provided in Sec.~\ref{sec:DataCollection}.
Similar to real-time kinematic (RTK) GNSS setups, we also substitute the on-board barometer and magnetometer measurements with MCS measurements.
Indoor laboratory environments typically degrade barometric altitude measurements and introduce substantial magnetic disturbances caused by reinforced concrete structures, compromising reliable state estimation.

\begin{figure}[ht]
	\centering
	\includegraphics[width=1\linewidth] {figures/UAVSetup6.pdf}
	\caption{Left: RIS prototype and its dimensions. Right: RIS prototype mounted to a customized Holybro X500. Orange dots are representing the origin of the UAV’s body frame (top) and the center of the RIS (bottom). \textcolor{red}{Eigenplagiat}}
	\label{fig:UAVSetup}
\end{figure}

The RIS is mounted under the UAV, where its center is located $l_{\mathrm{RIS}_z} = 265$\si{\milli\meter} underneath the origin of the UAV's body frame (see Fig.~\ref{fig:UAVSetup}), with no offsets in the $x$-$y$-plane.
The Raspberry Pi is mounted on top of the UAV, with almost no vertical offset, and no offsets in the $x$-$y$-plane.

RIS:

The RIS prototype has dimensions of 20$\times$\SI{16}{\centi\meter} and consists of $M = 120$ elements arranged in a 10$\times$12 array (see Fig.~\ref{fig:UAVSetup}).
Each element is equipped with a PIN diode to enable 1-bit discrete phase shifting.
The RIS is designed as a binary-switching surface with a \SI{180}{\degree} phase shift at the designed carrier frequency of $\nu=5.385$\si{\giga\hertz}.
During phase shifting, the reflected signal experiences a \SI{3}{\deci\bel} attenuation due to hardware impairments in the phase-shifting circuitry.
We use a Raspberry Pi 4B as the RIS controller, which is connected to the RIS via a serial port with a baud rate of 115200 Bd.
The maximum reconfiguration rate of the RIS, i.e., the frequency at which the elements’ phase shifts can be updated, is \SI{50}{\hertz}.

VNA:

To validate the performance of the UAV-mounted RIS during the experiments, we use a vector network analyzer (VNA) of type Keysight P5026B equipped with the S9010B software option, which enables time-gating to isolate the signal component only reflected by the RIS. Specifically, a time gate spanning 61-71\si{\nano\second} is applied, thereby suppressing undesired multipath components and extracting only the RIS-reflected contribution at the target position. The $\mathrm{S21}$ parameter is measured over a bandwidth of \SI{650}{\mega\hertz}, spanning from \SI{5.225}{\giga\hertz} to \SI{5.875}{\giga\hertz}, with 201 frequency points, providing a frequency-resolved characterization of the channel amplitude and phase response. The measurements are conducted in \SI{50}{\hertz} intervals to ensure synchronization with the RIS switching rate as well as the update rate of the EKF-based prediction algorithm, enabling temporally aligned channel acquisition. Two VNA ports serve as the transmitter and receiver, respectively, and are each connected to a directional horn antenna of type LB-187-15-C-SF (A-Info). Within the considered frequency range, the antenna gain is at least \SI{16.35}{\deci\bel i}.
\begin{figure}[t]
	\centering
	\includegraphics[width=1\linewidth] {figures/Dataset_Experiments1.pdf}
	\caption{Experimental setup for scenario (iii). Small image in the bottom right corner shows the placement of the motion capture cameras.}
	\label{fig:Experiments}
\end{figure}
The complete setup for the experiment in scenario (iii) is shown in Fig.~\ref{fig:Experiments}.

------------------------------------------------

Dataset Format:

Each file in the dataset contains timestamped values synchronized according to Sec.~\ref{sec:ProcessingData}. Corresponding timestamps are included in every file. For each \SI{10}{\second} flight segment, the data is sampled at a frequency of \SI{50}{\hertz}, resulting in 500 time steps per file.
Data is provided in the .csv format. 
The dataset is organized hierarchically by scenario, followed by the corresponding RIS configuration, and finally separated into Flight~1 and Flight~2 recordings.
The complete dataset structure is illustrated in Fig.~\ref{fig:hierarchy}.

%Info about evaluation frequency = design frequency?

To ensure a consistent naming convention, each file name encodes the scenario, the RIS configuration applied during the flight, the data source, and the type of recorded information.
In addition, the corresponding flight number is appended to each file name to avoid ambiguity.
For example, the file "Scenario\_iii\_StaticRIS\_EKF\_RISPose\_Flight1" contains data from scenario (iii) using the static RIS configuration (optimized prior to flight and then kept constant during flight). 
The data originates from the EKF and corresponds to the estimated RIS pose, which was determined according to Sec.~\ref{sec:Pose}. It includes both position and attitude information.
The suffix "Flight1" indicates that the data belongs to the first flight conducted for this scenario.
All units are specified in the respective file headers.
Note that in addition to the RIS pose estimates, the dataset also includes the UAV pose estimates together with the corresponding ground-truth measurements to facilitate broader analyses and reproducibility. This enables, for example, the simulation and evaluation of scenarios with larger offsets between the RIS center and the UAV center.

A special case is the file containing the RIS configuration data. To ensure an unambiguous assignment to each timestamp, the RIS configuration is represented as a binary row vector. Each entry corresponds to an individual RIS element, where a value of 0 indicates that the element is inactive, while a value of 1 denotes that the element applies a \SI{180}{\degree} phase shift to the incoming wavefront.
The mapping between the vector entries and the corresponding RIS elements is defined as follows:
\textcolor{red}{Explain ordering of RIS Numbers because we give them in one line, maybe need picture of back of RIS here}

\begin{figure}[t]
	\centering
	\includegraphics[width=0.8\linewidth] {figures/Structure2.pdf}
	\caption{Dataset file hierarchy.}
	\label{fig:hierarchy}
\end{figure}