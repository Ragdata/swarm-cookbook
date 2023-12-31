# ==================================================================
# src/apps/gh-cli
# ==================================================================
# Swarm Cookbook - App Installer
#
# File:         src/apps/gh-cli
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
gh-cli::help()
{
	echo
	echo "${GOLD}====================================================================${RESET}"
	echo "${WHITE}GH-CLI HELP${RESET}"
	echo "${GOLD}====================================================================${RESET}"
	echo



	echo
	echo "${GOLD}====================================================================${RESET}"
	echo
}
#
# REQUIRES FUNCTION
#
gh-cli::requires() { echo; }
#
# INSTALLED FUNCTION
#
gh-cli::installed() { command -v gh-cli > /dev/null; }
#
# INSTALL FUNCTION
#
gh-cli::install()
{
	echo
	echo "===================================================================="
	echo "INSTALLING GITHUB-CLI"
	echo "===================================================================="
	echo

	wget https://cli.github.com/packages/githubcli-archive-keyring.gpg | dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
	chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
	echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null

	sudo apt update
	sudo apt install -y gh

	echo
	echo "DONE!"
	echo
}
#
# CONFIG FUNCTION
#
gh-cli::config()
{
	echo
	echo "===================================================================="
	echo "CONFIGURING GITHUB-CLI"
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
gh-cli::remove()
{
	echo
	echo "===================================================================="
	echo "UNINSTALLING GITHUB-CLI"
	echo "===================================================================="
	echo

	sudo apt purge -y --autoremove gh

	echo
	echo "DONE!"
	echo
}
