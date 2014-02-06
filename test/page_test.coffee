fs = require 'fs'
expect = require 'expect.js'
Page = require '../lib/page'

describe 'Page', ->
  describe 'normal page', ->
    it 'should parse html data', ->
      htmlData = fs.readFileSync('./test/fixtures/343.html', 'utf8')
      page = new Page(htmlData)
      data = page.parse()
      expect(data.pref).to.be '徳島県'
      expect(data.areas.length).to.be 2
      expect(data.areas[0].data[0].temps.min).to.be ''
      expect(data.areas[0].data[0].temps.max).to.be '8'
      expect(data.areas[0].data[0].rains).to.eql ['--', '--', '60', '80']

  describe 'hokkaido', ->
    it 'should parse html data', ->
      htmlData = ""
      htmlData += fs.readFileSync("./test/fixtures/#{i}.html", 'utf8') for i in [301...307]
      page = new Page(htmlData, 1)
      data = page.parse()
      expect(data.pref).to.be '北海道'
      expect(data.areas[0].area).to.be '宗谷地方'
      expect(data.areas[0].data[0].temps).to.eql {max: 2, min: ''}
      expect(data.areas[0].data[1].rains).to.eql ['60', '50', '50', '20']

  describe 'okinawa', ->
    it 'should parse html data', ->
      htmlData = ""
      htmlData += fs.readFileSync("./test/fixtures/#{i}.html", 'utf8') for i in [353...356]
      page = new Page(htmlData, 47)
      data = page.parse()
      expect(data.pref).to.be '沖縄県'
      expect(data.areas[0].area).to.be '本島中南部'
      expect(data.areas[0].data[0].temps).to.eql {max: '', min: ''}
      expect(data.areas[0].data[0].rains).to.eql ['--', '--', '--', '30']
      expect(data.areas[4].data[0].rains).to.eql ['--', '--', '--', '50']
      expect(data.areas[4].data[0].temps).to.eql {max: '', min: ''}
      expect(data.areas[4].data[1].rains).to.eql ['20', '10', '10', '10']
      expect(data.areas[4].data[1].temps).to.eql {max: 24, min: 19}

