#scans jenkins jobs for regex matches
#example: what jobs use 'bunlde install'? string_to_match=/bundle install/
#COOKIE can be obtained from your account settings in jenkins
require 'open-uri'
cookie = "YOUR_COOKIE_HERE"
jenkins_url="YOUR_JENKINS_URL"
string_to_match=/example/

open(jenkins_url, "Cookie" => cookie) do |x|
  x.read.scan(/tr id=\"job_(.+?)\"/) do |match|
    open(URI::encode(jenkins_url + "/job/#{match[0]}/configure"), "Cookie" => cookie) do |io|
      if io.read.match(string_to_match).nil?
        puts match[0]
      end
    end
  end
end
