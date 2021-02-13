require 'asciidoctor/extensions' unless RUBY_ENGINE == 'opal'

include ::Asciidoctor

class GitReferencesMacro < Asciidoctor::Extensions::InlineMacroProcessor
  use_dsl

  named :gitref

  def process parent, target, attrs
    hash = target
    repository = if (repository = attrs['repository'])
      "#{repository}"
    else
      "src"
    end
    length = if (length = attrs['length'])
      length.to_i
    else
      12
    end
    url = %(https://cgit.freebsd.org/#{repository}/commit/?id=#{hash})
    %(<a href="#{url}">#{hash[0, length]}</a>)
  end
end
