#!/usr/bin/env zsh

# ==================================================================
# src/var/apps/ufw
# ==================================================================
# Swarm Cookbook - App Installer
#
# File:         src/var/apps/ufw
# Author:       Ragdata
# Date:         09/10/2023
# License:      MIT License
# Copyright:    Copyright © 2023 Darren Poulton (Ragdata)
# ==================================================================
# DEPENDENCIES
# ==================================================================

# ==================================================================
# FUNCTIONS
# ==================================================================
#
# INSTALL FUNCTION
#
ufw::install()
{
	echo
	echo "===================================================================="
	echo "INSTALLING UFW"
	echo "===================================================================="
	echo

	apt install -y ufw

	echo
	echo "DONE!"
	echo
}
#
# CONFIG FUNCTION
#
ufw::config()
{
	echo
	echo "===================================================================="
	echo "CONFIGURING UFW"
	echo "===================================================================="
	echo

	ufw allow 2376/tcp
	ufw allow 7946/udp
	ufw allow 7946/tcp
	ufw allow 80/tcp
	ufw allow 8080/tcp
	ufw allow 9090/tcp
	ufw allow 443/tcp
	ufw allow 2377/tcp

	ufw allow 53/udp
	ufw allow 4789/udp

	ufw allow samba

	ufw reload
	ufw enable

	echo
	echo "DONE!"
	echo
}
#
# REMOVE FUNCTION
#
ufw::remove()
{
	echo
	echo "===================================================================="
	echo "UNINSTALLING UFW"
	echo "===================================================================="
	echo

	apt purge -y ufw

	echo
	echo "DONE!"
	echo
}
