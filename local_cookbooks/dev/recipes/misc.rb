execute "use zsh as default shell" do
  command "chsh -s $(which zsh) vagrant"
end
