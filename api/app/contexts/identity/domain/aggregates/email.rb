require 'uri'

module Domain
  module Identity
    class Email
      def initialize(value)
        @value = value
      end

      def value
        @value
      end

      private_class_method :new

      def self.create(email)
        if email =~ URI::MailTo::EMAIL_REGEXP
          instance = new(email)
          return instance
        else
          raise 'bad argument'
        end
      end
    end
  end
end