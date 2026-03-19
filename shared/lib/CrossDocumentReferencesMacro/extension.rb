require 'asciidoctor/extensions' unless RUBY_ENGINE == 'opal'

include ::Asciidoctor

class CrossDocumentReferencesMacro < Asciidoctor::Extensions::InlineMacroProcessor
  use_dsl

  # Macro to handle cross references to a different book.
  named :extref
  name_positional_attributes 'attributes'

  def process parent, target, attrs
    destination = target
    text = attrs[1]
    anchor = ""

    unless attrs[2].nil?
      anchor = "#" + attrs[2]
    end

    doc = parent.document

    if doc.attributes['isonline'] == "1"
      (create_anchor parent, text, type: :link, target: %(#{destination}#{anchor})).render
    else
      if doc.attributes['doctype'] == "book"
        (create_anchor parent, text, type: :link, target: %(../#{destination}/index.html#{anchor})).render
      else
        (create_anchor parent, text, type: :link, target: %(#{destination}/index.html#{anchor})).render
      end
    end

  end
end
