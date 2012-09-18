module YmCore::Model
  
  def self.included(base)
    base.scope :without, (lambda do |ids_or_records|
      array = [*ids_or_records].collect{|i| i.is_a?(Integer) ? i : i.try(:id)}.reject(&:nil?)
      array.empty? ? base.scoped : base.where(["#{base.table_name}.id NOT IN (?)", array])
    end)
    base.send(:include, YmCore::Model::DateAccessor)
    base.send(:include, YmCore::Model::AmountAccessor)
  end

  def all_present?(*attrs)
    attrs.all? {|attr| send(attr).present?}
  end
  
  def any_present?(*attrs)
    attrs.any? {|attr| send(attr).present?}
  end
  
end