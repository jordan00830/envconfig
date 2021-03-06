#!/bin/bash
#

shopt -s histappend

if [ ${HOSTNAME%yahoo.com} != ${HOSTNAME} ]; then
	export IS_YAHOO=1
fi

OS=${OSTYPE/[^a-z]*/}
OSM=${OSTYPE/.[0-9]*/}
#export CVSROOT=vault.yahoo.com:/CVSROOT
#export CVS_RSH=yssh
export project=~/kfc/ysymfony_helloworld/trunk

#export SVNROOT=svn+ssh://svn.corp.yahoo.com/yahoo/asia/search/productsearch/trunk/monday_searchfe/
#export SOURCE_DIR=~/devel/monday_searchfe
#export R3HOME=$SOURCE_DIR/r3

export SVNROOT=svn+ssh://svn.corp.yahoo.com/yahoo/asia/search/productsearch
export SOURCE_DIR=/home/jamesyan/devel/monday_searchfe
export R3HOME=$SOURCE_DIR/r3


export LD_LIBRARY_PATH="lib/native"
export SVN_EDITOR=vim
export CLICOLOR_FORCE
export P4CONFIG=.p4config
#export LC_ALL=zh_TW.Big5
export LC_CTYPE=zh_TW.UTF-8
export LANG=zh_TW.UTF-8
export LOCALE=C
export _GREP_COLOR="--color=auto"
_ENG_LOCALE=en_US.UTF-8
if [ "$OSM" = "freebsd4" ]; then
#	export LANG=zh_TW.Big5
	_ENG_LOCALE=en_US.ISO8859-1
    _GREP_COLOR=
elif [ "$OS" = "cygwin" ]; then
	export LANG=C
fi
export LC_TIME=C
export LESS="-giMnrSw"
export LSCOLORS="Gxfxcxdxbxegedabagacad" # FreeBSD only
export LS_COLORS='di=1;36:ln=0;35:so=0;32:pi=0;33:ex=0;31:bd=0;34;46:cd=0;34;43' # Linux only
export HISTTIMEFORMAT="%F %T "

function color_prompt
{
	local CYAN='\[\e[36m\]'
	local B_RED='\[\e[1;31m\]'
	local B_YELLOW='\[\e[1;33m\]'
	local B_PURPLE='\[\e[1;35m\]'
	local B_CYAN='\[\e[1;36m\]'
	local NORMAL='\[\e[m\]'
	local SHTITLE='\[\ek\e\134\]'

	local JAILED=""
	if [ "${OS}" = "freebsd" ]; then
		if [ x"`/sbin/sysctl -n security.jail.jailed 2>/dev/null`" = "x1" ]; then
			JAILED="${B_RED}[J]${NORMAL}"
		fi;
	fi

	if [ ! -z ${IS_YAHOO} ]; then
		local YROOTED=""
		if [ ! -z "$YROOT_NAME" ]; then
			YROOTED=":$YROOT_NAME"
		fi

		PS1="${NORMAL}${B_CYAN}\u@\h${YROOTED}${NORMAL}${JAILED} [${B_PURPLE}\w${NORMAL}]"
	else
		PS1="${NORMAL}${B_CYAN}\u@\h${NORMAL}${JAILED} [${B_PURPLE}\w${NORMAL}]"
	fi

	if [ ! -z "$WINDOW" ]; then
		PS1="${PS1} [${CYAN}W$WINDOW${NORMAL}]${SHTITLE}\$ "
	else
		PS1="${PS1}\$ "
	fi
	export PS1
}

color_prompt

# aliases
alias bye="/bin/sync; /bin/sync; clear;logout"
alias rm="/bin/rm -i"
alias syncr3="gsp2_r3sync -c $R3HOME/.gsp2_r3sync.ini"


# alias for shopping search
alias gg="r3 gen web/zh_TW/skins/search/html_metro/main.inc; r3 gen web/zh_TW/skins/search/html_metro_yui3/main.inc"
alias ge="r3 gen -v web/zh_TW/htdocs/search"

alias rr3="svn revert $SOURCE_DIR/r3/r3_datadir/web.sq3"
alias bm="$SOURCE_DIR/tools/build_monday.sh"
alias ds="$SOURCE_DIR/tools/build_monday.sh test vespa1.search.tw1:shoppingFE_stg"
alias ry="yinst restart yapache"

# CMD Aliases
alias b5="env LANG=zh_TW.Big5 /usr/X11R6/bin/luit"
alias cls="clear"
alias colorls="/bin/ls -FGw"
alias d="colorls"
alias dict="env LC_CTYPE=${_ENG_LOCALE} /usr/local/bin/dict"
alias finger="env LC_CTYPE=${_ENG_LOCALE} /usr/bin/finger"
alias ftp="env LC_CTYPE=${_ENG_LOCALE} /usr/bin/ftp"
alias g="grep -v svn"
alias grep="env LANG=${_ENG_LOCALE} /usr/bin/egrep ${_GREP_COLOR} --mmap"
alias irssi="/usr/local/bin/irssi"
alias l="/usr/bin/last"
alias less="/usr/bin/less"
alias lftp="env LANG=${_ENG_LOCALE} lftp"
alias lock="/usr/bin/lock -n -p"
alias ls="colorls -l"
alias m="mutt"
alias mall="env LC_CTYPE=${_ENG_LOCALE} /usr/bin/mail"
alias mutt="/usr/local/bin/mutt -y"
alias n="/usr/bin/nslookup"
alias p="/sbin/ping"
alias ps="env LANG= ps"
alias psa="/bin/ps awx"
alias psr="psa -U root"
alias perldoc="LANG=C perldoc"
alias r="/usr/bin/fetch -q -o /dev/stdout 'http://www.random.org/cgi-bin/randnum?num=1&min=0&max=1&col=1'"
alias s="/usr/local/bin/screen"
alias ssh="/usr/bin/ssh -2 -4 -C"
alias sort="env LANG=C /usr/bin/sort"
alias startx="exec startx"
alias t="telnet"
alias tar="env LANG=${_ENG_LOCALE} /usr/bin/tar"
alias telnet="/usr/bin/telnet -8"
alias talk="env LC_CTYPE=${_ENG_LOCALE} /usr/local/bin/ytalk"
alias top="/usr/bin/top -s1"
alias vncviewer="vncviewer -encodings 'copyrect tight hextile zlib corre rre' -compresslevel 9 -quality 9"
alias wall="env LC_CTYPE=${_ENG_LOCALE} /usr/bin/wall"
alias write="env LC_CTYPE=${_ENG_LOCALE} /usr/bin/write"
alias zg="/usr/bin/zgrep --mmap"


if [ "${OS}" = "linux" -o "${OS}" = "cygwin" ]; then
	alias colorls="/bin/ls -F --show-control-chars --color=always"
	alias dict="/usr/bin/dict"
	alias grep="/bin/egrep --mmap"
	alias mutt="/usr/bin/mutt -y"
    alias sort="env LANG=C /bin/sort"
	alias s="/usr/bin/screen"
	alias tar="env LANG=${_ENG_LOCALE} /bin/tar"
	alias top="/usr/bin/top -d 1"
fi

if [ "${OS}" = "solaris" ]; then
	alias colorls="/usr/local/bin/gnuls -FG --show-control-chars --color=always"
	alias less="/usr/local/bin/less"
	alias top="/usr/local/bin/top -s1"
fi

function svnid() {
	svn ps svn:keywords Id "$@"
}

function svkid() {
	svk ps svn:keywords Id "$@"
}

function svndi() {
	svn di | perl -e '$p = $n = 0; while(<>) {if (/^-[^-]/) {$n++;} elsif (/^\+[^+]/) {$p++;}} printf("+%d -%d\n", $p,$n);'
}

function svkdi() {
	svk di | perl -e '$p = $n = 0; while(<>) {if (/^-[^-]/) {$n++;} elsif (/^\+[^+]/) {$p++;}} printf("+%d -%d\n", $p,$n);'
}

function ss() {
	local last=${!#}
	#screen -t "$ |$last"":" yssh "$@"
	printf '\033k\033\\$ %s:\n' "$last"
	ssh "$@"
}

# stuff that only needs when i login
if [ -t 0 -a -x /usr/local/bin/keychain -a -r $HOME/.ssh/id_dsa.pub ]; then

	# SSH Key
	if [ -f $HOME/.keychain/${HOSTNAME}-sh ]; then
		. $HOME/.keychain/${HOSTNAME}-sh
	fi

	if [ -f $HOME/.keychain/${HOSTNAME}-sh-gpg ]; then
		. $HOME/.keychain/${HOSTNAME}-sh-gpg
		export GPG_TTY=`tty`
	fi
fi

# shells/bash-completion
for i in /usr/local/etc /etc; do
        if [ -f ${i}/bash_completion ]; then
                . ${i}/bash_completion
        fi
done

if [ -f /usr/local/share/examples/pkgtools/bash/complete.sample ]; then
        . /usr/local/share/examples/pkgtools/bash/complete.sample
fi

if [ ! -z ${IS_YAHOO} ]; then
        export PATH=/home/y/bin:/home/y/sbin:/home/y/bin64:/home/y/bin32:/home/y/sbin64:/home/y/sbin64:$PATH
        export CVSROOT=vault.yahoo.com:/CVSROOT
        export CVS_RSH=yssh
        export RSYNC_SSH=yssh

    MY_SSH_CIPHER="-c blowfish-cbc"
#        alias ssh="ssh ${MY_SSH_CIPHER}"
#        alias scp="scp ${MY_SSH_CIPHER}"

        which yssh >/dev/null 2>&1 && alias ssh="yssh ${MY_SSH_CIPHER}"
        which yscp >/dev/null 2>&1 && alias scp="yscp ${MY_SSH_CIPHER}"

        if [ -x /usr/local/bin/yssh-find-agent -a -t 0 ]; then
                export SSH_AUTH_SOCK=`/usr/local/bin/yssh-find-agent`
        fi

        if [ "$OSM" = "freebsd4" ]; then
                alias n="/usr/sbin/nslookup"
        fi

fi

