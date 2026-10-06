# Output u of the ROTOR-THRUST (R)CCM: the four COMMANDED rotor thrusts.
#
#   torch_model_loader (CCM_rotor_direct)                  publishes, one per CcmRotorState
#   fsc_autopilot_ros2 (single_drone_ccm_rotor_actuation)  maps each thrust to a motor command
#
# The allocation is inside the learned controller; the flight node only clamps each rotor to its
# thrust range and inverts thrust = kf * omega^2 and the ESC map.

std_msgs/Header header       # stamp = the CcmRotorState stamp it was computed from (latency gate)
float64[4] thrust            # commanded rotor thrusts [N], PX4 motor order (CA_ROTOR<i-1>)
