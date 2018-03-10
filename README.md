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

# having fun with the API
julia> for story in topstories
           println("Title:\t $(story.title) by Author:\t$(story.by)\n")
       end
Title:	 Round Peg in a Square Hole [video] by Author:	xbryanx

Title:	 Debian 9.4 released by Author:	merraksh

Title:	 The antidepressant effect of sleep deprivation by Author:	onuralp

Title:	 Mother-daughter team joins YC to accelerate their drug discovery platform by Author:	Geekette

Title:	 Virtual Currency Offerings May Hit a New Peak with Telegram Coin Sale by Author:	thmslee

```

## Facing issues? :scream:
* Open a PR with the detailed expaination of the issue
* Reach me out [here](https://www.rahullakhanpal.in")

