# frozen_string_literal: true
class ApplicationController < ActionController::API
  include ActionController::Cookies
  include AuthorizationHelper
  include SessionHelper
end
