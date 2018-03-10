using HackerNews
using Base.Test

# testing HN for items
hnitems = HackerNews.HN("jobstories", 5)
@test hnitems.story == "jobstories"
@test hnitems.nposts == 5

# testing getinfo for items
posts = HackerNews.getinfo(hnitems)
@test length(posts) == 5
@test typeof(posts[1].data) == Dict{String,Any}

# testing HN for users
hnusers = HackerNews.HN("updates", 5, true)
@test hnusers.story == "updates"
@test hnusers.nposts == 5

# testing getinfo for user
users = HackerNews.getinfo(HackerNews.HN("updates", 5, true))
@test length(users) == 5
@test typeof(users[1].data) == Dict{String,Any}

# testing getuser
@test HackerNews.getuser("djsumdog").id == "djsumdog"
