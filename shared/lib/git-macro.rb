RUBY_ENGINE == 'opal' ? (require 'GitReferencesMacro/extension') : (require_relative 'GitReferencesMacro/extension')

Asciidoctor::Extensions.register do
    inline_macro GitReferencesMacro
end 
