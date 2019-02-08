# Mattermost Team Mover

**NOTE:** This has not been tested and is currently a proof of concept.

## Usage

1. Generate a bulk export file [using the instructions here](https://docs.mattermost.com/administration/bulk-export.html). `data.orig.json` is provided for testing

2. Run the command. The parameters are follows

 - `team_name` : The name of the team that you want to move
 - `data_file` : The path to the data file.

3. Output is sent to `stdout`. Use redirection to send it into a file

## Example

```
./team_filter.rb odio-0 ./data.orig.json > odio-0.json
```

This will generate a file identical to the provided `odio-0.json`, with the channels, posts, and users who are members of the team.

## Known Issues

If there is a user who has left the team there may be posts and reactions that are associated with them. Unless this user is already on the server the bulk import will fail.