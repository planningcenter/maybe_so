require "maybe_so/core_ext"
require "maybe_so/version"

begin
  require "active_model"
  require "maybe_so/active_model"
rescue LoadError
end


module MaybeSo
  DEFAULT_TRUTHY_VALUES = %w(y yes true t 1)
end
