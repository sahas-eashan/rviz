#!/usr/bin/env bash
set -euo pipefail

RVIZ_CONFIG="${1:-${GO2_SLAM_RVIZ_CONFIG:-/home/sahas/Desktop/rviz/go2_slam_visualization.rviz}}"

set +u
source /opt/ros/foxy/setup.bash
set -u
unset CYCLONEDDS_URI FASTRTPS_DEFAULT_PROFILES_FILE
export ROS_DOMAIN_ID="${ROS_DOMAIN_ID:-0}"
export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp
export ROS_LOCALHOST_ONLY=1

if [[ ! -f "${RVIZ_CONFIG}" ]]; then
  echo "RViz config not found: ${RVIZ_CONFIG}" >&2
  exit 1
fi

echo "[rviz-slam] config=${RVIZ_CONFIG}" >&2
exec rviz2 -d "${RVIZ_CONFIG}"
