std_msgs/Header header

# The desired position/velocity xstar
geometry_msgs/Point x_ref_pos
geometry_msgs/Vector3 x_ref_vel

# The current vehicle absolute position/velocity x
geometry_msgs/Point x_pos
geometry_msgs/Vector3 x_vel

# The desired control input ustar
geometry_msgs/Vector3 uref
