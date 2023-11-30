class ApplicationController < ActionController::Base
  include WithBasicAuthentication
  include WithErrors
end
