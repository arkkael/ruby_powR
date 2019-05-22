require 'sinatra' 		# Our handy lightweight webserver
require 'rest-client' 	# Used for authentication with the GitHub OAuth API
require 'json' 			# Used to parse the JSON response from the GitHub OAuth API
require 'sinatra/activerecord'

CLIENT_ID = '8ba7418c10595b6bc125'
CLIENT_SECRET = '79c283d6f679f928520dd91b7f99b2767948498d'

# This is our login page that loads up our index.erb view
# and brings our CLIEND_ID along for the ride.
get '/' do
  erb :index, :locals => {:client_id => CLIENT_ID}
end


# This is our 'logged-in' view, displaying profile.erb after the user has
# authenticated with GitHub (this is the 'callback URL' we entered when
# registering our OAUth Application on GitHub.com).
get '/profile' do
  # Retrieve temporary authorization grant code
  session_code = request.env['rack.request.query_hash']['code']
  
  # POST Auth Grant Code + CLIENT_ID/SECRECT in exchange for our access_token
  response = RestClient.post('https://github.com/login/oauth/access_token',
                  # POST payload
                  {:client_id => CLIENT_ID,
                  :client_secret => CLIENT_SECRET,
                  :code => session_code}
                 )

  access_token = JSON.parse(response)['access_token']
  erb :profile
end