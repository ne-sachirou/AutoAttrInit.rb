# coding=utf-8

module AutoAttrInit
  # Utility refinments for this AutoAttrInit.
  module Refinments
    refine Object do
      # @param name [Stirng]
      # @return [Boolean]
      def has_method? name
        methods.any?{|m| m.to_s == name.to_s }
      end
    end

    refine UnboundMethod do
      # method本体のsource codeを文字列で取得する。
      # @return [String]
      def source_code
        source = ''
        File.open source_location[0], 'r' do |f|
          lines = f.read.each_line.to_a
          source = lines[source_location[1] - 1]
          (source_location[1] .. lines.length - 1).each do |i|
            break if Ripper.sexp(source, source_location[0], source_location[1]) != nil
            source += lines[i]
          end
        end
        source
      end
    end

    refine Array do
      # Array#detect のdeep search版。
      # @return [Object|nil]
      def detect_deep ifnone = ->{ nil }, &p
        target = nil
        each do |elm|
          (target = elm; break) if p.call(elm)
          next unless elm.has_method?(:find_deep)
          v = elm.detect_deep ifnone, &p
          (target = v; break) if v != nil
          nil
        end
        target
      end

      alias find_deep detect_deep
    end
  end
end
