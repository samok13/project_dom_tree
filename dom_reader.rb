require_relative 'dom_parser'
require_relative 'dom_tree'
require_relative 'tree_render'


class DomReader
  def parse_file
    DomParser.new
  end

  def make_tree
    DomTree.new 
  end

  #def render_tree
   # TreeRender.new
  #end

end

the_martian = DomReader.new
