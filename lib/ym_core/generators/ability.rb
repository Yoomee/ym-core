module YmCore::Generators
  
  module Ability

    def should_add_abilities?(model_name)
      File.exists?("#{Rails.root}/app/models/ability.rb") && !File.open("#{Rails.root}/app/models/ability.rb").read.include?(model_name)
    end

    def add_ability(roles, abilities)
      [*roles].each do |role|
        tabbed_space = role==:open ? "\n    " : "\n      "
        ability_string = tabbed_space + [*abilities].join(tabbed_space)
        insert_into_file "app/models/ability.rb", ability_string, :after => "#{role} ability", :force => true
      end
    end
    
  end

end