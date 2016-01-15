require_relative 'parse_tag'

Tag = Struct.new(:type, :classes, :id, :name, :src, :title, :text, :children, :parent)
# :attributes that holds all html elements
# Tag class
# methods on tag class to retrieve that attribute

class ParseTree
	attr_accessor :html_code, :root, :tag_type

  def initialize(html_code)
  	regex = /<.*?>/
    @tag_type = html_code.scan(regex)
    # @parse = ParseTag.new(html_code)
    @root = nil
  end

  def add_root_node(first_tag)
    @root = Tag.new(first_tag)
  end

  def make_tree
    unless @root
      add_root_node(@tag_type[0]) #first open tag
    end

    while @html_code.length > 0
      add_node(???????????)
    end
  end

  # def add_node()
		# if current node is nil
		# 	new structures
		# else
		# 	add_node (data)

  # end
end

html_string = "<div>  div text before  <p>    p text  </p>  <div>    more div text  </div>  div text after</div>"

tree = ParseTree.new(html_string)
tree.make_tree

# regex = /<.*?>/
# p html_string.scan(/<.*?>/)
# p html_string.split(/<.*?>/)

