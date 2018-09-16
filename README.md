[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Build Status](https://travis-ci.org/rahulkp220/HackerNews.jl.svg?branch=master)](https://travis-ci.org/rahulkp220/HackerNews.jl)
[![codecov.io](http://codecov.io/github/rahulkp220/HackerNews.jl/coverage.svg?branch=master)](http://codecov.io/github/rahulkp220/HackerNews.jl?branch=master)
[![GitHub contributors](https://img.shields.io/github/contributors/rahulkp220/HackerNews.jl.svg)](https://github.com/rahulkp220/HackerNews.jl/graphs/contributors)
[![GitHub issues](https://img.shields.io/github/issues/rahulkp220/HackerNews.jl.svg)](https://github.com/rahulkp220/HackerNews.jl/issues/)
[![GitHub version](https://badge.fury.io/gh/rahulkp220%2FHackerNews.jl.svg)](https://github.com/rahulkp220/HackerNews.jl)

[![ForTheBadge built-by-developers](http://ForTheBadge.com/images/badges/built-by-developers.svg)](https://GitHub.com/rahulkp220/)

# HackerNews.jl

The unofficial Julia API for Hackernews :fire:

See [Hacker News API](https://github.com/HackerNews/API)

### Installation

Since HackerNews is registered in official [Julia Registry](https://github.com/JuliaRegistries/General/tree/master/H/HackerNews), you can directly install it.

```julia
julia> ]
(v1.0) pkg> add HackerNews
```

### How it works?

The API is fairly simple to use and there isn't much required to get up and running.

#### Getting all the routes available to be used

The package provides a `HackerNews.HNApiRoute` which represents all the routes that the Hackernews API can handle. You can get a list of all available routes by typing,
```julia
julia> subtypes(HackerNews.HNApiRoute)
8-element Array{Union{DataType, UnionAll},1}:
 HackerNews.AskStories 
 HackerNews.BestStories
 HackerNews.JobStories 
 HackerNews.MaxItem    
 HackerNews.NewStories 
 HackerNews.ShowStories
 HackerNews.TopStories 
 HackerNews.Updates 
```

#### Getting `maxitem`

```julia
julia> using HackerNews

julia> maxitem = HackerNews.HN(HackerNews.MaxItem)

julia> HackerNews.getinfo(maxitem)
INFO: fetching maxitem..
INFO: generating post data...
1-element Array{HackerNews.HNPost,1}:
 HackerNews.HNPost(Dict{String,Any}(Pair{String,Any}("by", ...)

```

#### Getting `topstories`, `newstories`, `beststories`, `askstories`, `showstories` and `jobstories`

```julia

julia> topstories = HackerNews.HN(HackerNews.TopStories, 2)
HackerNews.HN(HackerNews.TopStories, 2, false)

julia> result = HackerNews.getinfo(topstories)
INFO: fetching HackerNews.TopStories...
INFO: generating post data...
2-element Array{HackerNews.HNPost,1}:
 HackerNews.HNPost(Dict{String,Any}(Pair{String,Any}("by", ....)
 HackerNews.HNPost(Dict{String,Any}(Pair{String,Any}("by", ...)

# getting the type of result 
julia> typeof(result)
Array{HackerNews.HNPost,1}

# get all the fieldnames available
julia> fieldnames(result[1])
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

# data field respresnt the raw Hackernews API response
julia> result[1].data
Dict{String,Any} with 8 entries:
  "by"          => "KKKKkkkk1"
  "descendants" => 0
  "score"       => 7
  "time"        => 1520836426
  "id"          => 16566536
  "title"       => "Intel Fights for Its Future"
  "type"        => "story"
  "url"         => "https://mondaynote.com/intel-fights-for-its-future-6498f886992b"

# accessing data using fields, AWESOME!
julia> result[1].id
16566536

julia> result[1].by
"KKKKkkkk1"

julia> result[1].title
"Intel Fights for Its Future"
```

#### Getting `updates`
Updates can be related to profiles as well as posts,

* for User updates, set `user_related=true` while instantiating the `HN` type object
* for Item updates, `HN` follows default settings which is `user_related=false`

```julia

# posts related updates
julia> item_updates = HackerNews.HN(HackerNews.Updates, 1, false)
HackerNews.HN(HackerNews.Updates, 1, false)

julia> HackerNews.getinfo(item_updates)
INFO: fetching updates..
INFO: generating post data...
1-element Array{HackerNews.HNPost,1}:
 HackerNews.HNPost(Dict{String,Any}(Pair{String,Any}("by", ...) 


# user related updates
julia> user_updates = HackerNews.HN(HackerNews.Updates, 1, true)
HackerNews.HN(HackerNews.Updates, 1, true)

julia> HackerNews.getinfo(user_updates)
INFO: fetching updates..
INFO: generating user data...
1-element Array{HackerNews.HNUser,1}:
 HackerNews.HNUser(Dict{String,Any}(Pair{String,Any}("submitted", Any[...])
```

#### Getting `user` information

```julia
julia> HackerNews.getuser("pg")
HackerNews.HNUser(Dict{String,Any}(Pair{String,Any}("submitted", ...)

# get the raw Hackernews api result inside data field
julia> HackerNews.getuser("pg").data
Dict{String,Any} with 5 entries:
  "submitted" => Any[10484520, 10071788, 10071052, 10071018, 10070939, 10070787, 10070703, 10070527, 10070299, 10070175  …  36, 34, 31, 22, …
  "karma"     => 155111
  "about"     => "Bug fixer."
  "id"        => "pg"
  "created"   => 1160418092

# or alternatively explore using all the fields
julia> fieldnames(HackerNews.getuser("pg"))
7-element Array{Symbol,1}:
 :data     
 :id       
 :delay    
 :created  
 :karma    
 :about    
 :submitted

# Again, awesome!
julia> HackerNews.getuser("pg").id
"pg"

julia> HackerNews.getuser("pg").karma
155111
```

### Facing issues? :scream:

* Open a PR with the detailed expaination of the issue.
* Reach me out [here](https://www.rahullakhanpal.in)

