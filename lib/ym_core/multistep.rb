module YmCore::Multistep
  
  def self.included(base)
    base.send(:attr_writer, :current_step)
  end
  
  def current_step
    @current_step || steps.first
  end
  
  def current_step_gte(step_name)
    return nil if !steps.include?(current_step) || !steps.include?(step_name)
    steps.index(current_step) >= steps.index(step_name)
  end

  def steps
    %w{step1 step2}
  end
  
  def method_missing(method_name, *args)
    if method_name =~ /^current_step_(\w+)\?$/
      if steps.include?($1)
        current_step == $1
      else
        super
      end
    else
      super
    end
  end

  def next_step
    steps[steps.index(current_step)+1]
  end
  
  def next_step!
    self.current_step = next_step
  end

  def previous_step
    steps[steps.index(current_step)-1]
  end
  
  def previous_step!
    self.current_step = previous_step
  end

  def first_step?
    current_step == steps.first
  end

  def last_step?
    current_step == steps.last
  end

  def all_valid?
    steps.all? do |step|
      self.current_step = step
      valid?
    end
  end
  
end
