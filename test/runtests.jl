using HackerNews
using Base.Test

# testing HNInit
hn = HackerNews.HNInit("jobstories", 5)
@test hn.story == "jobstories"
@test hn.nposts == 5

# testing getids
ids = HackerNews.getids(hn)
@test length(ids) == 11
@test typeof(ids) == Array{Int64,1}

# testing getposts
posts = HackerNews.getposts(hn, ids)
@test length(posts) == 5
@test typeof(posts[1].data) == Dict{String,Any}
