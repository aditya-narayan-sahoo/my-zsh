# Shell script for downloading YouTube videos and playlists using yt-dlp
# needs yt-dlp, fzf, xclip, ffmpeg, wl-clipboard

# To use it :
# save it on a location and then do : sudo chmod +x yt-downloader.sh

#!/bin/bash

# Colors
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

DEFAULT_DIR="$HOME/A.N.\$/YTDLnis"

# Confirm download directory
echo -e "${CYAN}📁 Choose or enter a download directory:${NC}"
DIR=$(echo -e "$DEFAULT_DIR\n$(pwd)\n$HOME/Downloads\nOther (enter manually)" | fzf --prompt="Select download dir: " --height=6)

if [[ "$DIR" == "Other (enter manually)" ]]; then
  read -e -p "Enter custom directory: " DIR
fi
DIR=$(eval echo "$DIR")
mkdir -p "$DIR" && echo -e "${GREEN}✅ Using directory: $DIR${NC}"

# Video or Playlist
TYPE=$(printf "Video\nPlaylist" | fzf --prompt="📺 Download Type: " --height=4)
TYPE="${TYPE,,}"

# Video quality selection
QUALITY_CHOICE=$(printf "720p\n1080p\nBest Available" | fzf --prompt="🎥 Select Quality: " --height=6)
case "$QUALITY_CHOICE" in
  "720p") QUALITY="bestvideo[height<=720]+bestaudio/best" ;;
  "1080p") QUALITY="bestvideo[height<=1080]+bestaudio/best" ;;
  "Best Available") QUALITY="bestvideo+bestaudio/best" ;;
esac

# File name template
read -e -p "📝 Filename template (default: %(title)s.%(ext)s): " TEMPLATE
TEMPLATE="${TEMPLATE:-%(title)s.%(ext)s}"

# 🧠 Read from clipboard if available
CLIPBOARD_URL=""
if command -v xclip &>/dev/null; then
  CLIPBOARD_URL=$(xclip -o -selection clipboard 2>/dev/null)
elif command -v wl-paste &>/dev/null; then
  CLIPBOARD_URL=$(wl-paste 2>/dev/null)
fi

# 📋 Prompt for URL
if [[ -n "$CLIPBOARD_URL" && "$CLIPBOARD_URL" =~ ^https?:// ]]; then
  echo -e "${CYAN}🔗 URL detected in clipboard:${NC} $CLIPBOARD_URL"
  URL_CHOICE=$(printf "Use Clipboard URL\nEnter Manually" | fzf --prompt="📋 Choose source of URL: " --height=4)
else
  URL_CHOICE="Enter Manually"
fi

if [[ "$URL_CHOICE" == "Use Clipboard URL" ]]; then
  URL="$CLIPBOARD_URL"
else
  read -e -p "🔗 Paste video/playlist URL: " URL
fi

# 🧹 Clean accidental duplicate paste like: https://youhttps://youtube...
URL=$(echo "$URL" | sed -E 's_.*(https?://)_\1_')

# Subtitles
SUBS=$(printf "No\nYes" | fzf --prompt="🗣️  Download Subtitles? " --height=4)
if [[ "$SUBS" == "Yes" ]]; then
  CAPTION_OPTS="--write-subs --write-auto-sub --sub-lang en --convert-subs srt"
else
  CAPTION_OPTS="--no-write-subs --no-write-auto-sub"
fi

echo ""

# Download logic (without cookies first)
if [[ "$TYPE" == "playlist" ]]; then
  echo -e "${YELLOW}📃 Downloading playlist...${NC}"
  yt-dlp --yes-playlist --continue --no-overwrites $CAPTION_OPTS -o "${DIR}/${TEMPLATE}" -f "$QUALITY" "$URL"
  DOWNLOAD_EXIT_CODE=$?
else
  echo -e "${YELLOW}🎞️ Downloading video...${NC}"
  yt-dlp --no-playlist --continue --no-overwrites $CAPTION_OPTS -o "${DIR}/${TEMPLATE}" -f "$QUALITY" "$URL"
  DOWNLOAD_EXIT_CODE=$?
fi

# If download failed due to age-restriction (exit code 4), retry with cookies
if [[ $DOWNLOAD_EXIT_CODE -eq 4 ]]; then
  echo -e "${RED}⚠️  Age restriction detected. Retrying with cookies...${NC}"

  if [[ "$TYPE" == "playlist" ]]; then
    yt-dlp --yes-playlist --cookies-from-browser brave --continue --no-overwrites $CAPTION_OPTS -o "${DIR}/${TEMPLATE}" -f "$QUALITY" "$URL"
  else
    yt-dlp --no-playlist --cookies-from-browser brave --continue --no-overwrites $CAPTION_OPTS -o "${DIR}/${TEMPLATE}" -f "$QUALITY" "$URL"
  fi

  echo -e "${GREEN}✅ Video download complete with cookies.${NC}"
fi
