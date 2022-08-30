require_relative './user_model'
require_relative '../domain/repositories/user_repository'
require_relative './user_mapper'

module Infra
  module Repositories
    class UserRepository < Domain::Identity::UserRepository
      include Singleton
      
      def initialize()
        @user = Infrastructure::Identity::User
        @mapper = Infra::Repositories::UserRepositoryMapper.new
      end

      def save(domain)
        user = @mapper.toPersistance(domain)
        user.save
      end

      def find_by_id(id)
        user = @user.find_by(id: id)
        return @mapper.toDomain(user)
      end

      def find_by_email(email)
        user = @user.find_by(email: email)
        return @mapper.toDomain(user)
      end
    end
  end
end