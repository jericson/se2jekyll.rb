#!/usr/bin/env ruby -W1
# encoding: UTF-8

require 'httparty'
require 'json'
require 'htmlentities'
require 'date'

def get_post (uri, options)

  response = HTTParty.get(uri)
  case response.code
    when 200
      items = JSON.parse(response.body)['items']

      items.each do | post |
        owner = post['owner']
        author = owner['display_name']
        author_url = owner['link']
        post_link = post['share_link'] + '/' + owner['user_id'].to_s
        body = HTMLEntities.new.decode post['body_markdown']
        created = DateTime.strptime(post['creation_date'].to_s, '%s').strftime('%F')
        # https://stackoverflow.com/a/27091747/1438
        title_parts = post['title'].gsub('#', '&num;').split(':')
        case title_parts.size
        when 1
          title = title_parts.first
        when 2
          title = title_parts.first
          subtitle = "\nsubtitle:" + title_parts.last
        else
          title = title_parts.join('&colon;')
        end
    
        return <<MD
---
layout: post
title: #{ title }#{ subtitle if(subtitle) }
tags: #{ options[:tags] }
license: http://creativecommons.org/licenses/by-sa/3.0/
encoding: utf-8
author: #{ author }
author_url: #{ author_url }
date: #{ created }
comments: no
---

([Originally published](#{ post_link }) on #{ options[:site] } Stack Exchange by #{ author }.)

---

#{ body  }

---

Please direct comments to the [original post](#{ post_link }).

MD
      end
    else
      STDERR.puts uri, response.code
  end
end

require 'optparse'

options = {
  :site => 'stackoverflow',
  :tags => 'meta-post'
}

optparse = OptionParser.new do |opts|
  opts.banner = "Usage: #{$0} -s SITE post_id ..."

  opts.on("-s", "--site SITE", "Site name") do |s|
    options[:site] = s
  end

  opts.on("-t", "--tags TAG(S)", "Space-delimited lowercase tags") do |s|
    options[:tags] = s
  end

  opts.on( '-h', '--help', 'Display this screen' ) do
    puts opts
    exit
  end
end

optparse.parse!

if options[:site].nil? or ARGV.length == 0
  abort(optparse.help)
end

ARGV.each do | id |
  # Http://api.stackexchange.com/docs/posts-by-ids#filter=!*7PYFiVwh*N4PkCdfxnM3de0s50u
  uri = URI('http://api.stackexchange.com/2.3/posts/' + id)
  uri.query = URI.encode_www_form({ :site => options[:site],
                                    :filter => '!*7PYFiVwh*N4PkCdfxnM3de0s50u' })
  puts(get_post(uri, options))
end
