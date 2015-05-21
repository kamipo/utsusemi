require 'active_support'

begin
  require 'rails'
rescue LoadError
  # nothing to do! yay!
end

if defined? Rails
  require 'utsusemi/railtie'
else
  ActiveSupport.on_load :active_record do
    require 'utsusemi/base'
  end
end
