
Tag = Struct.new(:text, :type, :classes, :id, :name, :children, :parent, :closing, :depth)


class ParseTree
attr_reader :root, :tag_list, :tag_structs, :html_string

#Regex Tools--Sam
regex_type = /<([a-zA-Z]+)/
regex_class =/class='(.*?)'/
regex_id = /id='(.*?)'/
regex_name = /name='(.*?)'/
regex_title = /title='(.*?)'/

#Do I need the others julia has?
#Sam's from below
#Finding all tags
  regex = /<.*?>/
    @tag_list = @html_string.scan(regex)

#Finding all text
  regex = />(.*?)</
    @text_list = html_string.scan(regex) 

  def initalize
    @html_string=[]
    #Bring in the html file and return array
    @html_input_array = File.readlines("test.html")
    #Iterate through, skip the first element(html declaration)
    html_input_array[1..-1].each do |input|
      @html_string<<input.strip
    #Return array of strings w/o spaces
    end
    #Join all the spaces together ['']
    @html_string = @html_string.join
    @depth = 0
    @tag_list = nil
    @tag_structs = []
  end

  def find_all_tags
    depth = 0
    @tag_list = @html_string.scan(ALL_TAG_REGEX).map {|array| array[0]}
    # for each opening tag: generate Tag, set attributes, increase depth by 1
    @tag_list.each do |tag|
      if tag.match(OPEN_TAG_REGEX)
        #array of all tags
        @tag_structs << set_tag_attributes(tag, depth)
        depth += 1
      # for each closing tag, decrease depth by 1
      else
        depth -= 1
      end
    end
  end


  def generate_tree
    #iterate through @tag_list
      #as long you are encountering opening tags
        #set current_node's parent to previous node
        #set newly encountered node as children to current_node
    current_node = @tag_structs[0]
    current_depth = current_node.depth
    @tag_structs[0..-2].each_with_index do |tag, index|
      next_node = @tag_structs[index+1]
      next_depth = next_node.depth
      if current_depth < next_depth
        current_node.children << next_node
        current_node = next_node
      end
    end
  end

#how they create a new tag
#:text, :type, :classes, :id, :name, :children, :parent, :closing, :depth
  def set_tag_attributes(tag_info, depth)
    new_tag = Tag.new(nil, nil, nil, nil, nil, [])

    new_tag = Tag.new(
      tag_info.match(TEXT_REGEX).to_s, 
      tag_info.match(TAG_TYPE_REGEX).to_s[1..-1], 
      tag_info.match(CLASS_REGEX).to_s[7..-2].split(' ') if tag_info.match(CLASS_REGEX), 
      tag_info.match(ID_REGEX).to_s[4..-2], 
      tag_info.match(NAME_REGEX).to_s[6..-2], 
      new_tag.depth = depth
      )

    return new_tag
  end

end

game = DomParser.new
game.find_all_tags
puts game.generate_tree
# puts game.tag_list.inspect
game.tag_structs.each do |tag|
  print "  " * tag.depth
  puts tag.type
end
puts game.html_string

end

