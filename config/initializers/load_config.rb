APP_CONFIG = YAML.load_file("#{Rails.root}/config/config.yml")

DO_NOT_REPLY = APP_CONFIG['mail']['no_reply']

ENV['AMAZONRCDIR'] = "#{Rails.root}/config"
ENV['AMAZONRCFILE'] = 'amazonrc.txt'
