module ActiveRecord

  class Base
    
    scope :scoped_all

    def to_s
      if respond_to?(:name)
        name
      elsif respond_to?(:title)
        title
      else
        super
      end
    end

  end

end