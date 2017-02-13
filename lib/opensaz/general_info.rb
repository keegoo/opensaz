require 'nokogiri'

module Opensaz
  class GeneralInfo
    def initialize(content)
      @page = Nokogiri::HTML(content)
    end

    def to_a
      keys = [:id, :c, :s, :m, :comment]
      ary = []
      @page.css('tbody tr').each do |x|
        values = get_tbody_tr(x)
        tmp = (0...keys.size).map{ |i| [keys[i], values[i]] }.to_h 
        ary.push(tmp)
      end
      ary
    end

    private

    # ============================
    # note, the output order should 
    # be inline with 
    # [:id, :c, :s, :m, :comment]
    def get_tbody_tr(tr_node)
      tds = tr_node.css('td')

      i = comment_column
      if i == 0
        # no comment found
        [tds[1].text] + seperate_c_s_m(tds[0]) + [nil]
      else
        comment = text_or_nil(tds[i-1].text)
        [tds[1].text] + seperate_c_s_m(tds[0]) + [comment]
      end
    end

    def seperate_c_s_m(a_node)
      a_node.css('a').map{|a| folder_platform_compatible(a["href"]) }
    end

    # ============================
    # get comment column
    # return a number, indicating which
    #   "th" is the comment.
    # return 0 if could not find it
    def comment_column
      res = 0
      @page.css('thead tr th').each do |x|
        res += 1
        if x.text == "Comments"
          break
        end
      end
      return res
    end

    # ============================
    # return nil if empty. 
    # return itself if not empty.
    def text_or_nil(comment)
      comment.length == 0 ? nil : comment
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
      res[1..-1]
    end
  end
end
