HoptoadNotifier.configure do |config|
  config.api_key = {:project => 'movie-collector',  # the identifier you specified for your project in Redmine
                    :tracker => 'Bug',                            # the name of your Tracker of choice in Redmine
                    :api_key => 'xX159pjC8H4OrQR67hfS',           # the key you generated before in Redmine (NOT YOUR HOPTOAD API KEY!)
                    :category => 'Development',                   # the name of a ticket category (optional.)
                   }.to_yaml
  config.host = 'projects.invalid8.com'                           # the hostname your Redmine runs at
  config.port = 80                                                # the port your Redmine runs at
  config.secure = false                                           # sends data to your server via SSL (optional.)
end