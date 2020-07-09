Rails.application.config.middleware.use OmniAuth::Builder do
    Dotenv.load
    provider :google_oauth2, '727517417516-vqjuia541mcbu2lq9v60o40hroi3kguf.apps.googleusercontent.com',
    'o-lq-hCb8NtqWO6wRkupp-t7', skip_jwt: true
end