module Shared
  module Models
    class ApplicationRecord < ActiveRecord::Base
      primary_abstract_class
    end
  end
end