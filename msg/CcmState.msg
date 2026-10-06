# State x fed to the torque-mode (R)CCM model, assembled by the flight node
# (fsc_autopilot_ros2 single_drone_ccm_direct_actuation) from the SAME feedback its own
# control and safety logic use, and consumed by torch_model_loader (CCM_torque_direct).
# World frame ENU, body frame FLU, SI units.

std_msgs/Header header                  # stamp = time the state was assembled; echoed by the model output
geometry_msgs/Point position            # p [m], ENU (state estimator)
geometry_msgs/Vector3 velocity          # v [m/s], ENU (state estimator)
geometry_msgs/Quaternion orientation    # R, body FLU -> world ENU (PX4 attitude)
float64[9] rotation                     # R row-major (the model's input layout)
geometry_msgs/Vector3 angular_velocity  # omega [rad/s], body FLU (PX4 gyro)

# Estimated ACTUAL wrench (rotor-lag model driven by the node's own motor commands), for models
# with actuator states. While PX4 flies the vehicle (SAFETY) this is the hover estimate.
float64 thrust                          # T_a [N], along body +z
geometry_msgs/Vector3 torque            # tau_a [N m], body FLU
