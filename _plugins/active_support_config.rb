begin
  require 'active_support'
  ActiveSupport.to_time_preserves_timezone = true
rescue LoadError
  # ActiveSupport not available — nothing to configure
end
