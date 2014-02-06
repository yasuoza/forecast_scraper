request = require 'request'
async   = require 'async'
Page    = require './page'

ENDPOINT = 'http://www.jma.go.jp/jp/yoho'

class Fetcher
  constructor: (@prefId) ->
    @_request_pref_id = switch @prefId
      when 1
        [301..306]
      when 47
        [353..356]
      else
        [@prefId + 306]

  request: (request_pref_id, cb)->
    request request_pref_id, (error, response, body)->
      if error
        cb(error)
      else
        cb(null, body)

  fetch: (cb)->
    request_urls = ("#{ENDPOINT}/#{request_pref_id}.html" for request_pref_id in @_request_pref_id)
    prefId = @prefId
    async.map request_urls, @request, (error, results) ->
      if error
        console.error error
        cb?(error, null)
      else
        result = ''
        result += body for body in results
        page = new Page(result, prefId)
        cb?(null, page)

module.exports = Fetcher
