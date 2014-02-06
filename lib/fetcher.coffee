request = require 'request'
async   = require 'async'
Page    = require './page'

ENDPOINT = 'http://www.jma.go.jp/jp/yoho'

class Fetcher
  constructor: (@pref_id) ->
    @_request_pref_id = switch @pref_id
      when 1
        @_pref_name = '北海道'
        [301..306]
      when 47
        @_pref_name = '沖縄県'
        [353..356]
      else
        [@pref_id + 306]

  request: (request_pref_id, cb)->
    request request_pref_id, (error, response, body)->
      if error
        cb(error)
      else
        cb(null, body)

  fetch: (cb)->
    request_urls = ("#{ENDPOINT}/#{request_pref_id}.html" for request_pref_id in @_request_pref_id)
    pref_name = @_pref_name
    async.map request_urls, @request, (error, results) ->
      if error
        console.error error
        cb?(error, null)
      else
        result = ''
        result += body for body in results
        page = new Page(result, pref_name)
        cb?(null, page)

module.exports = Fetcher
