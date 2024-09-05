
if [ -d "/opt/homebrew/bin/brew" ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi


# Added by Toolbox App
if [ -d "/Users/haaja/Library/Application Support/JetBrains/Toolbox/scripts" ]; then
    export PATH="$PATH:/Users/haaja/Library/Application Support/JetBrains/Toolbox/scripts"
fi

