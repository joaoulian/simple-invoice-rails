module Infrastructure
  module Identity
    class User < ApplicationRecord
      attribute :email, :string
    end
  end
end