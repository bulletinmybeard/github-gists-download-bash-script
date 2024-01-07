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

# License
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
