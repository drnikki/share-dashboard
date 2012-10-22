require "resque"
require "rubygems"
require_relative "ProjectRefresher"  # DING DING DING. in this case.

projects = ARGV
puts "Going to refresh projects:: #{projects.join(", ")}"
projects.each do |project|
  puts "Asking for a job to resfresh #{project}"
  Resque.enqueue(ProjectRefresher)
end

#http://hone.heroku.com/resque/2012/08/21/resque-signals.html

# old skool http://rubylearning.com/blog/2010/11/08/do-you-know-resque/
