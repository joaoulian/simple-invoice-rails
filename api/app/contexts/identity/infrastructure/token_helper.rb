class TokenHelper
  include Singleton

  TOKEN_LENGTH = 24

  def initialize()
    @tokens = {}
  end

  def generate_token(user_id)
    invalidate_all_user_tokens(user_id)
    token = SecureRandom.base58(TOKEN_LENGTH)
    @tokens[token] = user_id
    return token
  end

  def get_user_id_from_token(token)
    return @tokens[token]
  end

  private def invalidate_all_user_tokens(user_id)
    @tokens.each do |key, value|
      if value == user_id
        invalidate_token(key)
      end
    end
  end
  
  private def invalidate_token(token)
    @tokens.delete(token)
  end
end