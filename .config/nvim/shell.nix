{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell { nativeBuildInputs = with pkgs; [ lua rnix-lsp nixfmt ]; }
