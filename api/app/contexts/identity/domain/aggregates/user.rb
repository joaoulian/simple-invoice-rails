require 'securerandom'
require_relative '../../../../shared/domain/email'

module Domain
  module Identity
    class User
      def initialize(email, id)
        @email = email
        @id = id
      end

      def email
        @email
      end

      def id
        @id
      end

      private_class_method :new

      def self.create(email, id = SecureRandom.uuid)
        raise 'Invalid e-mail' unless email.instance_of? Email
        
        instance = new(email, id)
        return instance
      end
    end
  end
end