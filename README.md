# Mattermost Channel Mover

**NOTE:** This has not been tested and is currently a proof of concept.

## Usage

1. Generate a bulk export file [using the instructions here](https://docs.mattermost.com/administration/bulk-export.html). `data.orig.json` is provided for testing

2. Run the command. The parameters are follows

 - `channel_name` : The name of the channel that you want to move
 - `team_name` : The name of the team you're moving the channel to
 - `data_file` : The path to the data file.

3. Output is sent to `stdout`. Use redirection to send it into a file

## Example

```
./channel_filter.rb nesciunt-2 a-team ./data.orig.json > nesciunt-2.json
```

This will generate a file identical to the provided `nesciunt-2.json`, with the posts and users who are members of the channel.