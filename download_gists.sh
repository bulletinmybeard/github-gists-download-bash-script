#!/bin/bash

set -e

# Check if a username and bearer token are provided as arguments
if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Usage: $0 <username> <bearer_token>"
    exit 1
fi

# Assign the provided username and bearer token to variables
username="${1}"
bearer_token="${2}"

# Create a directory based on the username if it doesn't exist
export_dir="./exports/${username}"
mkdir -p "$export_dir"

# cURL helper function
run_curl_cmd() {
    local url=$1
    curl -sS \
        -H "Accept: application/vnd.github+json" \
        -H "Authorization: Bearer ${bearer_token}" \
        -H "X-GitHub-Api-Version: 2022-11-28" \
        "$url"
}

# Fetch and process the rate limit info
fetch_rate_limit() {
   rate_limit_url="https://api.github.com/rate_limit"
   response=$(run_curl_cmd "$rate_limit_url")
   echo "$response" | jq '.rate'
}

convert_timestamp_to_date() {
    local timestamp=$1
    # Use date command to convert the UNIX timestamp
    # '%F %T' will output the date in 'YYYY-MM-DD HH:MM:SS' format
    date -r "$timestamp" '+%F %T'
}

calculate_time_until_reset() {
    local reset_timestamp=$1

    # Get the current time in Unix timestamp
    current_timestamp=$(date +%s)

    # Calculate the difference in seconds
    diff_seconds=$((reset_timestamp - current_timestamp))

    # Check if the difference is negative (reset time has passed)
    if [ $diff_seconds -lt 0 ]; then
        echo "The reset time has already passed."
        return
    fi

    # Convert the difference to hours, minutes, and seconds
    hours=$(printf "%02d" $((diff_seconds / 3600)))
    minutes=$(printf "%02d" $(( (diff_seconds % 3600) / 60 )))
    seconds=$(printf "%02d" $(( diff_seconds % 60 )))

    echo "${hours}:${minutes}:${seconds}"
}

rate_limit_info=$(fetch_rate_limit)
request_limit=$(echo "$rate_limit_info" | jq '.limit')
remaining_requests=$(echo "$rate_limit_info" | jq '.remaining')
limit_reset=$(echo "$rate_limit_info" | jq '.reset')
limit_reset_datetime=$(convert_timestamp_to_date "$limit_reset")
time_until_reset=$(calculate_time_until_reset "$limit_reset")

# Check the current usage
if [ "$remaining_requests" -ne 0 ]; then
    printf "\nYou have %s/%s remaining API requests\n=================================================\n" "$remaining_requests" "$request_limit"
else
    echo "You hit the API request limit ($request_limit). Limit will reset in: $time_until_reset ($limit_reset_datetime)"
    exit 0
fi

# Adjust adjust the local timestamp for CET to UTC
adjust_for_cet_to_utc() {
    local timestamp=$1
    # Define the timezone offset from UTC (in hours)
    timezone_offset=1
    offset_seconds=$((timezone_offset * 3600))
    echo "$timestamp - $offset_seconds"
}

# Fetch and process paginated gists
fetch_paginated_gists() {
    local page=$1
    local url="https://api.github.com/users/${username}/gists?page=${page}"

    # Fetch the gists for the current page using the Bearer token
    gists=$(run_curl_cmd "$url")

    # Count the number of gists in the response
    gist_count=$(echo "$gists" | jq '. | length')

    # Check if the response is empty
    if [ "$gist_count" -eq 0 ]; then
      echo "end"
    fi

    # Process the gists
    echo "$gists" | jq -r '.[] | {url: .files | to_entries[] | .value.raw_url, updated_at} | @base64' | \
    while IFS= read -r line; do
        # Decode the JSON string
        json=$(echo "$line" | base64 -D)

        # Extract the URL and updated_at value
        url=$(echo "$json" | jq -r '.url')
        updated_at=$(echo "$json" | jq -r '.updated_at')

        # Convert updated_at to seconds since Unix epoch (UTC)
        updated_at=$(date -jf "%Y-%m-%dT%H:%M:%SZ" "$updated_at" +%s)

        # Extract filename and create a path within the export directory
        filename=$(basename "$url")
        file_path="${export_dir}/${filename}"

        # Check if the file exists
        if [ -f "$file_path" ]; then
            # Get the last modification time of the local file in seconds since Unix epoch (local time)
            local_updated_at=$(date -r "$file_path" +%s)
            # Adjust local file timestamp from CET to UTC
            local_updated_at=$(adjust_for_cet_to_utc $local_updated_at)

            local_updated_at_int=$((local_updated_at))
            updated_at_int=$((updated_at))

            # Download the file if the local copy is older
            if [ "$local_updated_at_int" -lt "$updated_at_int" ]; then
                echo "Updating '$file_path' as it is older than the remote version."
                curl -sS -o "$file_path" "$url"
            else
                echo "'$file_path' is up to date."
            fi
        else
            echo "Downloading new file: '$file_path'"
            curl -sS -o "$file_path" "$url"
        fi
    done
}

# Main loop to iterate over gist pages
page=1
while true; do
    page_result=$(fetch_paginated_gists "$page")

    if [[ -n "$page_result" ]] && [[ "$page_result" != *"end"* ]]; then
        printf "\nProcessing Page #%s\n-------------------\n" "$page"
        echo "$page_result"
        ((page++))
    else
        printf "\nAll gists have been processed!"
        break
    fi
done
