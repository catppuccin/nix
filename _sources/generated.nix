# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub, dockerTools }:
{
  alacritty = {
    pname = "alacritty";
    version = "3c808cbb4f9c87be43ba5241bc57373c793d2f17";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "alacritty";
      rev = "3c808cbb4f9c87be43ba5241bc57373c793d2f17";
      fetchSubmodules = false;
      sha256 = "sha256-w9XVtEe7TqzxxGUCDUR9BFkzLZjG8XrplXJ3lX6f+x0=";
    };
    date = "2022-09-27";
  };
  bat = {
    pname = "bat";
    version = "ba4d16880d63e656acced2b7d4e034e4a93f74b1";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "bat";
      rev = "ba4d16880d63e656acced2b7d4e034e4a93f74b1";
      fetchSubmodules = false;
      sha256 = "sha256-6WVKQErGdaqb++oaXnY3i6/GuH2FhTgK0v4TN4Y0Wbw=";
    };
    date = "2022-11-10";
  };
  bottom = {
    pname = "bottom";
    version = "c0efe9025f62f618a407999d89b04a231ba99c92";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "bottom";
      rev = "c0efe9025f62f618a407999d89b04a231ba99c92";
      fetchSubmodules = false;
      sha256 = "sha256-VaHX2I/Gn82wJWzybpWNqU3dPi3206xItOlt0iF6VVQ=";
    };
    date = "2022-12-30";
  };
  btop = {
    pname = "btop";
    version = "89ff712eb62747491a76a7902c475007244ff202";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "btop";
      rev = "89ff712eb62747491a76a7902c475007244ff202";
      fetchSubmodules = false;
      sha256 = "sha256-J3UezOQMDdxpflGax0rGBF/XMiKqdqZXuX4KMVGTxFk=";
    };
    date = "2023-06-07";
  };
  grub = {
    pname = "grub";
    version = "803c5df0e83aba61668777bb96d90ab8f6847106";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "grub";
      rev = "803c5df0e83aba61668777bb96d90ab8f6847106";
      fetchSubmodules = false;
      sha256 = "sha256-/bSolCta8GCZ4lP0u5NVqYQ9Y3ZooYCNdTwORNvR7M0=";
    };
    date = "2022-12-29";
  };
  gtk = {
    pname = "gtk";
    version = "d6d1e951e48fdadb61838aa5238c59db40f4d38e";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "gtk";
      rev = "d6d1e951e48fdadb61838aa5238c59db40f4d38e";
      fetchSubmodules = false;
      sha256 = "sha256-wgZF8mQhUvWNds0zlWFoefRnBk7lqy2dfAbDxcMPHl0=";
    };
    date = "2023-07-04";
  };
  helix = {
    pname = "helix";
    version = "5677c16dc95297a804caea9161072ff174018fdd";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "helix";
      rev = "5677c16dc95297a804caea9161072ff174018fdd";
      fetchSubmodules = false;
      sha256 = "sha256-aa8KZ7/1TXcBqaV/TYOZ8rpusOf5QeQ9i2Upnncbziw=";
    };
    date = "2023-04-06";
  };
  kitty = {
    pname = "kitty";
    version = "4820b3ef3f4968cf3084b2239ce7d1e99ea04dda";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "kitty";
      rev = "4820b3ef3f4968cf3084b2239ce7d1e99ea04dda";
      fetchSubmodules = false;
      sha256 = "sha256-uZSx+fuzcW//5/FtW98q7G4xRRjJjD5aQMbvJ4cs94U=";
    };
    date = "2023-06-09";
  };
  lazygit = {
    pname = "lazygit";
    version = "b2ecb6d41b6f54a82104879573c538e8bdaeb0bf";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "lazygit";
      rev = "b2ecb6d41b6f54a82104879573c538e8bdaeb0bf";
      fetchSubmodules = false;
      sha256 = "sha256-9BBmWRcjNaJE9T0RKVEJaSnkrbMom0CLYE8PzAT6yFw=";
    };
    date = "2023-05-02";
  };
  neovim = {
    pname = "neovim";
    version = "057c34f849cf21059487d849e2f3b3efcd4ee0eb";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "nvim";
      rev = "057c34f849cf21059487d849e2f3b3efcd4ee0eb";
      fetchSubmodules = false;
      sha256 = "sha256-MSZcIrV3vvgb5mlMpO5uRlAYoENm2pZyuZbV5Q9Vg58=";
    };
    date = "2023-07-29";
  };
  polybar = {
    pname = "polybar";
    version = "9ee66f83335404186ce979bac32fcf3cd047396a";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "polybar";
      rev = "9ee66f83335404186ce979bac32fcf3cd047396a";
      fetchSubmodules = false;
      sha256 = "sha256-bUbSgMg/sa2faeEUZo80GNmhOX3wn2jLzfA9neF8ERA=";
    };
    date = "2022-10-05";
  };
  starship = {
    pname = "starship";
    version = "5629d2356f62a9f2f8efad3ff37476c19969bd4f";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "starship";
      rev = "5629d2356f62a9f2f8efad3ff37476c19969bd4f";
      fetchSubmodules = false;
      sha256 = "sha256-nsRuxQFKbQkyEI4TXgvAjcroVdG+heKX5Pauq/4Ota0=";
    };
    date = "2023-07-13";
  };
  sway = {
    pname = "sway";
    version = "c89098fc3517b64f0422aaaccb98dcab6ae9348f";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "sway";
      rev = "c89098fc3517b64f0422aaaccb98dcab6ae9348f";
      fetchSubmodules = false;
      sha256 = "sha256-6Cvsmdl3OILz1vZovyBIuuSpm207I3W0dmUGowR9Ugk=";
    };
    date = "2023-02-23";
  };
  tmux = {
    pname = "tmux";
    version = "e7b50832f9bc59b0b5ef5316ba2cd6f61e4e22fc";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "tmux";
      rev = "e7b50832f9bc59b0b5ef5316ba2cd6f61e4e22fc";
      fetchSubmodules = false;
      sha256 = "sha256-9ZfUqEKEexSh06QyR5C+tYd4tNfBi3PsA+STzUv4+/s=";
    };
    date = "2023-06-30";
  };
}