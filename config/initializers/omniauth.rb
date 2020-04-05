Rails.application.config.middleware.use OmniAuth::Builder do
    provider :google_oauth2, ENV['727517417516-vqjuia541mcbu2lq9v60o40hroi3kguf.apps.googleusercontent.com'], ENV['o-lq-hCb8NtqWO6wRkupp-t7']
end