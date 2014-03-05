require 'coffee-script/register'
forecastScraper = require './'
async = require 'async'

option '-o', '--output [DIR]', 'directory for save jsons'
option '', '--retry [RETRY_COUNT]', 'fetcher retry count. Default: 5'

task 'forecast:fetch', 'fetch forecast data and write it via writer', (options)->
  writer   = forecastScraper.writer
  dir      = options.output || 'json'
  maxRetry = if options.retry is '0' then 0 else parseInt(options.retry, 10) || 5
  writer.prepare({dir: dir})

  fetch_and_write =(pref_id, retryCnt=0, cb)->
    if retryCnt instanceof Function
      cb = retryCnt
      retryCnt = 0
    fetcher = new forecastScraper.Fetcher(pref_id)
    fetcher.fetch (error, page)->
      if error?
        if (retryCnt += 1) < maxRetry
          console.log "Will retry fetch pref_id: #{pref_id}"
          return fetch_and_write(pref_id, retryCnt, cb)
        else
          cb(error)
      else
        writer.writeSync("#{dir}/#{pref_id}.json", page.to_json())
        cb(null)

  async.eachLimit [1..47], 5, fetch_and_write, (err)->
    if err
      console.error err
