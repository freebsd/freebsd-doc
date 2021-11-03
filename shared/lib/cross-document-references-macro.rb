RUBY_ENGINE == 'opal' ? (require 'CrossDocumentReferencesMacro/extension') : (require_relative 'CrossDocumentReferencesMacro/extension')

Asciidoctor::Extensions.register do
    inline_macro CrossDocumentReferencesMacro
end
