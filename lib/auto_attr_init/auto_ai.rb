# coding=utf-8
# license: Public Domain

module AutoAttrInit
  module AutoAi
    # @params names [String[]]
    def auto_attr_init *names
      aspect = AutoAiAspect.new self, names
      aspect.wrap self, :pre_initialize, nil, :initialize
    end
  end
end

class Class
  include AutoAttrInit::AutoAi
end
