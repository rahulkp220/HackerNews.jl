using HackerNews, Compat
using Compat.Test

# testing maxitems
maxitem = HackerNews.HN(HackerNews.MaxItem)
result_maxitem = HackerNews.getinfo(maxitem)

@test hn_route_string(maxitem.story) == "maxitem"
@test maxitem.nposts == 1
@test typeof(result_maxitem[1].data) == Dict{String,Any}


# testing jobstories
jobstories = HackerNews.HN(HackerNews.JobStories,2)
result_jobstories = HackerNews.getinfo(jobstories)

@test hn_route_string(jobstories.story) == "jobstories"
@test jobstories.nposts == 2
@test typeof(result_jobstories[1].data) == Dict{String,Any}


# testing updates

## user updates
user_updates = HackerNews.HN(HackerNews.Updates, 1, true)
result_user_updates = HackerNews.getinfo(user_updates)

@test hn_route_string(user_updates.story) == "updates"
@test user_updates.nposts == 1
@test typeof(result_user_updates) == Array{HackerNews.HNUser,1}
@test typeof(result_user_updates[1].data) == Dict{String,Any}

## post/item updates
post_updates = HackerNews.HN(HackerNews.Updates, 1, false)
result_post_updates = HackerNews.getinfo(post_updates)

@test hn_route_string(post_updates.story) == "updates"
@test post_updates.nposts == 1
@test typeof(result_post_updates) == Array{HackerNews.HNPost,1}
@test typeof(result_post_updates[1].data) == Dict{String,Any}


# testing user information
user = HackerNews.getuser("pg")

@test typeof(user) == HackerNews.HNUser
@test typeof(user.data) == Dict{String,Any}
@test user.id == "pg"




