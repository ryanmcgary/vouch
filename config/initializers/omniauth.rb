Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'lWhC1EGhIfKBvoq2UF8NYA', 'wIKOVMZx9GhRGZ6Cq5JNAXSGhoJ80yVTaBlL6rt9kvI'
  provider :facebook, '191045274269033', 'db353dc235f31970c72e3df132f61993'
  # TODO: add linkedin provider 
  # TODO: make sure providers work after deployment 
end