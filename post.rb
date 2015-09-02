require "nokogiri"
require "uri"
require_relative "arbitrary_exception"

class Post
  def initialize(url)
    @thepage = Nokogiri::HTML(open(url))
    @url = @thepage.css("body table#hnmain tr.athing td.title a")[0]["href"]
    @title = @thepage.css("body table#hnmain tr.athing td.title a").text

    @rawcomments = @thepage.css("table#hnmain > tr:nth-of-type(3) > td > table")[1].css("tr.athing")
   
    @comments = {}
    @rawcomments.each_with_index do |c,i|
      @comments[i] = Comment.new(c)
    end
    @points = @thepage.css("body table#hnmain > tr")[2].css("td.subtext span").text
    @author = @thepage.css("body table#hnmain > tr")[2].css("td.subtext a")[0].text
    @item_id =  @thepage.css("form input")[0]["value"]
  rescue NoMethodError
    puts "That is not a valid web page"
    raise ArbitraryException
  end

  def print_all_comments
    @comments.each do |k,v|
      v.com_to_s
    end
  end

  def print_a_comment(id)
    @comments[id.to_i].com_to_s
  end

  def add_comment(thecomment)
    lastindex = @comments.keys.sort.last.to_i+1
    @comments[lastindex]=thecomment
  end

  def print_info
    puts "Title: \033[32m#{@title}\033[0m"
    puts "  Article: \033[34m#{@url}\033[0m"
    puts "  Author: \033[31m#{@author}\033[0m"
    puts "  Points: \033[33m#{@points}\033[0m"
    puts "  #{@comments.length} Comments"
  end
end
