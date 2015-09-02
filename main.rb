require_relative "comment"
require_relative "post"
require_relative "arbitrary_exception"
require "open-uri"
require "uri"

begin
  raise ArbitraryException unless ARGV[0] =~ /\A#{URI::regexp}\z/
  thepost = Post.new(ARGV[0])
  if ARGV.length>1
    if ARGV[1].downcase == "help"
      puts "Options: Help, \"Print info\", \"Print all\", \"Print one\" <id>"
    elsif ARGV[1].downcase == "print all"
      thepost.print_all_comments
    elsif ARGV[1].downcase == "print info"
      thepost.print_info
    elsif ARGV[1].downcase == "print one"
      thepost.print_a_comment(ARGV[2].to_i)
    else
      puts "Please enter a valid command"
    end
  end
rescue ArbitraryException
  puts "Please use a valid URL"
end
