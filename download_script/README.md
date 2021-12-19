# Lego Instruction Download Script

## Description
This project uses ruby library 'watir' to open a browser and pull up the pages to download instructions

## Configuration
Setup a 'config.rb' file in the root of the download_script directory to indicate the root lego url and that you will be using

## Installation

- gem install 'watir' - Main library for scripting browser interactions
- gem install 'webdrivers' - Web driver gem  which allows the script to access the local browser
- gem install 'optimist' - For managing ruby program inputs

## How to use
The --sets string should be a space seperate list of all the set ID's you'd like to download

`
ruby script.rb --sets '75300 75301'
`
