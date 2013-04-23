require 'will_paginate'
require 'bootstrap-will_paginate'
require "ym_core/engine"
require 'haml'
require 'jquery-rails'
require 'jquery-ui-rails'
require 'formtastic'
require 'dragonfly'
require 'rails_rinku'
require 'html_truncator'
require 'randumb'

module YmCore
end

require 'rails_config'

require 'ym_core/generators/ability'
require 'ym_core/generators/migration'
require 'ym_core/image_downloader'
require 'ym_core/model'
require 'ym_core/model/amount_accessor'
require 'ym_core/model/country_accessor'
require 'ym_core/model/date_accessor'
require 'ym_core/multistep'