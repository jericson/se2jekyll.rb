#!/usr/bin/env ruby

require 'net/http'
require 'json'
require 'htmlentities'
require 'Date'

abort('Usage: ' + $0 + ' site post_id [...]') unless ARGV.length >= 2

site = ARGV.shift
ARGV.each do | id |
  # http://api.stackexchange.com/docs/posts-by-ids#filter=!*7PYFiVwh*N4PkCdfxnM3de0s50u
  uri = URI('http://api.stackexchange.com/2.2/posts/' + id)
  uri.query = URI.encode_www_form({ :site => site, :filter => '!*7PYFiVwh*N4PkCdfxnM3de0s50u' })

  items = JSON.parse(Net::HTTP.get_response(uri).body)['items']

  items.each do | post |
    owner = post['owner']
    author = '<a alt="' + owner['display_name']+ '" href="' + owner['link'] + '">' + owner['display_name'] + '</a>'

    body = HTMLEntities.new.decode post['body_markdown']

    created = DateTime.strptime(post['creation_date'].to_s, '%s')
  
    puts <<MD
---
layout: post
title: #{ post['title'] }
tags: meta-post 
license: http://creativecommons.org/licenses/by-sa/3.0/
author: #{ author }
date: #{ created.strftime('%F %T') }
comments: no
---

([Originally published](#{ post['share_link'] }/#{ owner['user_id'] }) on #{ site } Stack Exchange by #{ author }.)

#{ body  }

MD
  end
end
