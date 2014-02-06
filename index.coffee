Fetcher = require './lib/fetcher'
fs      = require 'fs'

for i in [1..47]
  do (pref_id=i)->
    fetcher = new Fetcher(pref_id)
    fetcher.fetch (error, page)->
      fs.writeFileSync("json/#{pref_id}.json", page.to_json())
