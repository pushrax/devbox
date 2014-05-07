package 'build-essential'
package 'curl'
package 'git'
package 'htop'
package 'ntp'
package 'unzip'
package 'vim-nox'
package 'zsh'
package 'tmux'

# Reasonable for a dev box, but don't do this in production!
execute 'apt-get -y upgrade'
