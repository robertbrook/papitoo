require 'nokogiri'
require 'time'

doc = Nokogiri::XML(File.open("./data/hansard/march2014/LHAN121.xml"))

doc.remove_namespaces!

timecodes = doc.xpath('//hs_TimeCode')

timecodes.each_with_index do |hs_timecode, index|
  hs_timecode_time = hs_timecode['time']
  this_intime = Time.parse(hs_timecode_time).to_i
  prev_intime = Time.parse(timecodes[index-1]['time']).to_i
  
  if this_intime > prev_intime
    puts "sequence looks ok"
  else
    puts "SEQUENCE ERROR #{hs_timecode.line.to_s}"
  end
  
#   puts hs_timecode.path
#   puts hs_timecode.previous_element

  if this_intime == 946684800
    puts "Happy New Year: #{hs_timecode_time}
      LINE #{hs_timecode.line.to_s}
      URL http://www.publications.parliament.uk#{hs_timecode.parent['url']}
      "
    
  end
  
end


