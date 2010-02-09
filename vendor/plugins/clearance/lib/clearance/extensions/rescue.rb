if defined?(ActionDispatch::ShowExceptions)
  ActionDispatch::ShowExceptions.rescue_responses.update('ActionController::Forbidden' => :forbidden)
end
