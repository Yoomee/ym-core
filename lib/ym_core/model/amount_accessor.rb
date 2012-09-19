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
      define_method("#{attr}_before_typecast") do
        if instance_variable_defined?("@#{attr}")
          instance_variable_get("@#{attr}")
        else
          val = send("#{attr}_in_pence")
          val.try(:is_number?) ? YmCore::Model::AmountAccessor::Float.new((val.to_f / 100).round(2)) : val
        end
      end
      define_method(attr) do
        if instance_variable_defined?("@#{attr}")
          val = instance_variable_get("@#{attr}")
          YmCore::Model::AmountAccessor::Float.new(val.to_f.round(2))
        else
          val = send("#{attr}_in_pence")
          YmCore::Model::AmountAccessor::Float.new((val.to_f / 100).round(2))
        end
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