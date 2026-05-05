#!/usr/bin/env bash
set -euo pipefail

set +u
source /opt/ros/foxy/setup.bash
set -u
unset CYCLONEDDS_URI FASTRTPS_DEFAULT_PROFILES_FILE
export ROS_DOMAIN_ID="${ROS_DOMAIN_ID:-0}"
export RMW_IMPLEMENTATION="${RMW_IMPLEMENTATION:-rmw_fastrtps_cpp}"
export ROS_LOCALHOST_ONLY="${ROS_LOCALHOST_ONLY:-0}"

exec rviz2 -d /opt/ros/foxy/share/nav2_bringup/rviz/nav2_default_view.rviz
