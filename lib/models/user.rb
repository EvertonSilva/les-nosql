class User
  attr_accessor :id, :email, :passwd, :rember_token

  def initialize(email, passwd)
    @id = 1
    @email = email
    @passwd = passwd
  end

  def is_equal?(other)
    return self.email == other.email && self.passwd == other.passwd
  end

end