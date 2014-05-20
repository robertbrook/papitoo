require 'nokogiri'

class HansardDoc < Nokogiri::XML::SAX::Document
def start_element name, attrs = []
#   puts "starting: #{name}"
  @is_hs_para = name.eql?("hs_para")
end

def characters string
    string.strip!
    if @is_hs_para and !string.empty?
      puts "#{string}"
    end
end

def end_element name
#   puts "ending: #{name}"
end
end

parser = Nokogiri::XML::SAX::Parser.new(HansardDoc.new)

parser.parse(File.open("./data/hansard/march2014/LHAN121.xml"))