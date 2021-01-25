require 'asciidoctor/extensions' unless RUBY_ENGINE == 'opal'

include ::Asciidoctor

class ManPageMacro < Asciidoctor::Extensions::InlineMacroProcessor
  use_dsl

  named :man
  name_positional_attributes 'section'

  def process parent, target, attrs
    manname = target
    section = if (section = attrs['section'])
      "#{section}"
    else
      ""
    end
    url = %(https://www.freebsd.org/cgi/man.cgi?query=#{manname}&sektion=#{section}&format=html)
    %(<a href="#{url}">#{manname}(#{section})</a>)
  end
end
