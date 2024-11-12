## About

This is a simple repository for my dotfiles.

## Setup

1. Install homebrew.

2. Install dependencies

    ```shell
    brew bundle install --file=./brew/Brewfile
    ```

3. Link configurations

    ```shell
    stow --target ~/ zsh
    stow --target ~/.config .
    ```

