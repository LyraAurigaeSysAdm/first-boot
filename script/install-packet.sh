#!/usr/bin/env bash

# Get the version name
OS_NAME=$(lsb_release -s -i)

# Test that we are on ubuntu, else exit
test  "Ubuntu" = "${OS_NAME}" || exit 1

### Launch pre installation script
for script in pre-install/*.sh
do
  # Test that file exist, else skip
  [[ -e "${script}" ]] || break
  # Test that file is executable, else skip
  [[ -x "${script}" ]] || break
  bash "${script}"
done

### install packages

# Create temporary file
MERGED_PACKET_LIST=$(mktemp /tmp/merged-package_list-XXXXX)

# Merge all packagelist
for package_list in packages/*.packagelist
do
  cat "${package_list}" >> "${MERGED_PACKET_LIST}"
done

apt-get install -y $(grep -vE "^\s*#" "${MERGED_PACKET_LIST}"  | tr "\n" " ")

for script in post-install/*.sh
do
  # Test that file exist, else skip
  [[ -e "${script}" ]] || break
  # Test that file is executable, else skip
  [[ -x "${script}" ]] || break
  bash "${script}"
done

rm "${MERGED_PACKET_LIST}"