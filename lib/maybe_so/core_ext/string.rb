class String

  def to_bool
    MaybeSo::DEFAULT_TRUTHY_VALUES.include? self.downcase
  end

end
