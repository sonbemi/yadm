# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# VARIABLES
yadm_hosts_rc_dir="~/.dotfiles/host_rcs"

# tyrant2 config
if [[ -f ~/ansible.cfg ]]; then
	export VIRTUAL_ENV_DISABLE_PROMPT=1
	export ANSIBLE_CONFIG=~/ansible.cfg
fi
if [[ $HOSTNAME == 'tyrant2'* ]]; then
	source ~smg-control/ansible_venv/bin/activate
	if [[ -f ~/ansible/etc/yamllint.yml ]]; then
		export YAMLLINT_CONFIG_FILE=~/ansible/etc/yamllint.yml
	fi
fi

# Git configs
if [[ -f ~/.git-completion.sh ]]; then
	source ~/.git-completion.sh
fi

if [[ -f ~/.twoline_prompt.sh ]]; then
	source ~/.twoline_prompt.sh
fi

# Git Config
GIT_HOSTS=(\
	"tyrant2"
	"barefaced"
	"granger-dve"
	"festung"
)

for host in ${GIT_HOSTS[@]}; do
	if [[ $HOSTNAME == $host || $HOSTNAME == "${i}.techservices.illinois.edu" ]]; then
		export GIT_AUTHOR_NAME="Bemi Ekwejunor"
		export GIT_AUTHOR_EMAIL="ekwejuno@illinois.edu"
		export GIT_COMMITER_NAME=${GIT_AUTHOR_NAME}
		export GIT_COMMITER_EMAIL=${GIT_AUTHOR_EMAIL}
	fi
done

### end Git configs

# HOST SPECIFIC RC
if  [[ -f ${yadm_hosts_rc_dir}/${HOSTNAME%%.*} ]]; then
	. ${yadm_hosts_rc_dir}/${HOSTNAME%%.*}
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
	for rc in ~/.bashrc.d/*; do
		if [ -f "$rc" ]; then
			. "$rc"
		fi
	done
fi

unset rc
