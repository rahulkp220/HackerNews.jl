[![Build Status](https://travis-ci.org/rahulkp220/HackerNews.jl.svg?branch=master)](https://travis-ci.org/rahulkp220/HackerNews.jl)
[![codecov.io](http://codecov.io/github/rahulkp220/HackerNews.jl/coverage.svg?branch=master)](http://codecov.io/github/rahulkp220/HackerNews.jl?branch=master)

# HackerNews.jl
The unofficial Julia API for Hackernews.

See [Hacker News API](https://github.com/HackerNews/API)

## Installation
```julia
julia> Pkg.clone("https://github.com/rahulkp220/HackerNews.jl")
```

## Update
```julia
julia> Pkg.update("HackerNews")
```

## How it works?

#### Getting `maxitem`    
```julia
julia> using HackerNews

julia> maxitem = HackerNews.HN("maxitem")
HackerNews.HN("maxitem", 1, false)

julia> HackerNews.getinfo(maxitem)
INFO: fetching maxitem..
INFO: generating post data...
1-element Array{HackerNews.HNPost,1}:
 HackerNews.HNPost(Dict{String,Any}(Pair{String,Any}("by", "BrandoElFollito"),Pair{String,Any}("time", 1520711666),Pair{String,Any}("id", 16559872),Pair{String,Any}("parent", 16558997),Pair{String,Any}("text", "Thanks for the reference. For a 10-11 yo (if I read &quot;5th grade&quot; correctly) this is actually a surprisingly abstract reaction (all the tragedy aside)"),Pair{String,Any}("type", "comment")), 16559872, nothing, "comment", "BrandoElFollito", 1520711666, "Thanks for the reference. For a 10-11 yo (if I read &quot;5th grade&quot; correctly) this is actually a surprisingly abstract reaction (all the tragedy aside)", nothing, 16558997, nothing, nothing, nothing, nothing, nothing, nothing, nothing)
 ```

#### Getting `topstories`, `newstories`, `beststories`, `askstories`, `showstories` and `jobstories`
```julia

# just set the story to any one of the above items and it works!
julia> story = "topstories"

# create a HN object with the number of posts you want to fetch
julia>topstories = HackerNews.HN(story, 2)
HackerNews.HN("topstories", 2, false)

# exploring fieldnames
julia> fieldnames(topstories)
3-element Array{Symbol,1}:
 :story       
 :nposts      
 :user_related

# get the info
julia> result = HackerNews.getinfo(topstories)
INFO: fetching topstories...
INFO: generating post data...
2-element Array{HackerNews.HNPost,1}:
 HackerNews.HNPost(Dict{String,Any}(Pair{String,Any}("by", "xbryanx"),Pair{String,Any}("descendants", 42),Pair{String,Any}("score", 314),Pair{String,Any}("time", 1520693674),Pair{String,Any}("id", 16558680),Pair{String,Any}("title", "Round Peg in a Square Hole [video]"),Pair{String,Any}("type", "story"),Pair{String,Any}("kids", Any[16559949, 16558849, 16559926, 16558987, 16559330, 16558793, 16559410, 16559513, 16558956, 16559479, 16559863]),Pair{String,Any}("url", "https://www.youtube.com/watch?time_continue=2&v=AvFNCNOyZeE")), 16558680, nothing, "story", "xbryanx", 1520693674, nothing, nothing, nothing, nothing, Any[16559949, 16558849, 16559926, 16558987, 16559330, 16558793, 16559410, 16559513, 16558956, 16559479, 16559863], "https://www.youtube.com/watch?time_continue=2&v=AvFNCNOyZeE", 314, "Round Peg in a Square Hole [video]", nothing, 42)
 HackerNews.HNPost(Dict{String,Any}(Pair{String,Any}("by", "tmstieff"),Pair{String,Any}("descendants", 20),Pair{String,Any}("score", 88),Pair{String,Any}("time", 1520698550),Pair{String,Any}("id", 16559004),Pair{String,Any}("title", "Literate Devops with Emacs Org-Mode"),Pair{String,Any}("type", "story"),Pair{String,Any}("kids", Any[16559433, 16559487, 16559561]),Pair{String,Any}("url", "http://howardism.org/Technical/Emacs/literate-devops.html")), 16559004, nothing, "story", "tmstieff", 1520698550, nothing, nothing, nothing, nothing, Any[16559433, 16559487, 16559561], "http://howardism.org/Technical/Emacs/literate-devops.html", 88, "Literate Devops with Emacs Org-Mode", nothing, 20)                                                                           

# explore fieldnames
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

 # exploring data field, which again respresents raw Hackernews api results
 julia> result[1].data
Dict{String,Any} with 9 entries:
  "by"          => "xbryanx"
  "descendants" => 42
  "score"       => 314
  "time"        => 1520693674
  "id"          => 16558680
  "title"       => "Round Peg in a Square Hole [video]"
  "type"        => "story"
  "kids"        => Any[16559949, 16558849, 16558987, 16559330, 16558793, 16559410, 16559513, 16558956, 16559479, 16559863, 16559926]
  "url"         => "https://www.youtube.com/watch?time_continue=2&v=AvFNCNOyZeE"
                                                        
```

#### Getting `user` information

```julia
julia> HackerNews.getuser("pg")
HackerNews.HNUser(Dict{String,Any}(Pair{String,Any}("submitted", Any[10484520, 10071788, 10071052, 10071018, 10070939, 10070787, 10070703, 10070527, 10070299, 10070175  …  36, 34, 31, 22, 20, 19, 17, 16, 14, 1]),Pair{String,Any}("karma", 155111),Pair{String,Any}("about", "Bug fixer."),Pair{String,Any}("id", "pg"),Pair{String,Any}("created", 1160418092)), "pg", nothing, 1160418092, 155111, "Bug fixer.", Any[10484520, 10071788, 10071052, 10071018, 10070939, 10070787, 10070703, 10070527, 10070299, 10070175  …  36, 34, 31, 22, 20, 19, 17, 16, 14, 1])

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

# awesome!
julia> HackerNews.getuser("pg").id
"pg"

julia> HackerNews.getuser("pg").karma
155111
```

#### Getting `updates`!
Updates can be related to profiles as well as posts,

* for User updates, set `user_related=true` while instantiating the `HN` type object
* for Item updates, `HN` follows default settings which is `user_related=false`

```julia
julia> userupdates = HackerNews.HN("updates", 2, true)
HackerNews.HN("updates", 2, true)

julia> HackerNews.getinfo(userupdates)
INFO: fetching updates..
INFO: generating user data...
INFO: generating user data...
2-element Array{HackerNews.HNUser,1}:
 HackerNews.HNUser(Dict{String,Any}(Pair{String,Any}("submitted", ...)                                  
 HackerNews.HNUser(Dict{String,Any}(Pair{String,Any}("submitted", ...)

julia> itemupdates = HackerNews.HN("updates", 2)
HackerNews.HN("updates", 2, false)

julia> HackerNews.getinfo(itemupdates)
INFO: fetching updates..
INFO: generating post data...
2-element Array{HackerNews.HNPost,1}:
 HackerNews.HNPost(Dict{String,Any}(Pair{String,Any}("by", ...)
 HackerNews.HNPost(Dict{String,Any}(Pair{String,Any}("by", ...)                                                     
```

## Facing issues? :scream:
* Open a PR with the detailed expaination of the issue
* Reach me out [here](https://www.rahullakhanpal.in")

