class Comment
  def initialize(rawhtml)
    @user = rawhtml.css("span.comhead a")[0].text
    @timestamp = rawhtml.css("span.comhead a")[1].text
    @thecomment = "#{rawhtml.css("span.c00 > text()")}"
  end

  def com_to_s
    puts "User: \033[31m#{@user}\033[0m\n"
    puts "  #{@timestamp}"
    puts "  \033[32m#{@thecomment}\033[0m\n"
    puts
  end
end
