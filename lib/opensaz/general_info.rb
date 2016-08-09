require 'nokogiri'

module Opensaz
  class GeneralInfo
    def initialize(html_str)
      @page = Nokogiri::HTML(html_str)
    end

    def to_a
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
