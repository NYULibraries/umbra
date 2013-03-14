require 'git'
require 'fileutils'

desc "Push latest rcod and rdocs to gh-pages"
task :ghpages do
    g = Git.open(Dir.pwd)
    FileUtils.mv("coverage/", "coverage.bak/", :force => true)
    FileUtils.mv("doc/", "doc.bak/", :force => true)
    g.checkout(g.branch('gh-pages'))
    g.pull("origin", "gh-pages")
    FileUtils.rm_r("coverage", :force => true)
    FileUtils.mv("coverage.bak/", "coverage/", :force => true)
    FileUtils.rm_r("doc", :force => true)
    FileUtils.mv("doc.bak/", "doc/", :force => true)
    g.add(".")
    g.commit_all("Update coverage and rdocs.")
    g.push("origin", "+gh-pages")
    FileUtils.cp_r("coverage/", "coverage.bak/")
    FileUtils.cp_r("doc/", "doc.bak/")
    if Rails.env == "production"
      g.checkout(g.branch('master'))
    else
      g.checkout(g.branch('development'))
    end
    FileUtils.mv("coverage.bak/", "coverage/", :force => true)
    FileUtils.mv("doc.bak/", "doc/", :force => true)
end
