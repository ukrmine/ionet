#!/bin/bash

# Stop all running Docker containers
echo "Stopping all running Docker containers..."
docker stop $(docker ps -a -q)

# Remove all Docker containers
echo "Removing all Docker containers..."
docker rm $(docker ps -a -q)

# Remove all Docker images
echo "Removing all Docker images..."
docker rmi $(docker images -q)

# Uninstall Docker Engine, CLI, and Containerd
echo "Uninstalling Docker..."
sudo apt-get purge -y docker-engine docker docker.io docker-ce docker-ce-cli containerd containerd.io

# Remove Docker's storage volumes
echo "Removing Docker storage volumes..."
sudo rm -rf /var/lib/docker
sudo rm -rf /var/lib/containerd

# Remove Docker group
sudo groupdel docker

# Remove Docker's configuration files
echo "Removing Docker configuration files..."
sudo rm -rf /etc/docker

# Remove any leftover Docker files
sudo find / -name '*docker*' -exec rm -rf {} \;

# Uninstall NVIDIA Docker
echo "Uninstalling NVIDIA Docker..."
sudo apt-get purge -y nvidia-docker

# Uninstall NVIDIA drivers
echo "Uninstalling NVIDIA drivers..."
sudo apt-get purge -y '*nvidia*'

# Remove any remaining NVIDIA directories
sudo rm -rf /usr/local/nvidia/

# Update the package lists
echo "Updating package lists..."
sudo apt-get update

# Autoremove any orphaned packages
echo "Removing unused packages and cleaning up..."
sudo apt-get autoremove -y
sudo apt-get autoclean

# Rebuild the kernel module dependencies
echo "Rebuilding kernel module dependencies..."
sudo depmod

# Inform the user that a reboot is required
echo "Uninstallation complete. Please reboot your system."

