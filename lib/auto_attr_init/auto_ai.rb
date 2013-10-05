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
    def new *args, &block
      names = self.instance_method(:initialize).parameters.
        collect{|param| param[1].to_s }.
        select{|name| name =~ /^＠/ }.
        collect{|name| :"#{name.sub /^＠/, ''}" }
      unless names.empty?
        object = allocate
        params = DetectParams.new(self).detect
        param_args = AssignParams.new(object).assign args, params
        names.each{|name| object.instance_variable_set :"@#{name}", param_args[name] }
      end
      super *args, &block
    end
  end
end

class Class
  include AutoAttrInit::AutoAi
  prepend AutoAttrInit::AutoAiAutoSetter
end
