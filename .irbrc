require 'irb/completion'
require 'pp'
IRB.conf[:SAVE_HISTORY] = 30
IRB.conf[:AUTO_INDENT] = true
IRB.conf[:HISTORY_PATH] = File::expand_path("~/.irb_history")

require 'rubygems'
require 'wirble'
Wirble.init
Wirble.colorize
