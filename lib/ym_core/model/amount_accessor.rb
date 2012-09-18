module YmCore::Model::AmountAccessor
  
  def self.included(base)
    base.extend(ClassMethods)
  end
  
  module ClassMethods
    
    def amount_accessor(*attrs)
      attrs << :amount if attrs.empty?
      attrs.each do |attr|
        amount_validation(attr)
        amount_reader(attr)
        amount_writer(attr)
      end
    end
    
    private
    def amount_validation(attr)
      self.validates(attr, "#{attr}_in_pence", :numericality => { :only_integer => true, :greater_than => 0, :allow_blank => true })
    end
    
    def amount_reader(attr)
      attr = attr.to_s
      define_method(attr) do
        return instance_variable_get("@#{attr}") if instance_variable_defined?("@#{attr}")
        pence_val = send("#{attr}_in_pence") 
        return pence_val if !pence_val.try(:is_number?)
        YmCore::Model::AmountAccessor::Float.new((pence_val.to_f / 100).round(2))
      end
    end

    def amount_writer(attr)
      attr = attr.to_s
      define_method("#{attr}=") do |val|
        instance_variable_set("@#{attr}", val)
        val = (val.to_f * 100).round(2).to_i if val.try(:is_number?)
        self.send("#{attr}_in_pence=", val)
      end
    end
    
  end
  
  class Float < DelegateClass(Float)

    def to_s
      str = super
      str.is_number? ? ("%.2f" % self) : str
    end

  end
  
end