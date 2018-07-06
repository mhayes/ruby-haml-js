require 'tilt/template'
require 'execjs'

HAML_FILE_PATH = File.expand_path('../../../vendor/assets/javascripts/haml.js', __FILE__)

module RubyHamlJs
  class Processor
    attr_reader :escape_function
    attr_reader :haml_source

    def self.call(input)
      puts "DEBUG!!!"
      processor = new()
      processor.compile_to_function(input[:data])
    end

    def initialize(custom_escape: 'null', haml_path: HAML_FILE_PATH)
      @escape_function = js_string(custom_escape)
      @haml_source = IO.read(haml_path)
    end

    def compile_to_function(data)
      context = ExecJS.compile(haml_source)
      context.call "Haml.compile", data
      # function = ExecJS.
      #   compile(haml_source).
      #   eval "Haml('#{js_string data}', {escapeHtmlByDefault: true, customEscape: #{escape_function}}).toString()"
      # # make sure function is anonymous
      # function.sub /function \w+/, "function "
    end

    def js_string str
      (str || '').
        gsub("'")  {|m| "\\'" }.
        gsub("\n") {|m| "\\n" }
    end
  end
end

# module RubyHamlJs2
#   class Processor < Tilt::Template
#     # self.default_mime_type = 'application/javascript'

#     def self.engine_initialized?
#       defined? ::ExecJS
#     end

#     def initialize_engine
#       require_template_library 'execjs'
#     end
    
#     def prepare
#     end

#     # Compiles the template using HAML-JS
#     #
#     # Returns a JS function definition String. The result should be
#     # assigned to a JS variable.
#     #
#     #     # => "function(data) { ... }"
#     def evaluate(scope, locals, &block)
#       compile_to_function
#     end



#     private

#     def compile_to_function
#       function = ExecJS.
#         compile(self.class.haml_source).
#         eval "Haml('#{js_string data}', {escapeHtmlByDefault: true, customEscape: #{js_custom_escape}}).toString()"
#       # make sure function is annonymous
#       function.sub /function \w+/, "function "
#     end

#     def js_string str
#       (str || '').
#         gsub("'")  {|m| "\\'" }.
#         gsub("\n") {|m| "\\n" }
#     end

#     def js_custom_escape
#       escape_function = self.class.custom_escape
#       escape_function ? "'#{js_string escape_function}'" : 'null'
#     end

#     class << self
#       attr_accessor :custom_escape
#       attr_accessor :haml_path

#       def haml_source
#         # Haml source is an asset
#         @haml_path = File.expand_path('../../../vendor/assets/javascripts/haml.js', __FILE__) if @haml_path.nil?
#         @haml_source ||= IO.read @haml_path
#       end

#     end

#   end
# end

