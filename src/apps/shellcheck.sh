# ==================================================================
# src/apps/shellcheck
# ==================================================================
# Swarm Cookbook - App Installer
#
# File:         src/apps/shellcheck
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
shellcheck::help()
{
	echo
	echo "${GOLD}====================================================================${RESET}"
	echo "${WHITE}SHELLCHECK HELP${RESET}"
	echo "${GOLD}====================================================================${RESET}"
	echo



	echo
	echo "${GOLD}====================================================================${RESET}"
	echo
}
#
# REQUIRES FUNCTION
#
shellcheck::requires() { echo; }
#
# INSTALLED FUNCTION
#
shellcheck::installed() { command -v shellcheck > /dev/null; }
#
# INSTALL FUNCTION
#
shellcheck::install()
{
	echo
	echo "===================================================================="
	echo "INSTALLING SHELLCHECK"
	echo "===================================================================="
	echo

	sudo apt install -y shellcheck

	echo
	echo "DONE!"
	echo
}
#
# CONFIG FUNCTION
#
shellcheck::config()
{
	echo
	echo "===================================================================="
	echo "CONFIGURING SHELLCHECK"
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
shellcheck::remove()
{
	echo
	echo "===================================================================="
	echo "UNINSTALLING SHELLCHECK"
	echo "===================================================================="
	echo

	sudo apt purge -y --autoremove shellcheck

	echo
	echo "DONE!"
	echo
}
#
# TEST FUNCTION
#
shellcheck::test()
{
	echo
	echo "===================================================================="
	echo "TESTING SHELLCHECK"
	echo "===================================================================="
	echo

	echo

	echo
	echo "DONE!"
	echo
}
