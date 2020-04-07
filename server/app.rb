require 'sinatra'

# Static assets live here (output of `npm run build`)
set :public_folder, '../dist'

# Render index page at root. JS assumes / is the home page
get '/' do
  File.read(File.join('../dist', 'index.html'))
end

# THIS IS BAD. DON'T DO THIS IN PROD. Need to be smart about what redirects where. Assets and such.
# Tyler, 10 minutes later: Well yeah, but static assets get loaded first. Still need to be smart though.
# Show a decent 404 for garbage requests.
get '*' do
  redirect to '/'
end
