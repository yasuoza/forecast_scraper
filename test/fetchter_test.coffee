expect  = require 'expect.js'
Fetcher = require '../lib/fetcher'
Page    = require '../lib/page'

describe 'Fetcher', ->
  it 'should fetch normal page', (done)->
    fetcher = new Fetcher(2)
    expect(fetcher.prefId).to.be 2
    fetcher.fetch (error, page)->
      expect(error).to.be null
      expect(page).to.be.a Page
      expect(page.parse().pref).to.eql '青森県'
      expect(page.parse().areas.length).to.be 3
      done()

  it 'should fetch hokkaido page', (done)->
    @timeout(60 * 1000) # timeout 60s
    fetcher = new Fetcher(1)
    expect(fetcher.prefId).to.be 1
    fetcher.fetch (error, page)->
      expect(error).to.be null
      expect(page).to.be.a Page
      expect(page.parse().pref).to.eql '北海道'
      expect(page.parse().areas.length).to.be 14
      done()

  it 'should fetch hokkaido page', (done)->
    @timeout(60 * 1000) # timeout 60s
    fetcher = new Fetcher(47)
    expect(fetcher.prefId).to.be 47
    fetcher.fetch (error, page)->
      expect(error).to.be null
      expect(page).to.be.a Page
      expect(page.parse().pref).to.eql '沖縄県'
      expect(page.parse().areas.length).to.be 7
      done()
