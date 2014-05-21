require 'nokogiri'
require 'time'

# http://nokogiri.org/Nokogiri/XML/SAX/Document.html
# grep -Hnrc --colour "hs_TimeCode time=\"2000" *

class HansardDoc < Nokogiri::XML::SAX::Document

def start_element name, attrs = []
  if name.eql?("hs_TimeCode")
    target = attrs[0][1]
    puts Time.parse target
    if Time.parse(target).to_i == 946684800
      puts "^^^^^^^^dodgy!"
    end
  end
end

def characters string

    # string.strip!
#     if @is_hs_TimeCode and !string.empty?
#       puts string
#     end
end

def end_element name
    
end

def processing_instruction(name, content)
#   puts name
#   puts content
end

end

parser = Nokogiri::XML::SAX::Parser.new(HansardDoc.new)

parser.parse(File.open("./data/hansard/march2014/LHAN121.xml"))