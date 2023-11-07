# ==================================================================
# src/apps/gpg
# ==================================================================
# Swarm Cookbook - App Installer
#
# File:         src/apps/gpg
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
# HELP FUNCTION
#
gpg::help()
{
	echo
	echo "${GOLD}====================================================================${RESET}"
	echo "${WHITE}GPG HELP${RESET}"
	echo "${GOLD}====================================================================${RESET}"
	echo



	echo
	echo "${GOLD}====================================================================${RESET}"
	echo
}
#
# REQUIRES FUNCTION
#
gpg::requires() { echo; }
#
# INSTALLED FUNCTION
#
gpg::installed() { command -v gpg > /dev/null; }
#
# INSTALL FUNCTION
#
gpg::install()
{
	echo
	echo "===================================================================="
	echo "INSTALLING GPG"
	echo "===================================================================="
	echo

	sudo apt install -y gpg

	echo
	echo "DONE!"
	echo
}
#
# CONFIG FUNCTION
#
gpg::config()
{
	echo
	echo "===================================================================="
	echo "CONFIGURING GPG"
	echo "===================================================================="
	echo

	gpg --default-new-key-algo rsa4096 --gen-key

	echo
	echo "DONE!"
	echo
}
#
# REMOVE FUNCTION
#
gpg::remove()
{
	echo
	echo "===================================================================="
	echo "UNINSTALLING GPG"
	echo "===================================================================="
	echo

	sudo apt purge -y --autoremove gpg

	echo
	echo "DONE!"
	echo
}
