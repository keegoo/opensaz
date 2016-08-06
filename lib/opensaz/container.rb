require 'nokogiri'

module Opensaz
  class Container
    def initialize(destination)
      @index_file = File.join(destination, "_index.htm")
      @page = nil
      @packages = nil
    end

    def to_hash
      @page ||= Nokogiri::HTML(load_page)
      keys = get_thead
      ary = []
      @page.css('tbody tr').each do |x|
        values = get_tbody_tr(x)
        tmp = (0...keys.size).map{ |i| [keys[i], values[i]] }.to_h 
        ary.push(tmp)
      end
      ary
    end

    private

    def load_page
      raise "file #{@index_file} doesn't exist" unless File.exist?(@index_file)
      @page = Nokogiri::HTML(open(@index_file))
    end

    def get_thead
      [:c, :s, :m] + 
      @page.css('thead tr th')[1..-1]
        .map {|x| x.text == "#" ? :id : x.text.downcase.to_sym}
    end

    def get_tbody_tr(tr_node)
      tds = tr_node.css('td')
      seperate_c_s_m(tds[0]) + tds[1..-1].map{|x| x.text }
    end

    def seperate_c_s_m(a_node)
      a_node.css('a').map{|a| a["href"] }
    end
  end
end
