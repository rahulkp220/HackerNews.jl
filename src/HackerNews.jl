module HackerNews

# Module Imports
using HTTP
using JSON

# Abstract Type
abstract type HNApiRoute end 

# HNApiRoute Subtypes
struct MaxItem <: HNApiRoute end
struct TopStories <: HNApiRoute end 
struct NewStories <: HNApiRoute end 
struct BestStories <: HNApiRoute end 
struct AskStories <: HNApiRoute end 
struct ShowStories <: HNApiRoute end 
struct JobStories <: HNApiRoute end 
struct Updates <: HNApiRoute end

# Declaring the values
hn_route_string(::Type{MaxItem}) = "maxitem"
hn_route_string(::Type{TopStories}) = "topstories"
hn_route_string(::Type{NewStories}) = "newstories"
hn_route_string(::Type{BestStories}) = "beststories"
hn_route_string(::Type{AskStories}) = "askstories"
hn_route_string(::Type{ShowStories}) = "showstories"
hn_route_string(::Type{JobStories}) = "jobstories"
hn_route_string(::Type{Updates}) = "updates"

"""
HackerNews initializer composite type
"""
struct HN
    story
    nposts::Int64
    user_related::Bool

    # Inner constructor
    HN(story, nposts=1, user_related=false) = new(story, nposts, user_related)
end


"""
HackerNews post composite type
""" 
struct HNPost
    data
    id
    deleted
    itemtype
    by
    time
    text
    dead
    parent
    poll
    kids
    url
    score
    title
    parts
    descendants

    # Inner constructor
    HNPost(data,
            id      =   get(data,"id",nothing), 
            deleted =   get(data,"deleted",nothing), 
            itemtype=   get(data, "type", nothing), 
            by      =   get(data,"by",nothing), 
            time    =   get(data,"time",nothing),
            text    =   get(data,"text",nothing),
            dead    =   get(data,"dead",nothing), 
            parent  =   get(data,"parent",nothing), 
            poll    =   get(data,"poll",nothing), 
            kids    =   get(data, "kids",nothing), 
            url     =   get(data,"url",nothing),
            score   =   get(data,"score",nothing),
            title   =   get(data,"title",nothing),
            parts   =   get(data,"parts",nothing), 
            descendants=get(data,"descendants",nothing)) = new(data,id, deleted, itemtype, by, time,text, dead, 
                                                            parent, poll, kids, url, score, title, parts, descendants)
end

"""
Hackernews user composite type
"""
struct HNUser
    data
    id
    delay
    created
    karma
    about
    submitted

    # Inner constructor
    HNUser(data, 
            id      =   get(data, "id", nothing), 
            delay   =   get(data, "delay", nothing),
            created =   get(data, "created", nothing),
            karma   =   get(data, "karma", nothing),
            about   =   get(data, "about", nothing), 
            submitted=  get(data, "submitted", nothing)) = new(data, id, delay, created, karma, about, submitted)
end

"""
Parse response for updates
"""
function parse_hn_response(::Type{Updates}, response, hn)
    @info("fetching updates..")
    JSON.parse(String(response.body))[hn.user_related ? "profiles" : "items"]  
end

"""
Parse response for maxitem
"""
function parse_hn_response(::Type{MaxItem}, response, hn)
    @info("fetching maxitem..")
    JSON.parse(String(response.body))    
end

"""
Parse response
"""
function parse_hn_response(story, response, hn) 
    @info("fetching $(story)...")
    eval(JSON.parse(String(response.body)))[1:hn.nposts]    
end

"""
function to get the ids for a story
"""
function getids(hn::HN)
    response = HTTP.request("GET","https://hacker-news.firebaseio.com/v0/" * hn_route_string(hn.story) * ".json?print=pretty")
    parse_hn_response(hn.story, response, hn)    
end


"""
function to get the actual posts for given array of IDs
"""
function getinfo(hn::HN)
    ids = HackerNews.getids(hn)
    posts = HNPost[]
    users = HNUser[]

    if hn.user_related == false
        @info("generating post data...")
        for i in 1:hn.nposts
            response = HTTP.request("GET","https://hacker-news.firebaseio.com/v0/item/" * string(ids[i]) * ".json?print=pretty")
            response_json = JSON.parse(String(response.body))
            hnpost = HNPost(response_json)
            push!(posts, hnpost)
        end
    else
        for i in 1:hn.nposts
            @info("generating user data...")
            response = HTTP.request("GET","https://hacker-news.firebaseio.com/v0/user/" * string(ids[i]) * ".json?print=pretty")
            response_json = JSON.parse(String(response.body))
            hnuser = HNUser(response_json)
            push!(users, hnuser)
        end
    end

    # return whats required
    if hn.user_related users else posts end
end

"""
function to get a single user info
"""
function getuser(id::String)
    response = HTTP.request("GET","https://hacker-news.firebaseio.com/v0/user/" * id * ".json?print=pretty")    
    response_json = JSON.parse(String(response.body))
    HNUser(response_json)
end

# Module exports
export getinfo, getuser, getids
export HN, HNUser, HNPost
export HNApiRoute, MaxItem, TopStories, NewStories, BestStories
export AskStories, ShowStories, JobStories, Updates
export hn_route_string
end
