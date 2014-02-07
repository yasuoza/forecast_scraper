class ForecastScraper
  constructor: ->
    @Fetcher = require './lib/fetcher'
    @writer  = require './lib/file_writer'

  useWriter: (writer)->
    @writer = writer

module.exports = new ForecastScraper()
