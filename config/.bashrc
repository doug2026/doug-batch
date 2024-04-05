#NEW_HOME="/d/doug_study" # doug's home directory
#cd "$NEW_HOME"
#[ -f .bashrc ] && . .bashrc
#export HOME="$NEW_HOME"

# add this content
# add your onw aliases or changes these ones as you like
# to make a dot (.bashrs) file in windows, create a file ".bashrs." (without extention) and save. windows will save it as ".bashrc"
# [alias]
## get rid of command not found ##
alias cd..='cd ..'

## a quick way to get out of current directory ##
alias ..='cd ..'
alias ...='cd ../../../'
alias ....='cd ../../../../'
alias .....='cd ../../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../..'

alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

#Start calculator with math support
alias bc='bc -l'

# install  colordiff package :)
alias diff='colordiff'

#Make mount command output pretty and human readable format
alias mount='mount |column -t'
alias redo='source ~/.bash_profile'
alias root='cd ~<ID>'
alias cls='clear'
alias vi='vim'
alias emacs="emacs -nw"

#eval `dircolors -b ~/.dir_colors`
alias ls="ls -F --color=auto --show-control-chars"
alias ll="ls -alhF --color=auto --show-control-chars"
alias rd='rdesktop -g 1152x900 -k en-us -a 24 -s sound:local DESKTOP_NAME:3389 -u <ID>-d ap &'
alias do_synergy='synergyc <IP_ADDRESS>'
alias build_kernel='m -j8 ONE_SHOT_MAKEFILE=build/target/board/Android.mk bootimage'
alias build_all='make -j12 > buildlog.txt 2>&1'
alias git_config_quic='git config user.email <QUIC_EMAIL>'

#######################
### Stuff for Linux ###
#######################
#if [ `uname` = "Linux" ] ; then
#  source /usr/local/projects/l4linux/.bash_l4linux
#  source /prj/l4linux/.bash_nativelinux -a 2.1 -g 3.4.4 # for 7200 Native Linux
#  source /prj/l4linux/.bash_l4.gcc344                  # for 6800 Linux on L4
alias work='cd /local/mnt/workspace/<ID>'
alias work2='cd /local/mnt2/workspace2/<ID>'
alias work3='cd /local/mnt/workspace3/<ID>'
alias setenv='source build/envsetup.sh'
alias l8974='lunch msm8974-userdebug'
alias l8226='lunch msm8226-userdebug'
alias l8x26='lunch msm8226-userdebug'
alias l8084='lunch apq8084-userdebug'
alias l8994='lunch msm8994-userdebug'
alias l8916='lunch msm8916_64-userdebug'
alias l8992='lunch msm8992-userdebug'
alias l8996='lunch msm8996-userdebug'
alias msm=msm8992
#fi

### Git command
alias gbr='git branch'
alias gcm='git commit'
alias gco='git checkout'
alias gst='git status'
alias gd='git diff'
alias gdf='git diff'
alias gad='git add'
alias gch='git cherry-pick'
alias gcl='git clean -x -f -d'
alias gf='git format-patch'
alias ghe='git help'
alias gres='git reset --hard HEAD'
alias gr='git rebase'
alias gre='git rebase'
alias gl='git log --oneline --decorate'
alias gll='git log --stat --decorate'
alias gs='git show'
alias gbl='git blame'

### Project path
alias av="cd frameworks/av"
alias af="cd frameworks/av/services/audioflinger"
alias hal="cd hardware/qcom/audio/hal"
alias nuplayer="cd frameworks/av/media/libmediaplayerservice/nuplayer"
alias msm="cd kernel/sound/soc/msm"
alias misc="cd kernel/drivers/misc/qcom/qdsp6v2"
alias audio_ion="cd kernel/drivers/soc/qcom/qdsp6v2"
alias codec="cd kernel/sound/soc/codecs"
alias dt="cd kernel/arch/arm64/boot/dts/qcom"
alias dtsi="cd kernel/arch/arm64/boot/dts/qcom"
alias defconfig="cd kernel/arch/arm64/configs"
alias kernel_driver="cd kernel/drivers/soc/qcom"
alias mm-audio="cd vendor/qcom/proprietary/mm-audio"
alias board="cd vendor/qcom/proprietary/common"
alias acdbdata="cd  vendor/qcom/proprietary/mm-audio/audcal/family-b/acdbdata"

#handy
alias path='echo -e ${PATH//:/\\n}'
alias now='date +"%T'
alias nowtime=now
alias nowdate='date +"%d-%m-%Y"'

# Stop after sending count ECHO_REQUEST packets #
alias ping='ping -c 5'

# Do not wait interval 1 second, go fast #
alias fastping='ping -c 100 -s.2'

#show open ports
alias ports='netstat -tulanp'

# distro specific  - Debian / Ubuntu and friends #
# install with apt-get
alias apt-get="sudo apt-get"
alias updatey="sudo apt-get --yes"

# update on one command
alias update='sudo apt-get update && sudo apt-get upgrade'

## pass options to free ##
alias meminfo='free -m -l -t'

## get top process eating memory
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'

## get top process eating cpu ##
alias pscpu='ps auxf | sort -nr -k 3'
alias pscpu10='ps auxf | sort -nr -k 3 | head -10'

## Get server cpu info ##
alias cpuinfo='lscpu'
