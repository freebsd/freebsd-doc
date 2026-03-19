require 'asciidoctor/extensions' unless RUBY_ENGINE == 'opal'

include ::Asciidoctor

class InterDocumentReferencesMacro < Asciidoctor::Extensions::InlineMacroProcessor
  use_dsl

  # Macro to handle cross references to different files in the same book.
  named :crossref

  def process parent, target, attrs
    anchor = attrs[1]
    text = attrs[2]

    if text.nil? || text.empty?
      warn "Crossref '#{anchor}' needs a description."
    end

    doc = parent.document

    if doc.backend == 'html5'
      if doc.attributes['book'] == "true"
        if doc.attributes['isonline'] == "1"
          (create_anchor parent, text, type: :link, target: %(./##{anchor})).render
        else
          (create_anchor parent, text, type: :link, target: %(./index.html##{anchor})).render
        end
      else
        if doc.attributes['isonline'] == "1"
          (create_anchor parent, text, type: :link, target: %(../#{target}/##{anchor})).render
        else
          (create_anchor parent, text, type: :link, target: %(../#{target}/index.html##{anchor})).render
        end
      end
    else
      xref_attrs = { 'refid' => anchor }
      xref_node = create_anchor parent, text, type: :xref, target: target, attributes: xref_attrs
      # Return the node
      xref_node
    end
  end # process

end # class

