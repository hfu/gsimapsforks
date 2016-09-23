require 'open-uri'
require 'json'

def jump_into(user, repo)
  json = JSON.parse(open(
    "https://api.github.com/repos/#{user}/#{repo}").read)
  forks_count = json['forks_count']
  print "#{user}/#{repo} has #{forks_count} forks.\n"

  (forks_count / 30.0).ceil.times {|page|
    json = JSON.parse(open(
      "https://api.github.com/repos/#{user}/#{repo}/forks" +
      "?page=#{page + 1}").read)
    json.each {|r|
      #jump_into(r['owner']['login'], repo)
      print "#{r['owner']['login']}\n"
    }
  }
end

jump_into('gsi-cyberjapan', 'gsimaps')
