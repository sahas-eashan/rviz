#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
RELAY_SCRIPT="${RELAY_SCRIPT_PATH:-/home/sahas/Documents/github/RAI_examples/go2_rosbridge_rviz_relay.py}"
ROBOT_ROSBRIDGE_URL="${1:-${ROBOT_ROSBRIDGE_URL:-ws://10.231.252.104:9090}}"

if [[ ! -f "${RELAY_SCRIPT}" ]]; then
  echo "relay script not found: ${RELAY_SCRIPT}" >&2
  exit 1
fi

set +u
source /opt/ros/foxy/setup.bash
set -u
export PYENV_VERSION=system
unset PYTHONHOME
unset CYCLONEDDS_URI FASTRTPS_DEFAULT_PROFILES_FILE
export ROS_DOMAIN_ID="${ROS_DOMAIN_ID:-0}"
export RMW_IMPLEMENTATION="${RMW_IMPLEMENTATION:-rmw_fastrtps_cpp}"
export ROS_LOCALHOST_ONLY="${ROS_LOCALHOST_ONLY:-0}"

echo "[relay-slam] ${ROBOT_ROSBRIDGE_URL}" >&2
echo "[relay-slam] ROS_DOMAIN_ID=${ROS_DOMAIN_ID} RMW_IMPLEMENTATION=${RMW_IMPLEMENTATION} ROS_LOCALHOST_ONLY=${ROS_LOCALHOST_ONLY}" >&2

exec /usr/bin/python3 "${RELAY_SCRIPT}" \
  --rosbridge-url "${ROBOT_ROSBRIDGE_URL}" \
  --prefix "" \
  --subscribe-throttle-ms 100 \
  --topics /tf,/tf_static,/map,/scan_raw,/utlidar/robot_odom \
  --topic-types /tf=tf2_msgs/TFMessage,/tf_static=tf2_msgs/TFMessage,/map=nav_msgs/OccupancyGrid,/scan_raw=sensor_msgs/LaserScan,/utlidar/robot_odom=nav_msgs/Odometry
