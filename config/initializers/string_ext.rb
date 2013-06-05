class String

  def valid_email?
    if self =~ /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/
      true
    else
      false
    end
  end

  def is_number?
    true if Float(self) rescue false
  end
  
end