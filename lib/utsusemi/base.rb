module Utsusemi
  extend ActiveSupport::Concern

  module ClassMethods
    def acts_as_utsusemi(callback: nil)
      after_destroy callback || -> (caller) {
        deleted_class = caller.class.deleted_class
        attributes = caller.attributes.slice(*deleted_class.column_names)
        attributes.merge!(deleted_at: Time.current)
        deleted_class.create(attributes)
      }
    end

    def only_deleted
      deleted_class.all
    end
    alias :deleted :only_deleted

    def deleted_class
      "deleted_#{table_name}".classify.constantize
    end
  end
end

class ActiveRecord::Base
  include Utsusemi
end
