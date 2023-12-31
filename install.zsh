#!/usr/bin/env zsh
# shellcheck disable=SC1090,SC2031,SC2034,SC2154,SC2155,SC2181,SC2260
# ==================================================================
# install.zsh
# ==================================================================
# Swarm Cookbook Installer
#
# File:         install.zsh
# Author:       Ragdata
# Date:         17/09/2023
# License:      MIT License
# Copyright:    Copyright © 2023 Darren (Ragdata) Poulton
# ==================================================================
# PREFLIGHT
# ==================================================================
# if script is called with 'debug' as an argument, then set debug mode
if [[ "${1:l}" == "debug" ]] || [[ "$DEBUG" == 1 ]]; then shift; export DEBUG=1; set -- "${@}"; set -axeET; else export DEBUG=0; set -aeET; fi
# if script is called with 'verbose' as an argument, then unset verbose mode
if [[ "${1:l}" == "verbose" ]] || [[ "$LOG_VERBOSE" == 0 ]]; then shift; export LOG_VERBOSE=0; else export LOG_VERBOSE=1; fi
# ==================================================================
# VARIABLES
# ==================================================================
# define REPO
if [[ -z "$REPO" ]]; then export REPO="${0:a:h}"; fi
# define SOURCE_DIRS
export SOURCE_DIRS=("$REPO/src/apps" "$REPO/install")
# define USERNAME
export USERNAME="$(whoami)"
# ==================================================================
# HELPER FUNCTIONS
# ==================================================================
# ------------------------------------------------------------------
# loadLib
# ------------------------------------------------------------------
loadLib()
{
	local file="${1:-}"

	if [[ "${1:0:1}" == "/" ]] && [[ -f "$file" ]]; then
		source "$file"
	elif [[ -f /usr/local/lib/"$file" ]]; then
		source /usr/local/lib/"$file"
	elif [[ -f "$REPO"/src/lib/"$file" ]]; then
		source "$REPO"/src/lib/"$file"
	else
		echo "Library File '$file' Not Found!"
		exit 1
	fi
}
# ==================================================================
# DEPENDENCIES
# ==================================================================
if ! grep -q 'function' <<< "$(type historyStats 2> /dev/null)"; then loadLib common.zsh; fi
# create .env, if not exists
if [[ ! -f "$REPO"/.env ]]; then cp "$REPO"/.env.dist "$REPO"/.env; fi
# set file ownership
chown "$USERNAME":"$USERNAME" "$REPO"/.env
# load .env
source "$REPO"/.env;
# initialize log
if [[ "${1:l}" == "logfile" ]]; then export logFile="${2:-}"; shift 2; else log::init INSTALL-"$(logTime)"; fi
# ==================================================================
# INSTALL FUNCTIONS
# ==================================================================
# ------------------------------------------------------------------
# install::init
# ------------------------------------------------------------------
install::init()
{
	if [[ -f "$HOME/.local/.node-init" ]]; then return 0; fi

	echo
	echo "=================================================================="
	echo "SYSTEM INITIALIZATION"
	echo "=================================================================="
	echo

	checkPkg "jq" "JQ"
	checkPkg "redis" "Redis"
	loadSource redis -c
	checkPkg "dialog" "Dialog"

	if [[ ! -d "$HOME/.local" ]]; then mkdir -p "$HOME/.local"; fi
	touch "$HOME/.local/.node-init"

	echo
	echo "SYSTEM INITIALIZATION - DONE!"
	echo "=================================================================="
	echo
}
# ------------------------------------------------------------------
# install::install
# ------------------------------------------------------------------
install::install()
{
	echo
	echo "=================================================================="
	echo "FULL INSTALLATION"
	echo "=================================================================="
	echo

	loadSource config.sh -i
	loadSource cron-updates.sh -i
	loadSource dotfiles.sh -i
	loadSource zsh-plugins.sh -i
	loadSource bin.sh -i
	loadSource lib.sh -i
	loadSource swarm.sh -i

	echo
	echo "FULL INSTALLATION - DONE!"
	echo "=================================================================="
	echo
}
# ------------------------------------------------------------------
# install::uninstall
# ------------------------------------------------------------------
install::uninstall()
{
	cd /usr/local/bin || return 1
	rm -f app* stack* swarm*
	rm -Rf "${ZSHDIR?}"
	rm -Rf "${SWARMDIR?}"
}
# ------------------------------------------------------------------
# install::report
# ------------------------------------------------------------------
install::report()
{
	local resp

	[[ -z "$logFile" ]] && { echo "No logFile passed for reporting!"; exit 1; }

	echo "The previous operation was logged and details are available to view"
	echo "Please select from the following options:"
	echo
	echo -e "\t (V)iew Logs"
	echo -e "\t (R)eboot"
	echo -e "\t (Q)uit"
	echo

	read -rs -n 1 resp

	resp="${resp,,}"

	case "$resp" in
		v)
			echo
			echo "===================================================================="
			echo "CONTENT OF LOGFILE '$logFile'"
			echo "===================================================================="
			echo
			sudo cat "$logFile"
			echo
			echo "DONE!"
			echo
			exit 0
			;;
		r)
			reboot
			;;
		q)
			exit 0
			;;
	esac
}
# ==================================================================
# MAIN
# ==================================================================
clear

install::init

if [[ "$#" == 0 ]]; then set -- "all"; fi

while [[ "$#" -gt 0 ]]
do
	case "$1" in
		all)
			install::install
			;;
		bin)
			loadSource bin -i
			;;
		rmBin|binRemove)
			loadSource bin -r
			;;
		config)
			loadSource config -i
			;;
		rmConfig|configRemove)
			loadSource config -r
			;;
		dotfiles)
			loadSource dotfiles -i
			;;
		rmDotfiles|dotfilesRemove)
			loadSource dotfiles -r
			;;
		init)
			install::init
			;;
		lib)
			loadSource lib -i
			;;
		rmLib|libRemove)
			loadSource lib -r
			;;
		swarm)
			loadSource swarm -i
			;;
		rmSwarm|swarmRemove)
			loadSource swarm -r
			;;
		node)
			loadSource node -i -c
			;;
		rmZSH|zshRemove)
			loadSource zsh -r
			;;
		zsh-p10k)
			loadSource zsh-p10k -i
			;;
		plugins)
			loadSource zsh-plugins -i
			;;
	esac
	shift
done

if [[ -n "$ZSH_RESTART" ]]; then
	exec zsh
else
	install::report
fi
