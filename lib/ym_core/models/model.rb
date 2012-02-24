module YmCore::Model
  
  def self.included(base)
    base.scope :without, (lambda do |item_or_array|
      if item_or_array.is_a?(Array)
        base.where(["pages.id NOT IN (?)", item_or_array.collect(&:id).reject(&:nil?)])
      else
        item_or_array.try(:id) ? base.where(["pages.id != ?", item_or_array.id]) : base.scoped
      end
    end)
  end

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