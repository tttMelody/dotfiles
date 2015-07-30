#!/usr/bin/env zsh

# Set required options
#
setopt prompt_subst

# Load required modules
#
autoload -Uz vcs_info

# List of vcs_info format strings:
#
# %b => current branch
# %a => current action (rebase/merge)
# %s => current version control system
# %r => name of the root directory of the repository
# %S => current path relative to the repository root directory
# %m => in case of Git, show information about stashes
# %u => show unstaged changes in the repository
# %c => show staged changes in the repository
# Set vcs_info parameters
#
zstyle ':vcs_info:*' enable git hg svn
zstyle ':vcs_info:*:*' unstagedstr '!'
zstyle ':vcs_info:*:*' stagedstr '+'
zstyle ':vcs_info:*:*' formats "$FX[bold]%~$FX[no-bold]" "%s/%b" "%%u%c"
zstyle ':vcs_info:*:*' actionformats "$FX[bold]%~$FX[no-bold]" "%s/%b" "%u%c (%a)"
zstyle ':vcs_info:*:*' nvcsformats "%~" "" ""

# Fastest possible way to check if repo is dirty
#
git_dirty() {
    # Check if we're in a git repo
    command git rev-parse --is-inside-work-tree &>/dev/null || return
    # Check if it's dirty
    dirty=""
    command git diff --quiet --ignore-submodules HEAD &>/dev/null; [ $? -eq 1 ] && dirty="*"
	[[ -n $(git status --porcelain) ]] && dirty="*"
	command echo $dirty
	#command git diff --quiet --ignore-submodules HEAD &>/dev/null || [[ -n $(git status --porcelain) ]] ; [ $? -eq 1 ] && echo "*"
}

# Display information about the current repository
#
repo_information() {
	echo "%(1j.[%j].)%F{red}%n%f@%F{blue}%m%f:%F{blue}${vcs_info_msg_0_%%/.} %F{8}$vcs_info_msg_1_`git_dirty` $vcs_info_msg_2_%f"
	#echo "%F{red}%n%f@%F{blue}%m%f:%F{blue}%~ %F{8}$vcs_info_msg_1_`git_dirty` $vcs_info_msg_2_%f"
}

# Displays the exec time of the last command if set threshold was exceeded
#
cmd_exec_time() {
    local stop=`date +%s`
    local start=${cmd_timestamp:-$stop}
    let local elapsed=$stop-$start
    [ $elapsed -gt 5 ] && echo ${elapsed}s
}

# Get the intial timestamp for cmd_exec_time
#
preexec() {
    cmd_timestamp=`date +%s`
}

# Output additional information about paths, repos and exec time
#
precmd() {
	vcs_info # Get version control info before we start outputting stuff
	#print -P "\n$(repo_information) %F{yellow}$(cmd_exec_time)%f"
	print -P "\n$(repo_information)"
}

# Define prompts
#
PROMPT="%(?.%F{magenta}.%F{red})>%f " # Display a red prompt char on failure
#RPROMPT="%F{8}${SSH_TTY:+%n@%m}%f"    # Display username if connected via SSH

# ------------------------------------------------------------------------------
#
#
# List of prompt format strings:
#
# prompt:
# %F => color dict
# %f => reset color
# %~ => current path
# %* => time
# %n => username
# %m => shortname host
# %(?..) => prompt conditional - %(condition.true.false)
#
# ------------------------------------------------------------------------------
