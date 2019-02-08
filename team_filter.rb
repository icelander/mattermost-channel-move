#!/usr/bin/env ruby

require 'json'
require 'pp'

team_name = ARGV[0]
data_file = ARGV[1]

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

		# If it's a team...
		when 'team'
			# If the team matches the one we're looking for...
			if json_line['team']['name'] == team_name
				# add it to the output
				puts json_line.to_json
			end
		# If it's a channel...
		when 'channel'
			# If the channel name belongs to the team we're looking for...
			if json_line['channel']['team'] == team_name
				# Add it to the output
				puts json_line.to_json
			end
		# If it's a post...
		when 'post'
			# And if it belongs to the team...
			if json_line['post']['team'] == team_name
				# Add it to the output
				puts json_line.to_json
			end
		# If it's a user...
		when 'user'
			# Check each of their team memberships...
			json_line['user']['teams'].each do |team|
				# If they belong to that team
				if team['name'] == team_name
					# Clear the team memberships except for that one...
					json_line['user']['teams'] = [team]
					# And add it to the output
					puts json_line.to_json
				end
			end		
	end
end