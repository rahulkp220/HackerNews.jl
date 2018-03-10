module HackerNews

# Module Imports
using HTTP
using JSON

"""
HackerNews initializer composite type
"""
type HNInit
    story::String
    nposts::Int64
end

"""
HackerNews post composite type
""" 
type HNPost
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
    HNPost(data,id=get(data,"id",nothing), deleted=get(data,"deleted",nothing), 
           itemtype=get(data, "type", nothing), by=get(data,"by",nothing), time=get(data,"time",nothing),
           text=get(data,"text",nothing),dead=get(data,"dead",nothing), parent=get(data,"parent",nothing), 
           poll=get(data,"poll",nothing), kids=get(data, "kids",nothing), url=get(data,"url",nothing),
           score=get(data,"score",nothing),title=get(data,"title",nothing),parts=get(data,"parts",nothing), 
           descendants=get(data,"descendants",nothing)) = new(data,id, deleted, itemtype, by, time,text, dead, 
                                                            parent, poll, kids, url, score, title, parts, descendants)
end

"""
function to get the ids for a story, default count being 10.
"""
function getids(hn::HNInit)
    response = HTTP.request("GET","https://hacker-news.firebaseio.com/v0/" * hn.story * ".json?print=pretty")
    data = eval(parse(convert(String, response.body)))
    return data
end


"""
function to get the actual posts for given array of IDs
"""
function getposts(hn::HNInit, ids::Array{Int64, 1})
    posts = HNPost[]

    for i in 1:hn.nposts
        response = HTTP.request("GET","https://hacker-news.firebaseio.com/v0/item/" * string(ids[i]) * ".json?print=pretty")
        response_json = JSON.parse(convert(String, response.body))
        hnpost = HNPost(response_json)
        push!(posts, hnpost)
    end

    return posts
end

# Module exports
export HNInit, HNPost, getids, getposts
end