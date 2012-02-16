module ActiveRecord

  class Base

    def to_s      
      if respond_to?(:name)
        name
      elsif respond_to?(:title)
        title
      else
        super
      end
    end

    scope :scoped_all

  end

end