RUBY_ENGINE == 'opal' ? (require 'ManPageMacro/extension') : (require_relative 'ManPageMacro/extension')

Asciidoctor::Extensions.register do
    inline_macro ManPageMacro
end
