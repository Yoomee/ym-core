module YmCore::Model
  
  def self.included(base)
    base.scope :without, (lambda do |item_or_array|
      if item_or_array.is_a?(Array)
        array = item_or_array.collect{|i| i.try(:id)}.reject(&:nil?)
        array.empty? ? base.scoped : base.where(["pages.id NOT IN (?)", array])
      else
        item_or_array.try(:id) ? base.where(["pages.id != ?", item_or_array.id]) : base.scoped
      end
    end)
  end
  
end