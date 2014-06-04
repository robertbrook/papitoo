require 'nokogiri'
require 'time'
require 'logger'

lordstest = "./data/hansard/march2014/LHAN121.xml"
hansard_xml = FileList['./data/hansard/*/*.xml']

task :default => 'log:timecodes'

def gen(this)

  log = Logger.new(STDOUT)
  log.level = Logger::INFO

  doc = Nokogiri::XML(File.open(this))

  doc.remove_namespaces!

  timecodes = doc.xpath('//hs_TimeCode')

  timecodes.each_with_index do |hs_timecode, index|
    hs_timecode_time = hs_timecode['time']
    this_intime = Time.parse(hs_timecode_time).to_i
    prev_intime = Time.parse(timecodes[index-1]['time']).to_i

    case
      when (this_intime == 946684800)
        log.info [this, "DEFAULT VALUE", hs_timecode.line, "2000-01-01"]

      when !(this_intime > prev_intime)
        log.info [this, "SEQUENCE", hs_timecode.line, "#{hs_timecode_time} follows #{timecodes[index-1]['time']}"]

      else
        log.debug "line looks fine"

    end

    # hs_timecode.parent['url']

  end


end


namespace :log do

  desc "Timecodes"
  task :timecodes do
    hansard_xml.each do |this|

    gen(this)
    end
  end


end
