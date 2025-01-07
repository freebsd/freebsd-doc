#!/usr/bin/env ruby

=begin

BSD 2-Clause License
Copyright (c) 2020-2025, The FreeBSD Project
Copyright (c) 2020-2025, Sergio Carlavilla <carlavilla@FreeBSD.org>

This script will merge all the pgpkeys into one single file

=end

def getAllPGPKeys()
  return Dir.glob('./static/pgpkeys/*.key').sort
end

def processAllPGPKeys(keysFiles, pgpKeysFile)
  keysFiles.each{ |keyFile|
    processPGPKey(keyFile, pgpKeysFile)
  }
end

def processPGPKey(keyFile, pgpKeysFile)
  File.readlines(keyFile).each do |line|
    if # remove script comment and AsciiDoc syntax
        not line.include? "// sh addkey.sh" and
        not line.include? "[.literal-block-margin]" and
        not line.include? "...."
      pgpKeysFile.puts(line)
    end
  end
end

# Main method
keysFiles = getAllPGPKeys()

pgpKeysFile = File.new("./static/pgpkeys/pgpkeys.txt", "w")

processAllPGPKeys(keysFiles, pgpKeysFile)
