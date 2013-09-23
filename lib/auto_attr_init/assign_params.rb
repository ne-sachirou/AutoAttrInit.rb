# coding=utf-8

using AutoAttrInit::Refinments

module AutoAttrInit
  class AssignParams
    # @param object [Object]
    def initialize object
      @object = object
    end

    # @param args [Array]
    # @param params [Array] [param type, param name, default value | nil][]
    # @return [Hash] { param name => value }
    def assign args, params
      param_args = {}
      key_params, params =
        *params.partition{|param| [:key, :keyrest].include? param[0] }
      unless key_params.empty?
        key_args = args.last.is_a?(Hash) ? args.pop : {}
        param_args = param_args.merge assign_key_params(key_args, key_params)
      end
      if params.any?{|param| param[0] == :rest }
        param_args = param_args.merge assign_rest_params(args, params)
      else
        param_args = param_args.merge assign_req_params(args, params)
      end
      param_args
    end

    private
    # @param args [Array] value[]
    # @param param [Array] [:req|:opt, param name, default value|nil][]
    # @return [Hash] { param name => value }
    def assign_rest_params args, params
      param_args = {}
      rest_index = params.find_index{|param| param[0] == :rest }
      param_args =
        param_args.merge assign_req_params(
                           args[0 .. (rest_index - 1)],
                           params[0 .. (rest_index - 1)])
      param_args =
        param_args.merge assign_req_params(
                           args[(params.length - args.length) .. -1],
                           params[(rest_index + 1) .. -1])
      param_args[params[rest_index][1]] =
        args[rest_index .. (args.length - params.length + 1)]
      param_args
    end

    # req paramとopt paramのみ存在すると仮定して、paramsをassignする。
    # @param args [Array] value[]
    # @param param [Array] [:req|:opt, param name, default value|nil][]
    # @return [Hash] { param name => value }
    def assign_req_params args, params
      param_args = {}
      params.each_with_index do |param, i|
        type, name, value = *param
        param_args[name] =
          case type
          when :req
            args[i]
          when :opt
            args[i] || @object.instance_eval(value)
          end
      end
      param_args
    end

    # @param key_args [Hash] { param name => value }
    # @param params [Array] [:key|:keyrest, param name, default value|nil][]
    # @return [Hash] { param name => value }
    def assign_key_params key_args, params
      param_args = {}
      params.select{|param| param[0] == :key }.
        each do |param|
          type, name, value = *param
          param_args[name] =
            key_args.has_key?(name) ?
            key_args[name] :
            @object.instance_eval(value)
        end
      if keyrest_param = params.find{|param| param[0] == :keyrest }
        keyrest_arg = {}
        key_args.each do |name, value|
          keyrest_arg[name] = value unless param_args.has_key?(name)
        end
        param_args[keyrest_param[1]] = keyrest_arg
      end
      param_args
    end
  end
end
