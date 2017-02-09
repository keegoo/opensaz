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
      a_node.css('a').map{|a| folder_platform_compatible(a["href"]) }
    end

    # ============================
    # "raw\\1_c.txt" is too windows specific
    # from 
    #   windows specific
    # too
    #   platform compatible
    def folder_platform_compatible(win_path)
      res = ""
      win_path.split("\\").each do |f|
        res = File.join(res, f)
      end
      res
    end
  end
end
