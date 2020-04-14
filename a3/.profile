# .bashrc

# Source global definitions
if [ -f /usr/socs/Profile ]; then
        . /usr/socs/Profile
fi
echo "Welcome to $HOSTNAME!"
echo "You have $(who | grep "$(whoami)" | wc -l) login sessions to this host."
echo $(fortune)
#Part 6 of problem 1. 
echo "Today is $(date)"
alias comp206="cd ~/Projects/COMP206"
export PS1="\u@\h[\t]:\w$"



# User specific aliases and functions
