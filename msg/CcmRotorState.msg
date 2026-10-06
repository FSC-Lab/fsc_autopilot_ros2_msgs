# State x of the ROTOR-THRUST (R)CCM pipeline: rigid body + the four actual rotor thrusts.
#
#   fsc_autopilot_ros2 (single_drone_ccm_rotor_actuation)  publishes, ~250 Hz
#   torch_model_loader (CCM_rotor_direct)                   evaluates the controller on it
#
# World frame ENU, body frame FLU, SI units. Rotor index i = PX4 motor i (CA_ROTOR<i-1>).

std_msgs/Header header                  # stamp = time the state was assembled (latency gate)
geometry_msgs/Point position            # p [m], ENU
geometry_msgs/Vector3 velocity          # v [m/s], ENU
geometry_msgs/Quaternion orientation    # R, body FLU -> world ENU
float64[9] rotation                     # R row-major (the model's input layout; same as orientation)
geometry_msgs/Vector3 angular_velocity  # omega [rad/s], body FLU

# ACTUAL rotor thrusts [N]: the flight node's estimate (rotor speeds filtered from its own motor
# commands with the rotor time constant, thrust = kf * omega^2), PX4 motor order.
float64[4] rotor_thrust

# The wrench of rotor_thrust through the node's allocation geometry, for display only.
float64 thrust                          # T [N], along body +z
geometry_msgs/Vector3 torque            # tau [N m], body FLU
