module Infrastructure
  module Identity
    class User < ApplicationRecord
      attribute :id, :string
      attribute :email, :string
    end
  end
end