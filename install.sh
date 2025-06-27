#!/bin/bash
REPO_URL="https://github.com/YOURNAME/astro-nebula-setup"
TARGET_DIR="$HOME/astro-nebula-setup"

if [ -d "$TARGET_DIR" ]; then
  echo "📁 Using existing directory at $TARGET_DIR"
else
  echo "⬇️ Cloning setup repo..."
  git clone "$REPO_URL" "$TARGET_DIR"
fi

cd "$TARGET_DIR/payload"
chmod +x setup.sh
./setup.sh
