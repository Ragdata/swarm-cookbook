# ==================================================================
# src/apps/dialog
# ==================================================================
# Swarm Cookbook - App Installer
#
# File:         src/apps/dialog
# Author:       Ragdata
# Date:         09/10/2023
# License:      MIT License
# Copyright:    Copyright © 2023 Darren Poulton (Ragdata)
# ==================================================================
# DEPENDENCIES
# ==================================================================

# ==================================================================
# HELPER FUNCTIONS
# ==================================================================
# ------------------------------------------------------------------
# dialog::theme::config
# ------------------------------------------------------------------
dialog::theme::config()
{
	local theme="${1:-}"

	if [[ -z "$theme" ]] && [[ -f "$HOME"/.dialogrc ]]; then
		echo "Resetting Theme"
		rm -f "$HOME"/.dialogrc
	fi

	[[ "${theme:0:1}" != "." ]] && theme=".$theme"

	if [[ -n "$theme" ]] && [[ -f "$SWARMDIR"/etc/dialog/"$theme" ]]; then
		[[ -f "$HOME"/.dialogrc ]] && rm -f "$HOME"/.dialogrc
		install -m 0644 -T "$SWARMDIR"/etc/dialog/"$theme" "$HOME"/.dialogrc
	fi
}
# ==================================================================
# FUNCTIONS
# ==================================================================
#
# HELP FUNCTION
#
dialog::help()
{
	echo
	echo "${GOLD}====================================================================${RESET}"
	echo "${WHITE}DIALOG HELP${RESET}"
	echo "${GOLD}====================================================================${RESET}"
	echo



	echo
	echo "${GOLD}====================================================================${RESET}"
	echo
}
#
# REQUIRES FUNCTION
#
dialog::requires() { echo; }
#
# INSTALLED FUNCTION
#
dialog::installed() { command -v dialog > /dev/null; }
#
# INSTALL FUNCTION
#
dialog::install()
{
	echo
	echo "===================================================================="
	echo "INSTALLING DIALOG"
	echo "===================================================================="
	echo

	sudo apt install -y dialog

	echo
	echo "DONE!"
	echo
}
#
# CONFIG FUNCTION
#
dialog::config()
{
	echo
	echo "===================================================================="
	echo "CONFIGURING DIALOG"
	echo "===================================================================="
	echo

	while [[ -z "$RESP" ]]
	do
		echo "Select Dialog Theme:"
		echo
		echo "    1. Debian"
		echo "    2. RedEyed"
		echo "    3. Slackware"
		echo "    4. SourceMage"
		echo "    5. SUSE"
		echo "    6. Whiptail"
		echo
		echo "    Q. Quit"
		echo

		if [[ "${SHELL##*/}" == 'zsh' ]]; then
			read -rs -k 1 RESP
		elif [[ "${SHELL##*/}" == 'bash' ]]; then
			read -rs -n 1 RESP
		fi
	done

	case "$RESP" in
		1) dialog::theme::config debianrc;;
		2) dialog::theme::config redeyedrc;;
		3) dialog::theme::config slackwarerc;;
		4) dialog::theme::config sourcemagerc;;
		5) dialog::theme::config suserc;;
		6) dialog::theme::config whiptailrc;;
		q|Q) exit 0;;
		*) errorExit "Invalid Option!";;
	esac

	echo
	echo "DONE!"
	echo
}
#
# REMOVE FUNCTION
#
dialog::remove()
{
	echo
	echo "===================================================================="
	echo "UNINSTALLING DIALOG"
	echo "===================================================================="
	echo

	sudo apt purge -y --autoremove dialog

	echo
	echo "DONE!"
	echo
}
