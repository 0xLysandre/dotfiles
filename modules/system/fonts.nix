{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    # Nouvelle syntaxe simplifiée pour les versions récentes
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only
  ];
}
