# github-gists-download-bash-script

This bash script is designed to interact with the GitHub API to fetch and update gists for a given user.
It handles rate limits, paginates through gist pages, and downloads
or updates gists in a local directory based on their update status.

## Features
* Fetches user gists from GitHub
* Handles GitHub API rate limiting
* Checks for updates to gists and downloads them
* Supports pagination for users with many gists

## Prerequisites
* Bash shell (Unix/Linux/MacOS)
* `curl` and `jq` installed
* A GitHub account and API token with at least `gists` permission enabled

## Usage
* Make the script executable by using the command `chmod +x download_gists.sh`
* Run the script with `./download_gists.sh` (E.g., `./download_gists.sh bulletinmybeard *******`)

```bash
./download_gists.sh <username> <bearer_token>
```
* `<username>`: Your GitHub username.
* `<bearer_token>`: Your GitHub personal access token.

```bash
./download_gists.sh bulletinmybeard **********

You have 4719/5000 remaining API requests
=================================================

Processing Page #1
-------------------
export_bulletinmybeard/list-network-connections-and-transform-them-into-json.md is up to date.
export_bulletinmybeard/chat.openai.com-userscript.js is up to date.
export_bulletinmybeard/fix-cannot-connect-to-the-docker-daemon-error-on-macoslinux.md is up to date.
export_bulletinmybeard/bol.com-userscript.js is up to date.
export_bulletinmybeard/debug-python-apps-via-docker-composeyml-in-pycharm.md is up to date.
export_bulletinmybeard/local-nginx-server-site-with-valid-ssl-certificate.md is up to date.
export_bulletinmybeard/python-script-to-alter-file-creation-date-from-filename.md is up to date.
export_bulletinmybeard/macos-prevent-flux-from-automatically-toggling-light-and-dark-mode.md is up to date.
export_bulletinmybeard/change-default-login-shell-on-macos-ventura.md is up to date.
export_bulletinmybeard/customize-default-syntax-highlighter-in-atom-editor-macos--linux.md is up to date.
export_bulletinmybeard/list-installed-homebrew-packages-in-tree-view-macos.md is up to date.
export_bulletinmybeard/delete-all-node_modules-folders-recursively.md is up to date.
export_bulletinmybeard/resolve-tabnine-subscription-sync-issues-in-your-ide.md is up to date.
export_bulletinmybeard/using-prompt-eol-mark-to-remove-extra-trailing-mark-in-terminal-output.md is up to date.
export_bulletinmybeard/capture-audio-file-loudness-levels-with-ffmpeg-perl-regex-and-jq.md is up to date.
export_bulletinmybeard/change-bookmark-icons-in-chrome-desktop-with-the-favicon-changer-in-2023.md is up to date.
export_bulletinmybeard/sitemap-xml-location-for-custom-medium-blogs.md is up to date.
export_bulletinmybeard/macos-toggle-google-chrome-swipe-navigation.md is up to date.
export_bulletinmybeard/put-io-move-to-folder-modal-input-search-filter.md is up to date.
export_bulletinmybeard/accessing-private-aws-cloud-resources-from-your-local-machine.md is up to date.
export_bulletinmybeard/git-log-json-output.md is up to date.
export_bulletinmybeard/prowritingaid-com-auto-expand-menu-from-the-go.md is up to date.
export_bulletinmybeard/reset-macos-notifications.md is up to date.
export_bulletinmybeard/tinder-auto-like-userscript.md is up to date.
export_bulletinmybeard/macos-kill-audio-command.md is up to date.
export_bulletinmybeard/fix-virtualbox-docker-machine-host-issues.md is up to date.
export_bulletinmybeard/run-screensaver-delayed-in-termnial.md is up to date.
export_bulletinmybeard/use-redis-in-lua-script-nginx.md is up to date.
export_bulletinmybeard/fix-for-sudo-command-error-unable-to-initialize-pam-no-such-file-or-directory.md is up to date.
export_bulletinmybeard/enforce-macos-icloud-sync.md is up to date.

Processing Page #2
-------------------
export_bulletinmybeard/patching-macos-apps-with-working-and-valid-app-signature.md is up to date.
export_bulletinmybeard/list-of-user-agents.md is up to date.
export_bulletinmybeard/quick-guide-publish-npm-packages.md is up to date.
export_bulletinmybeard/content-scraping-with-browser-devtools.js.md is up to date.
export_bulletinmybeard/list-first-level-package-details.js.md is up to date.
export_bulletinmybeard/automatic-content-updates-in-a-running-ios-simulator-instance.md is up to date.
export_bulletinmybeard/disable-the-git-integration-in-visual-studio-code.md is up to date.
export_bulletinmybeard/sublime-text-3-user-settings.md is up to date.
export_bulletinmybeard/visual-studio-code-user-settings-json.md is up to date.

All gists have been processed!
```

## License
MIT License

Copyright (c) 2024 Robin Schulz

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
