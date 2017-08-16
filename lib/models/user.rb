class User
  attr_accessor :id, :email, :passwd

  def initialize(email, passwd)
    @id = SecureRandom.uuid[0..3]
    @email = email
    @passwd = passwd
  end

  def is_equal?(other)
    return self.email == other.email && self.passwd == other.passwd
  end

end