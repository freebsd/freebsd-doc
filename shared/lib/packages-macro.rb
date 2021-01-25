RUBY_ENGINE == 'opal' ? (require 'PackagesMacro/extension') : (require_relative 'PackagesMacro/extension')

Asciidoctor::Extensions.register do
    inline_macro PackagesMacro
end

