module Utsusemi
  class Railtie < Rails::Railtie
    initializer 'utsusemi' do
      ActiveSupport.on_load :active_record do
        require 'utsusemi/base'
      end
    end
  end
end
