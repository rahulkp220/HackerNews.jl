[![Build Status](https://travis-ci.org/rahulkp220/HackerNews.jl.svg?branch=master)](https://travis-ci.org/rahulkp220/HackerNews.jl)
[![Coverage Status](https://coveralls.io/repos/rahulkp220/HackerNews.jl/badge.svg?branch=master&service=github)](https://coveralls.io/github/rahulkp220/HackerNews.jl?branch=master)
[![codecov.io](http://codecov.io/github/rahulkp220/HackerNews.jl/coverage.svg?branch=master)](http://codecov.io/github/rahulkp220/HackerNews.jl?branch=master)

# HackerNews
The unofficial Julia API for Hackernews.

## Installation
```julia
julia> Pkg.clone("https://github.com/rahulkp220/HackerNews.jl")
```

## Update
```julia
julia> Pkg.update("HackerNews")
```

# How it works?
```julia

# import the package
julia> using HackerNews

# create the object
julia> hn = HackerNews.HNInit("topstories",5)
HackerNews.HNInit("topstories", 5)

# get post ids
julia> HackerNews.getids(hn)
5-element Array{Int64,1}:
 16558680
 16558540
 16557500
 16558578
 16558684

# get top stories
julia> topstories = HackerNews.getposts(hn)

# fields inside the object
julia> fieldnames(topstories[1])
16-element Array{Symbol,1}:
 :data       
 :id         
 :deleted    
 :itemtype   
 :by         
 :time       
 :text       
 :dead       
 :parent     
 :poll       
 :kids       
 :url        
 :score      
 :title      
 :parts      
 :descendants

# explore the raw response from the Hackernews API
julia> topstories[1].data
Dict{String,Any} with 9 entries:
  "by"          => "xbryanx"
  "descendants" => 17
  "score"       => 122
  "time"        => 1520693674
  "id"          => 16558680
  "title"       => "Round Peg in a Square Hole [video]"
  "type"        => "story"
  "kids"        => Any[16558849, 16558987, 16558793, 16558956]
  "url"         => "https://www.youtube.com/watch?time_continue=2&v=AvFNCNOyZeE"

# having fun with the API
julia> for story in topstories
                  println("Title:\t $(story.title) by '$(story.by)'")
              end
Title:	 Round Peg in a Square Hole [video] by 'xbryanx'
Title:	 The antidepressant effect of sleep deprivation by 'onuralp'
Title:	 Mother-daughter team joins YC to accelerate their drug discovery platform by 'Geekette'
Title:	 Is vitamin D really a cure-all, and how should we get our fix? by 'pmoriarty'
Title:	 Austerity and the rise of the Nazi party [pdf] by 'ericdanielski'
```

## Facing issues? :scream:
* Open a PR with the detailed expaination of the issue
* Reach me out [here](https://www.rahullakhanpal.in")

