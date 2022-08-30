require_relative '../domain/aggregates/user'
require_relative '../domain/aggregates/email'
require_relative './user_model'

module Infra
  module Repositories
    class UserRepositoryMapper
      def toDomain(model)
        email = Domain::Identity::Email.create(model.email)
        return Domain::Identity::User.create(email, model.id)
      end

      def toPersistance(domain)
        return Infrastructure::Identity::User.new(
          id: domain.id,
          email: domain.email.value
        )
      end
    end
  end
end