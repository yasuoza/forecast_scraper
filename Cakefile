require 'coffee-script/register'
forecastScraper = require './'

option '-o', '--output [DIR]', 'directory for save jsons'

task 'forecast:fetch', 'fetch forecast data and write it via writer', (options)->
  writer  = forecastScraper.writer
  dir     = options.output || 'json'
  writer.prepare({dir: dir})
  for i in [1..47]
    do (pref_id=i)->
      fetcher = new forecastScraper.Fetcher(pref_id)
      fetcher.fetch (error, page)->
        writer.writeSync("#{dir}/#{pref_id}.json", page.to_json())
