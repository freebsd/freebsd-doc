#!/usr/bin/env ruby
=begin

BSD 2-Clause License
Copyright (c) 2020-2025, The FreeBSD Project
Copyright (c) 2020-2025, Sergio Carlavilla <carlavilla@FreeBSD.org>

This script will generate the hardware notes

=end
require 'open3'

# Main method
puts "Processing hardware notes..."

if ARGV.length < 1 || ARGV.length > 1
  puts "Only expecting the release version"
  exit
end

hardwareNotesPath = ARGV[0]
hardwareNotesContent = ""

File.foreach(hardwareNotesPath).with_index do |line|
  if (line[/&hwlist.\b/])
    manualPage = line.gsub("&hwlist.", "").gsub(";", "").gsub("\n", "")

    if(File.exist?("tmp/share/man/man4/" + manualPage + ".4"))
      cmd = "mandoc -Tmarkdown tmp/share/man/man4/" + manualPage + ".4 | sed -n '/# HARDWARE/,/#/{/#/!p;}' "
      mandocOut, err, s = Open3::capture3(cmd)
      if s.success?
        hardwareNotesContent << mandocOut
      end
    else
      puts "WARNING: The manual page " + manualPage + " does not exists"
    end
  else
    hardwareNotesContent << line
  end
end

File.open(hardwareNotesPath, 'w') do |out|
  out << hardwareNotesContent
end
