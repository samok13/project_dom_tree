#getting undefined method error for each

#This class takes the tag list and converts it into a tree
#close to the "create tree method in the day_1"
#converts tags to tree nodes and tracks depth.
#not sure this deals with text with inline tags (span example)
require_relative 'dom_parser'
require 'byebug'

Node = Struct.new(:text, :type, :classes, :id, :name, :children, :parent, :closing, :depth)

class DomTree

  TAG_OPEN_REGEX = /<[a-z].*?>/

  def initialize(dom_parser)
    @combo_list = dom_parser
    @nodes_array = [] 
    @document = Node.new(nil,"document")
    @depth = 0
    create_tree(@combo_list)
  end

#Use node attributes to build tree heirarchy
  def create_tree(combo_list)
    #call create all nodes to generate array full of all nodes
    create_all_nodes(combo_list)

    #set the current node = to the first element of the node
    #current (and/or starting depth)
    current_node = @document
    current_depth = current_node.depth

    #loop through the tag nodes array
    @nodes_array[0...-1].each_with_index do |tag_node, index|
      next_node = @nodes_array[index+1]
      next_depth = next_node.depth
    end
      #check if next tag_node is a child of the former
      #if less then yes! we have a child
    if current_depth < next_depth
      current_node.children << next_node
      next_node.parent << current_node
    end
    current_node = next_node
  end

##Sub-Methods

  #create nodes for all tags
  def create_all_nodes(combo_list)
    #find all tags
    depth = 0
    #For each element in the combo list 
    #(which has both tags and text)
    #check if its a tag...if yes, create node
    combo_list.each do |tag|
      if tag.match(TAG_OPEN_REGEX)
      @nodes_array << set_attributes(create_new_node(tag, depth))
        #create a new node for the tag w/attributes
        #pass the new node to set_tag_attributes method
        #returns a new node with all attributes
        #set tag depth
        depth += 1
      else
        #else should be grabbing the text tags
       @nodes_array << create_new_node(tag, depth)
        depth -=1 
      end 
    end
  end

  #create new node-method
  def create_new_node(tag, depth)
    node = Node.new(nil, nil, nil, nil, nil, [])
    #if match [1]

    #Possible alternate regex? /<(.*)[ >]/
    #node.type = tag.match(/<(.*?)/)  
    type = tag.match(/<(.*?)/)
    node.type = type[1] if type

    ##should my type[1[1]] be like this?

    #node.title= node.match(/title='(.*?)'/)
    title = tag.match(/title='(.*?)'/)
    node.title = tile[1] if title

    #node.classes = node.match(/class='(.*?)'/)
    classes = tag.match(/class='(.*?)'/)
    node.classes = classes[1] if classes

    #node.id = node.match(/id='(.*?)'/)
    id = tag.match(/id='(.*?)'/)
    node.id = id[1] if id

    #node.name = node.match(/name='(.*?)'/)
    name = tag.name(/name='(.*?)'/)
    node.name = name[1] if name

    node.depth = depth
    node.children = []
  end
end

ender = DomParser.new("test.html")
DomTree.new(ender)
