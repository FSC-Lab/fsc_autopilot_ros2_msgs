# Reference (x*, u*) for the torque-mode (R)CCM pipeline.
#
#   fsc_trajectory_planner  (quadrotor_ccm_planner)            publishes
#   torch_model_loader      (CCM_torque_direct)                 builds the model inputs xref / uref
#   fsc_autopilot_ros2      (single_drone_ccm_direct_actuation) validates the tracking error
#
# World frame ENU, body frame FLU, SI units. One message carries a complete, time-consistent
# sample, so the state and input references can never come from different ticks.

uint8 PHASE_IDLE=0        # nothing planned (the planner does not publish in this phase)
uint8 PHASE_HOLD=1        # hover at the captured / final point
uint8 PHASE_RUNNING=2     # flying the selected trajectory
uint8 PHASE_FINISHED=3    # trajectory complete, holding its final point
uint8 PHASE_TRANSITION=4  # rest-to-rest move (fly to the trajectory start / back to hover)

std_msgs/Header header    # stamp = time the sample was generated; frame_id "map"
uint8 phase
string trajectory         # "hover", "circle", "figure8", "transition"
float64 t                 # trajectory time since start [s] (0 while holding)

# Rigid-body reference state x*
geometry_msgs/Point position          # p* [m], ENU
geometry_msgs/Vector3 velocity        # v* [m/s], ENU
geometry_msgs/Vector3 acceleration    # p*'' [m/s^2], ENU (kinematic, gravity not included)
geometry_msgs/Quaternion orientation  # R*, body FLU -> world ENU
float64[9] rotation                   # R* row-major (the model's input layout; same as orientation)
geometry_msgs/Vector3 angular_velocity  # omega* [rad/s], body FLU
float64 yaw                           # psi* [rad]

# Reference wrench u* (the actual wrench along the reference)
float64 thrust                        # T* [N], along body +z
geometry_msgs/Vector3 torque          # tau* [N m], body FLU

# Reference COMMAND for models with first-order actuator dynamics
# (w_dot = (u - w) / tau_m):  u*_c = u* + tau_m * d(u*)/dt. Equal to (thrust, torque) when the
# planner's rotor_time_constant is 0.
float64 thrust_command                # [N]
geometry_msgs/Vector3 torque_command  # [N m], body FLU

# Disturbance acceleration folded into the flatness map (UDE estimate / mass); zero when unused.
geometry_msgs/Vector3 disturbance     # [m/s^2], ENU
# Angular-acceleration disturbance folded into the reference torque, tau* = J (omega*' - d_w) +
# omega* x J omega* (the flight node's velocity-based estimate); zero when unused.
geometry_msgs/Vector3 angular_disturbance  # [rad/s^2], body FLU
