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
    url = %(https://man.freebsd.org/cgi/man.cgi?query=#{manname}&sektion=#{section}&format=html)
    link_text = section.empty? ? manname : "#{manname}(#{section})"
    create_anchor parent, link_text, type: :link, target: url
  end
end
