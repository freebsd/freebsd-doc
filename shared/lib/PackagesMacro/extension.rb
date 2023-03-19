require 'asciidoctor/extensions' unless RUBY_ENGINE == 'opal'

include ::Asciidoctor

class PackagesMacro < Asciidoctor::Extensions::InlineMacroProcessor
  use_dsl

  named :package
  name_positional_attributes 'pkgname'

  def process parent, target, attrs
    pkgorigin = target

    if pkgorigin.include?("@")
      pkgorigin = pkgorigin[0..pkgorigin.index("@")-1]
    end

    pkgname = if (pkgname = attrs['pkgname'])
      "#{pkgname}"
    else
      "#{target}"
    end

    url = %(https://cgit.freebsd.org/ports/tree/#{pkgorigin}/)

    %(<a class="package" href="#{url}">#{pkgname}</a>)
  end
end
