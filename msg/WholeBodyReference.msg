# Whole-body aerial-manipulator task reference — the complete reference set of
# the Cartesian-impedance whole-body law (system-CoM position through SNAP,
# base heading through 2 derivatives, end-effector position/heading through 2
# derivatives, plus the joint reference for the posture objective).
#
# Consumed by autopilot_whole_body_direct_actuation_node: when a fresh message
# is available in DIRECT mode it IS the law's reference verbatim; when the
# stream is stale the node falls back to its internal setpoint builder (the
# hover-campaign behaviour), so this message is strictly additive.
#
# FRAME CONTRACT (deliberate): every quantity is in the law's MODEL frame —
# AM_realign's y-forward body frame, the frame wb_types.hpp declares for
# WbReference, NOT the flying asset's x-forward FLU frame. World-frame vectors
# share the common ENU world; heading vectors (b1_d, b1_de) are MODEL body-x
# directions in that world. The publisher (the whole-body reference governor)
# owns every actual<->model conversion, exactly as frame_adapter.hpp does on
# the C++ side, so this node copies fields verbatim with no frame math.

std_msgs/Header header

# System-CoM position reference and its first four time derivatives [m, ...].
geometry_msgs/Vector3 x_cd
geometry_msgs/Vector3 x_cd_dot
geometry_msgs/Vector3 x_cd_ddot
geometry_msgs/Vector3 x_cd_d3
geometry_msgs/Vector3 x_cd_d4

# Desired base heading direction (world, unit) and derivatives.
geometry_msgs/Vector3 b1_d
geometry_msgs/Vector3 b1_d_dot
geometry_msgs/Vector3 b1_d_ddot

# End-effector position reference (world) and derivatives [m, ...].
geometry_msgs/Vector3 r_ed
geometry_msgs/Vector3 r_ed_dot
geometry_msgs/Vector3 r_ed_ddot

# Desired end-effector heading direction (world, unit) and derivatives.
geometry_msgs/Vector3 b1_de
geometry_msgs/Vector3 b1_de_dot
geometry_msgs/Vector3 b1_de_ddot

# Joint reference [rad, rad/s] for the optional posture objective (selects the
# IK branch); consistent with the Cartesian reference above by construction.
float64[4] q_d
float64[4] qdot_d
