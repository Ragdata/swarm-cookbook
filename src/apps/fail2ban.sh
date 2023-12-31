# ==================================================================
# src/apps/fail2ban
# ==================================================================
# Swarm Cookbook - App Installer
#
# File:         src/apps/fail2ban
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
fail2ban::help()
{
	echo
	echo "${GOLD}====================================================================${RESET}"
	echo "${WHITE}FAIL2BAN HELP${RESET}"
	echo "${GOLD}====================================================================${RESET}"
	echo



	echo
	echo "${GOLD}====================================================================${RESET}"
	echo
}
#
# REQUIRES FUNCTION
#
fail2ban::requires() { echo; }
#
# INSTALLED FUNCTION
#
fail2ban::installed() { command -v fail2ban > /dev/null; }
#
# INSTALL FUNCTION
#
fail2ban::install()
{
	echo
	echo "===================================================================="
	echo "INSTALLING FAIL2BAN"
	echo "===================================================================="
	echo

	sudo apt install -y fail2ban

	echo
	echo "DONE!"
	echo
}
#
# CONFIG FUNCTION
#
fail2ban::config()
{
	echo
	echo "===================================================================="
	echo "CONFIGURING FAIL2BAN"
	echo "===================================================================="
	echo

	cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local

	ignore="${TRUSTED[*]}"

    sed -ri "/^\[DEFAULT\]$/,/^# JAILS$/ s/^bantime[[:blank:]]*= .*/bantime = 18000/" /etc/fail2ban/jail.local
    sed -ri "/^\[DEFAULT\]$/,/^# JAILS$/ s/^backend[[:blank:]]*=.*/backend = polling/" /etc/fail2ban/jail.local
    sed -ri "/^\[DEFAULT\]$/,/^# JAILS$/ s/^ignoreip[[:blank:]]*=.*/ignoreip = ${ignore//\//\\/}" /etc/fail2ban/jail.local

    cp /etc/fail2ban/jail.d/defaults-debian.conf /etc/fail2ban/jail.d/defaults-debian.conf~
    cp "$SWARMDIR"/inc/fail2ban/defaults-debian.conf /etc/fail2ban/jail.d/defaults-debian.conf

	echo
	echo "DONE!"
	echo
}
#
# REMOVE FUNCTION
#
fail2ban::remove()
{
	echo
	echo "===================================================================="
	echo "UNINSTALLING FAIL2BAN"
	echo "===================================================================="
	echo

	apt purge -y --autoremove fail2ban

	echo
	echo "DONE!"
	echo
}
#
# TEST FUNCTION
#
fail2ban::test()
{
	echo
	echo "===================================================================="
	echo "TESTING FAIL2BAN"
	echo "===================================================================="
	echo

	echo

	echo
	echo "DONE!"
	echo
}
