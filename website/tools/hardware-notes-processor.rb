#!/usr/bin/env ruby
=begin

BSD 2-Clause License
Copyright (c) 2020-2026, The FreeBSD Project
Copyright (c) 2020-2026, Sergio Carlavilla <carlavilla@FreeBSD.org>

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
      cmd = "mandoc -Tmarkdown tmp/share/man/man4/" + manualPage + ".4 | sed -n '/^# HARDWARE/,/^# /{ /^# /d; p; }'"
      mandocOut, err, s = Open3::capture3(cmd)
      if s.success?
        #replace \_ to _ in drivers name and description
        mandocOut.gsub!(/\\_/, '_')

        # extract Nm (real driver name)
        nm_cmd = "grep -m1 '^\\.Nm' tmp/share/man/man4/#{manualPage}.4"
        nmOut, err2, s2 = Open3.capture3(nm_cmd)

        if s2.success?

          nm = nmOut.split[1]

          if nm && !nm.empty?
            driverName = File.basename(manualPage)

            if nm != driverName
              # f.e man ar40xx has driver name ar40xx_switch
              man_link = "link:https://man.freebsd.org/cgi/man.cgi?query=#{driverName}&amp;apropos=&amp;&sektion=4&amp;format=html[#{nm}]"
            else
              man_link = "man:#{driverName}[4]"
            end
            # replace only first occurrence, preserving markdown formatting
            mandocOut.sub!(/[*_]*#{nm}[*_]*/) do
              man_link
            end
          end
        end

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
