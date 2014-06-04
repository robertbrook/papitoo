require 'nokogiri'
require 'time'
require 'logger'
require 'sqlite3'
require "./app"
require "sinatra/activerecord/rake"

lordstest = "./data/hansard/march2014/LHAN121.xml"
hansard_xml = FileList['./data/hansard/*/*.xml']

task :default => 'log:timecodes'

def setup

  File.delete('report.db')

  @db = SQLite3::Database.new "report.db"

  @db.execute "create table reports (file text,timestamp text,line text);"

end

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

    @db.execute("INSERT INTO reports (file, timestamp, line) VALUES (?, ?, ?)", [this, this_intime, hs_timecode.line])


    #   when (this_intime == 946684800)

    #   when !(this_intime > prev_intime)
    #     # log.info [this, "SEQUENCE", hs_timecode.line, "#{hs_timecode_time} follows #{timecodes[index-1]['time']}"]

    # hs_timecode.parent['url']

  end


end


namespace :log do

  desc "Timecodes"
  task :timecodes do
    setup()
    hansard_xml.each do |this|

    gen(this)
    end
  end


end
