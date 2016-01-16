#WORKS

#This class takes in the html file
#chops off the declaration
#uses regex for the all the given tags to identify tags
#Parses the html string into appropriate tags

#Tag = Struct.new(:type:classes,:id,:name,:text,:children,:parent,:closing,:depth)
require 'byebug'
class DomParser

#Potential types to parse
#declaraton <html>
#types-html,head,title,div,main,header,body,h1,h2,ul,li, span
#title
#class
#text
#id
#Think about how to handle text occuring
#in multiple places in a tag

#I don't actually need the individual tag regex's in this class..
#Moved to dom_tree..only need all tags in this method
TAG_ALL_TAGS_REGEX = /<.*?>|(?<=>).*?(?=<)/
#This inlcudes tags and text
#TEXT_REGEX = /(?<=>)(.*?)(?=)/


  def initialize(filename)
    @tag_list = nil
    @text_list = nil
    @html_string = []
    #Bring in the html file and return array
    @html_input_array = File.readlines(filename)
    #Iterate through, skip the first element(html declaration)
    @html_input_array[1..-1].each do |input|
      @html_string << input.strip
    end
    #Return array of strings w/o spaces
    @html_string = @html_string.join
    gen_combo_list
  end

  def gen_combo_list
    @combo_list = @html_string.scan(TAG_ALL_TAGS_REGEX)
    #convert tag list format from string to array
    #ask about b/c I thought html.scan should already be an array
    @combo_list = @combo_list.flatten
    print @combo_list
    ##also has my text
  end

 

end

ender = DomParser.new("test.html")



