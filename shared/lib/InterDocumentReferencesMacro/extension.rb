require 'asciidoctor/extensions' unless RUBY_ENGINE == 'opal'

include ::Asciidoctor

class InterDocumentReferencesMacro < Asciidoctor::Extensions::InlineMacroProcessor
  use_dsl

  named :crossref
  name_positional_attributes 'attributes'

  def process parent, target, attrs
    destination = target
    anchor = attrs[1]
    text = attrs[2]

    doc = parent.document
    if doc.attributes['book'] == 'True'
        (create_anchor parent, text, type: :link, target: %(./##{anchor})).render
    else
        (create_anchor parent, text, type: :link, target: %(../#{destination}/##{anchor})).render
    end

  end
end

