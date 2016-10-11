#!/usr/bin/env ruby -W1
# encoding: UTF-8

require 'httparty'
require 'json'
require 'htmlentities'
require 'date'

def get_post (uri, site)

  response = HTTParty.get(uri)
  case response.code
    when 200
      items = JSON.parse(response.body)['items']
  
      items.each do | post |
        owner = post['owner']
        author = '<a alt="' + owner['display_name']+ '" href="' + owner['link'] + '">' + owner['display_name'] + '</a>'
        post_link = post['share_link'] + '/' + owner['user_id'].to_s
        body = HTMLEntities.new.decode post['body_markdown']
        created = DateTime.strptime(post['creation_date'].to_s, '%s').strftime('%F %T')
    
        return <<MD
---
layout: post
title: #{ post['title'] }
tags: meta-post 
license: http://creativecommons.org/licenses/by-sa/3.0/
encoding: utf-8
author: #{ author }
date: #{ created }
comments: no
---

([Originally published](#{ post_link }) on #{ site } Stack Exchange by #{ author }.)

---

#{ body  }

---

Please direct comments to the [original post](#{ post_link }).

MD
      end
    else
      STDERR.puts response.code
  end
end

abort('Usage: ' + $0 + ' site post_id') unless ARGV.length >= 2

site = ARGV.shift
ARGV.each do | id |
  # http://api.stackexchange.com/docs/posts-by-ids#filter=!*7PYFiVwh*N4PkCdfxnM3de0s50u
  uri = URI('http://api.stackexchange.com/2.2/posts/' + id)
  uri.query = URI.encode_www_form({ :site => site, :filter => '!*7PYFiVwh*N4PkCdfxnM3de0s50u' })
  puts(get_post(uri, site))
end
