class Integer

  def to_word
    if Integer::NUMBER_WORDS.include?(self)
      Integer::NUMBER_WORDS[self]
    elsif self < 100
      "#{Integer::NUMBER_WORDS["#{self.to_s[0]}0".to_i]} #{Integer::NUMBER_WORDS[self.to_s[1].to_i]}"
    elsif self < 1000
      "#{Integer::NUMBER_WORDS[self.to_s[0].to_i]} hundred and #{Integer::NUMBER_WORDS["#{self.to_s[1]}0".to_i]} #{Integer::NUMBER_WORDS[self.to_s[1].to_i]}"
    end
  end
  
end

Integer::NUMBER_WORDS = {0=>"zero", 1=>"one", 2=>"two", 3=>"three",4=>"four", 5=>"five",6=>"six", 7=>"seven", 8=>"eight",9=>"nine",10=>"ten",11=>"eleven",12=>"twelve",13=>"thirteen",14=>"fourteen",15=>"fifteen",16=>"sixteen",17=>"seventeen",18=>"eighteen",19=>"nineteen",20=>"twenty",30=>"thirty",40=>"fourty",50=>"fifty",60=>"sixty",70=>"seventy",80=>"eighty",90=>"ninty"}