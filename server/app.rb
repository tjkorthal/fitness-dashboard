# frozen_string_literal: true

require 'sinatra'
require 'sinatra/json'
require 'omniauth-strava'
require 'pry'

require_relative './activities_collection'
require_relative './strava/api_request'

use Rack::Session::Cookie, secret: 'beans'
use OmniAuth::Builder do
  # get these from developer page at https://www.strava.com/settings/api
  provider :strava, ENV['CONSUMER_KEY'], ENV['CONSUMER_SECRET'], scope: 'activity:read_all'
end

# Static assets live here (output of `npm run build`)
set :public_folder, '../dist'

# Render index page at root. JS assumes / is the home page
get '/' do
  File.read(File.join('../dist', 'index.html'))
end

get '/activities' do
  # DD-MM-YYYY format
  date = params['date'] || '01-01-2021'
  activities = Strava::APIRequest.new(token).fetch_activities
  collection = ActivitiesCollection.new(activities).since(date).as_json
  json collection
end

# to revoke app permission go to https://www.strava.com/settings/apps
get '/auth/strava/callback' do
  # raises OmniAuth::Strategies::OAuth2::CallbackError, access_denied on failure
  session['user_auth'] = request.env['omniauth.auth']
  redirect to '/'
end

# THIS IS BAD. DON'T DO THIS IN PROD. Need to be smart about what redirects where. Assets and such.
# Tyler, 10 minutes later: Well yeah, but static assets get loaded first. Still need to be smart though.
# Show a decent 404 for garbage requests.
get '*' do
  redirect to '/'
end

def token
  session['user_auth']['credentials']['token']
end
