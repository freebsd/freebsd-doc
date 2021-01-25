require 'asciidoctor/extensions' unless RUBY_ENGINE == 'opal'

include Asciidoctor

Extensions.register do
  treeprocessor do
    process do |document|
      if (document.attr? 'sectnumoffset') && (book = (document.attr 'book', false)) == false
        sectnumoffset = (document.attr 'sectnumoffset', '0').to_s
        document.find_by(context: :section) {|sect| sect.level == 1 }.each do |sect|
          sect.numeral = sectnumoffset.to_s + '.' + sect.numeral.to_s
        end
      end
    end
  end
end 
