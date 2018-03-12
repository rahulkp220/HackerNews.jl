using HackerNews
using Base.Test

# testing HN for items
hnitems = HackerNews.HN(HackerNews.JobStories, 5)
@test hn_route_string(hnitems.story) == "jobstories"
@test hnitems.nposts == 5

# testing getinfo for items
posts = HackerNews.getinfo(hnitems)
@test length(posts) == 5
@test typeof(posts[1].data) == Dict{String,Any}

# testing HN for users
hnusers = HackerNews.HN(HackerNews.Updates, true)
@test hn_route_string(hnusers.story) == "updates"
@test hnusers.nposts == 1

# testing getinfo for user
users = HackerNews.getinfo(HackerNews.HN(HackerNews.Updates, true))
@test length(users) == 1
@test typeof(users[1].data) == Dict{String,Any}

# testing getuser
@test HackerNews.getuser("djsumdog").id == "djsumdog"
