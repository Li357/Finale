SecureHeaders::Configuration.default do |config|
  config.cookies = {
    secure: Rails.env.production? || SecureHeaders::OPT_OUT,
    samesite: {
      strict: true
    },
    httponly: {
      only: ['_fs'],
    },
  }
end
