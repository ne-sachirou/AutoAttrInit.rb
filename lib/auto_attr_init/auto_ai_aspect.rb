# coding=utf-8

module AutoAttrInit
  # initialize methodのaspect。
  # See AutoAttrInit::AutoAi
  class AutoAiAspect < AspectR::Aspect
    # @params klass [Class]
    # @params names [Symbol[]]
    def initialize klass, names = []
      @params = DetectParams.new(klass).detect
      @names = names
      @names = @params.collect{|param| param[1] } if @names.empty?
    end

    def pre_initialize method, object, exitstatus, *args
      param_args = AssignParams.new(object).assign args, @params
      @names.each{|name|
        object.instance_variable_set :"@#{name.to_s.sub /^＠/, ''}", param_args[name]
      }
    end
  end
end
