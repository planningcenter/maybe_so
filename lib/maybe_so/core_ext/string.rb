class String

  TRUTHY_VALUES = %w(y yes true t 1)

  def to_bool
    TRUTHY_VALUES.include? self.downcase
  end

end
