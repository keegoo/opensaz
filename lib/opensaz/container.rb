require 'nokogiri'

module Opensaz
  class Container
    def initialize(destination)
      @index_file = File.join(destination, "_index.htm")
      @packages = nil
    end

    def to_hash
      raise "file doesn't exist #{@index_file}" unless File.exist?(@index_file)
      @page = Nokogiri::HTML(open(@index_file))
      keys = get_keys
      ary = []
      @page.css('tbody tr').each do |tr|
        i = 0
        a_hash = {}
        tr.css('td').each {|td| a_hash[keys[i]] = td.text; i += 1 }
        puts a_hash
      end
    end

    private

    def get_keys
      @page.css('thead tr th').map{|x| x.text == "#" ? :id : x.text.downcase.to_sym }
    end

    def seperate_c_s_m
    end
  end
end
