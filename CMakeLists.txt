cmake_minimum_required(VERSION 3.8)
project(fsc_autopilot_ros2_msgs)

# Default to C++17
if(NOT CMAKE_CXX_STANDARD)
	set(CMAKE_CXX_STANDARD 17)
endif()

if(CMAKE_COMPILER_IS_GNUCXX OR CMAKE_CXX_COMPILER_ID MATCHES "Clang")
  add_compile_options(-Wall -Wextra -Wpedantic)
endif()

# find dependencies
find_package(ament_cmake REQUIRED)
find_package(rosidl_default_generators REQUIRED)
find_package(rclcpp REQUIRED)
find_package(std_msgs REQUIRED)
find_package(geometry_msgs REQUIRED)
find_package(nav_msgs REQUIRED)
find_package(Eigen3 REQUIRED)
find_package(rosidl_default_runtime REQUIRED)

# get all msg files
set(MSGS_DIR "${CMAKE_CURRENT_SOURCE_DIR}/msg")
file(GLOB FSC_AUTOPILOT_ROS2_MSGS RELATIVE "${CMAKE_CURRENT_SOURCE_DIR}" "${MSGS_DIR}/*.msg")


# Generate introspection typesupport for C and C++ and IDL files
rosidl_generate_interfaces(${PROJECT_NAME}
	${FSC_AUTOPILOT_ROS2_MSGS}
	DEPENDENCIES builtin_interfaces geometry_msgs nav_msgs std_msgs
	ADD_LINTER_TESTS
)

rosidl_get_typesupport_target(cpp_typesupport_target ${PROJECT_NAME}
                              rosidl_typesupport_cpp)

ament_export_dependencies(rosidl_default_runtime)

ament_package()
