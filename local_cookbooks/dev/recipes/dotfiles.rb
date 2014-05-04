home = "/home/vagrant"

git "#{home}/dotfiles" do
  user "vagrant"
  group "vagrant"
  repository "git@github.com:pushrax/dotfiles.git"
  action :sync
  notifies :run, "bash[make dotfiles]", :immediately
end

bash "make dotfiles" do
  user "vagrant"
  group "vagrant"
  environment "HOME" => home
  cwd "#{home}/dotfiles"
  code "make"
  action :nothing
end
