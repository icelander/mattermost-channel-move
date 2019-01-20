#!/usr/bin/env ruby

require 'json'
require 'pp'

channel_name = ARGV[0]
team_name = ARGV[1]
data_file = ARGV[2]

# Make sure we can open the data file and return an error if not
if ! File.file?(data_file)
	return "#{data_file} does not exist"
end

channel_found = false

# Parse each line in the data file
File.readlines(data_file).each do |line|
	json_line = JSON.parse(line)

	case json_line['type']
		when 'version'
			puts json_line.to_json
		# If it's a channel...
		when 'channel'
			# If the channel name is what we're looking for...
			if json_line['channel']['name'] == channel_name
				channel_found = true
				# Change the team name to the user-specified one...
				json_line['channel']['team'] = team_name
				# And add it to the output
				puts json_line.to_json
			end
		# If it's a post...
		when 'post'
			# And if it belongs to the channel...
			if json_line['post']['channel'] == channel_name
				# Change the team name to the user-specified one...
				json_line['post']['team'] = team_name
				# And add it to the output
				puts json_line.to_json
			end
		# If it's a user...
		when 'user'
			# Check each of their team memberships...
			json_line['user']['teams'].each do |team|
				# And their channel memberships...
				team['channels'].each do |chan|
					# If their channel memberships include the channel name...
					if chan['name'] == 'channel_name'
						# Set the team name to the new team name...
						team['name'] = team_name
						# Clear the channel memberships except for that one...
						team['channels'] = chan
						# Clear the team memberships except for that one...
						json_line['user']['teams'] = [team]
						# And add it to the output
						puts json_line.to_json
					end
				end
			end		
	end
end