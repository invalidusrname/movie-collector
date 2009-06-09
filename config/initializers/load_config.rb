#!/usr/bin/env ruby

APP_CONFIG = YAML.load_file("#{RAILS_ROOT}/config/config.yml")

ENV['AMAZONRCDIR'] = "#{RAILS_ROOT}/config"
ENV['AMAZONRCFILE'] = 'amazonrc.txt'
