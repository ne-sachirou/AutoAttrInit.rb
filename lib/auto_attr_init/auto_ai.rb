# coding=utf-8

module AutoAttrInit
  module AutoAi
    # @params names [String[]]
    def auto_attr_init *names
      aspect = AutoAiAspect.new self, names
      aspect.wrap self, :pre_initialize, nil, :initialize
    end
  end

  # RubyistたちのDRY症候群との戦い
  # http://melborne.github.io/2013/09/27/auto-attr-set-in-ruby/
  module AutoAiAutoSetter
    @@auto_attr_init_finished = false

    def new *args, &block
      unless @@auto_attr_init_finished
        names = self.instance_method(:initialize).parameters.
          collect{|param| param[1] }.
          select{|name| name.to_s =~ /^＠/ }
        unless names.empty?
          auto_attr_init *names
          @@auto_attr_init_finished = true
        end
      end
      super *args, &block
    end
  end
end

class Class
  include AutoAttrInit::AutoAi
  prepend AutoAttrInit::AutoAiAutoSetter
end
