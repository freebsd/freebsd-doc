RUBY_ENGINE == 'opal' ? (require 'InterDocumentReferencesMacro/extension') : (require_relative 'InterDocumentReferencesMacro/extension')

Asciidoctor::Extensions.register do
    inline_macro InterDocumentReferencesMacro
end
