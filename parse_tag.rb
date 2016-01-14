#take in a string from an html file
#parse into hash or struct (regex)
#likely multiple regex's 

def parse_tag(string)
  #type
  regex = /<([a-zA-Z]+)/
  type = string.match(regex)
  puts type[1] if type

  #class
  regex =/class='(.*?)'/
  classes = string.match(regex)
  puts classes[1] if classes

  #id
  regex = /id='(.*?)'/
  id = string.match(regex)
  puts id[1] if id

  #name
  regex = /name='(.*?)'/
  name = string.match(regex)
  puts name[1] if name

  #title
  regex = /title='(.*?)'/
  title = string.match(regex)
  puts title[1] if title

  #src
  regex = /src='(.*?)'/
  src = string.match(regex)
  puts src[1] if src

end

parse_tag("<p class='foo bar' id='baz'>")

parse_tag("<p class='foo bar' id='baz' name='fozzie'>")

parse_tag("<div id='bim'>")

parse_tag("<img src='http://www.example.com' title='funny things'>")


#parsed_string = Struct.new(:type,:class,:id,:name)

