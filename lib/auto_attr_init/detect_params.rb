# coding=utf-8

using AutoAttrInit::Refinments

module AutoAttrInit
  # classを静的解析して、initializeのparamsを抽出する。
  class DetectParams
    # @param klass [Class]
    def initialize klass
      @klass = klass
    end

    # @return [Array] [param type, param name, default value|nil][]
    def detect
      initialize_method = @klass.instance_method :initialize
      if initialize_method
        params = initialize_method.parameters
        params = analyze_opt_params initialize_method, params
        params = params.select{|param| param[0] != :block }
      else
        params = []
      end
      params
    end

    private
    # opt paramとkey paramのdefault値を解析し、其れを含めたparamsを返却。
    def analyze_opt_params method, params
      params_sexp = detect_params_sexp method
      params_sexp.zip params do |sexp, param|
        next unless [:opt, :key].include?(param[0])
        param << sorcerer(sexp)
      end
      params
    end

    # methodの、params部のS式 (SExp) を取得する。
    def detect_params_sexp method
      params_sexp =
        Ripper.sexp(method.source_code).
        find_deep{|sexp| sexp.has_method?(:[]) && sexp[0] == :params }.
        select{|sexp| sexp != nil }
      params_sexp = params_sexp[1..-1].inject [] do |accm, sexp|
        if sexp[0].is_a? Symbol
          accm << sexp
        else
          accm += sexp
        end
        accm
      end
    end

    # S式からsource code文字列を復元する。
    def sorcerer sexp
      target = sexp[1]
      if target[0] == :string_literal
        %Q{"#{Sorcerer.source target[1][1]}"}
      else
        Sorcerer.source target
      end
    end
  end
end
