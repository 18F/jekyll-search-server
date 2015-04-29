# jekyll-search-server

A standalone search crawler and API for Jekyll sites.

## Prerequisites

1. A Jekyll site (running locally, remotely, or both)
2. The Jekyll sites use the [jekyll_pages_api](https://github.com/18F/jekyll_pages_api) plugin.
3. A running Elasticsearch instance ([quickstart]())

## Usage

Clone the repo, `cd` into it and install dependencies:

```
git clone git@github.com/18f/jekyll-search-server
cd jekyll-search-server
bundle install
```

Add the URLs for your Jekyll sites via environment variables:

- `JEKYLL_SEARCH_DEV_URL` (defaults to `http://localhost:4000`)
- `JEKYLL_SEARCH_PROD_URL` (there is no default, set this if you need it)

Crawl and index with a single `rake` task:

```
bundle exec rake pages:crawl
```

Run the server and test out the API:

```
bundle exec rails s
```

In another terminal tab:

```
curl http://localhost:3000/search\?q\=%22How%20to%20write%20a%20blog%22
{
   "query":"\"How to write a blog\"",
   "results":[
      {
         "id":1262,
         "title":"How to write a blog for 18F",
         "path":"/blogging/",
         "body":"How to write a blog for 18F At 18F we keep a private GitHub repo for kicking around ideas on the blog. This is how we use that repo. We use milestones for workflow tracking: idea draft ready approved For new posts: Drop ideas for future blog posts into the ideas milestone as individual issues. Please include the following headings: ## Audience ## Goal of blog post ## Imagery ideas ## Description – This is what people will see in the blog post list. If you'd like to create a separate description, insert it here; otherwise, we'll likely use the first couple of sentences of the post. ## Who needs to clear the post as a checklist (on your end, not GSA's), then come back and check them off when approved. Examples: [ ] partner at agency [ ] stakeholder Any team member can \"pick up\" issues and begin drafting a post. Once an issue is in writing mode, move it to the drafts milestone. Create a Google Doc in the Blog folder with the text of your post. Include the URL of the GitHub issue at the top. Paste a link to the doc in the issue. Once post is ready for comms approval: Assign the issue to @quepol (Hillary). Move it to the ready milestone. Share the doc with: Ori Hoffer Gianelle Rivera (congressional) Jackeline Stewart Johnson (press secretary) After comments/suggestions are received from them, move the issue to the approved milestone. Write a new comment and /cc @gboone @OriHoffer, who will: Help you follow the blogging guide to convert the post to Markdown, if you like Post it to staging Post it to production Once post goes live, close the issue.",
         "created_at":"2015-04-29T15:03:25.267Z",
         "updated_at":"2015-04-29T15:03:25.267Z"
      },
    // ...
   ]
}
```

### Elasticsearch quickstart

OSX:

Install `brew` if you don't already have it:

```
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

Then install Elasticsearch and start the Elasticsearch server:

```
brew install elasticsearch
elasticsearch --config=/usr/local/opt/elasticsearch/config/elasticsearch.yml
```

Ubuntu:

https://gist.github.com/ricardo-rossi/8265589463915837429d

### Elasticsearch Configuration

`searchkick` is used to handle all Elasticsearch tasks. By default, it looks at `ENV["ELASTICSEARCH_URL"]` (which defaults to`localhost:9200`) for the Elasticsearch server. However you can change that by creating a Rails initializer in `config/initializers/elasticsearch.rb`:

```ruby
ENV["ELASTICSEARCH_URL"] = "http://username:password@api.searchbox.io"
```

Further reading on `searchkick` configuration: https://github.com/ankane/searchkick#other

# TODO

- make this easily installable on Cloud Foundry
- remove sqlite, replace with postgres (a requirement for Cloud Foundry)
- set up GitHub webhook listener


