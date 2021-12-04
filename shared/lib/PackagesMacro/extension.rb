require 'asciidoctor/extensions' unless RUBY_ENGINE == 'opal'

include ::Asciidoctor

class PackagesMacro < Asciidoctor::Extensions::InlineMacroProcessor
  use_dsl

  named :package

  def process parent, target, attrs
    packagename = target

    target = %(https://cgit.freebsd.org/ports/tree/#{target}/pkg-descr)
    parent.document.register :links, target

    %(<a class="package" href="#{target}">#{packagename}</a>)
  end
end

