require 'open-uri'
require 'json'

$user = 'gsi-cyberjapan'
$repo = 'gsimaps'

json = JSON.parse(open(
  "https://api.github.com/repos/#{$user}/#{$repo}").read)
forks_count = json['forks_count']
print "#{$repo} has #{forks_count} forks.\n"

(forks_count / 30.0).ceil.times {|page|
  json = JSON.parse(open(
    "https://api.github.com/repos/#{$user}/#{$repo}/forks" +
    "?page=#{page + 1}").read)
  json.each {|r|
    print "#{r['owner']['login']}: #{r['html_url']}\n"
  }
}
