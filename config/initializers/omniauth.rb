Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, '2602305cdfe8f666ecdd', '7d60607301ca8312836fba15171db6167613f9d5'
end
