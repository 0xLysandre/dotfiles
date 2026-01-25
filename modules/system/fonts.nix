{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    # La recommandation standard pour LazyVim : JetBrains Mono
    nerd-fonts.jetbrains-mono
    # Optionnel : d'autres polices populaires
    nerd-fonts.meslo-lg
    nerd-fonts.fira-code
  ];
}
