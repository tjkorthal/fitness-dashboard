# fitness-dashboard

Uses the Strava developer API to access and display user activity data
### Dependencies:
* npm
* Ruby 2.3+
* Bundler
* [Strava developer account](#Strava-app-setup)

## Project setup

1. Install front-end package dependencies
    ```
    npm install
    ```

2. Compile static assets

    The front end app is served up as static assets, so they'll need built each time changes are made.

    ```
    npm run build
    ```

3. Install back-end package dependencies
    ```
    cd server
    bundle install
    ```

4. Run the server from the `/server` directory
    ```
    CONSUMER_KEY=[YOUR CONSUMER KEY] CONSUMER_SECRET=[YOUR CONSUMER SECRET] rackup
    ```

## Strava app setup

You'll need a Strava developer account to use the Strava API to retrieve user data and activities.

1. Create a free Strava account at https://www.strava.com/register/free or use an existing account.

2. Register the application at https://www.strava.com/settings/api.

3. You'll need to be able to expose your local server endpoints to the Web in order to use Strava's OAuth webhooks; I use [ngrok](https://ngrok.com/), so my ngrok URL goes in the "website" field (eg https://abc123.ngrok.io), and the "Authorization callback domain" is ngrok.io.

4. When setting up the application server you'll need the consumer key and consumer secret to make API requests, and the app settings page is where you'll find those.

### Customize Vue configuration
See [Configuration Reference](https://cli.vuejs.org/config/).
