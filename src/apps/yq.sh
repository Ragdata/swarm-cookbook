# ==================================================================
# src/apps/yq
# ==================================================================
# Swarm Cookbook - App Installer
#
# File:         src/apps/yq
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
yq::help()
{
	echo
	echo "${GOLD}====================================================================${RESET}"
	echo "${WHITE}YQ HELP${RESET}"
	echo "${GOLD}====================================================================${RESET}"
	echo



	echo
	echo "${GOLD}====================================================================${RESET}"
	echo
}
#
# REQUIRES FUNCTION
#
yq::requires() { echo; }
#
# INSTALLED FUNCTION
#
yq::installed() { command -v yq > /dev/null; }
#
# INSTALL FUNCTION
#
yq::install()
{
	echo
	echo "===================================================================="
	echo "INSTALLING YQ"
	echo "===================================================================="
	echo

	sudo apt install -y yq

	echo
	echo "DONE!"
	echo
}
#
# CONFIG FUNCTION
#
yq::config()
{
	echo
	echo "===================================================================="
	echo "CONFIGURING YQ"
	echo "===================================================================="
	echo

	echo

	echo
	echo "DONE!"
	echo
}
#
# REMOVE FUNCTION
#
yq::remove()
{
	echo
	echo "===================================================================="
	echo "UNINSTALLING YQ"
	echo "===================================================================="
	echo

	apt purge -y --autoremove yq

	echo
	echo "DONE!"
	echo
}
