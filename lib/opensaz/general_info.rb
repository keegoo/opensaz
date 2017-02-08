require 'nokogiri'

module Opensaz
  class GeneralInfo
    def initialize(index_file)
      raise "no such file: #{index_file}" unless File.exist?(index_file)
      @page = Nokogiri::HTML(File.read(index_file))
    end

    def to_a
      keys = [:id, :c, :s, :m]
      ary = []
      @page.css('tbody tr').each do |x|
        values = get_tbody_tr(x)
        tmp = (0...keys.size).map{ |i| [keys[i], values[i]] }.to_h 
        ary.push(tmp)
      end
      ary
    end

    private

    def get_tbody_tr(tr_node)
      tds = tr_node.css('td')
      [tds[1].text] + seperate_c_s_m(tds[0])
    end

    def seperate_c_s_m(a_node)
      a_node.css('a').map{|a| a["href"] }
    end
  end
end
