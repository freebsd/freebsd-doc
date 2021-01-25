require 'asciidoctor/extensions' unless RUBY_ENGINE == 'opal'

include ::Asciidoctor

class PackagesMacro < Asciidoctor::Extensions::InlineMacroProcessor
  use_dsl

  named :package

  def process parent, target, attrs
    packagename = target

    target = %(https://www.freebsd.org/cgi/url.cgi?ports/#{packagename}/pkg-descr)
    parent.document.register :links, target

    %(<a class="package" href="#{target}">#{packagename}</a>)
  end
end

