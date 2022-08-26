module Infra
  module Repositories
    class OrderRepository < Domain::Identity::UserRepository
      def initialize(model = {})
        @user = model.fetch(:user) { Infrastructure::Identity::User }
      end

      def save(user)
        user.save
      end

      def find_by_id(id)
        @user.find_by(id: id)
      end
    end
  end
end