# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

PATH=$PATH:$HOME/bin

export PATH
unset USERNAME

# ssh-agent setting
# Log:
#   2009/Feb/24: Rewrite and take yroot environment into considerations.

# The script runs only on nuwa, fuxi and chateau.
if [ `hostname -s` = "nuwa" -o `hostname -s` = "chateau" -o `hostname -s` = "fuxi" ]
then

  FILE=~/.agent.`hostname`
  if [ $YROOT_NAME ]
  then
    FILE=$FILE.$YROOT_NAME
  fi

  echo Looking for $FILE for ssh-agent.
  if [ -e $FILE ]
  then
    source $FILE
  else
    echo File $FILE does not exist!
    ssh-agent > $FILE
    source $FILE
    ssh-add
    exit
  fi

  SSHL=`ssh-add -l`
  RET_SSHL=$?
  if [ $RET_SSHL -eq 2 ]
  then
    # No ssh-agent
    echo RET_SSHL is 2
    ssh-agent > $FILE
    source $FILE
    ssh-add
  elif [ $RET_SSHL -eq 1 ]
  then
    # We have a valid ssh-agent, but identities are lost.
    echo RET_SSHL is 1
    ssh-add
  else
    # We have a valid ssh-agent with identities.
    # no-op
    echo RET_SSHL is 0
    true
  fi

fi # if hostname
