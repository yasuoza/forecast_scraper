cheerio = require 'cheerio'

class Page
  constructor: (@html, @prefName)->
    @$ = cheerio.load(@html)

  parse: (html=@html) ->
    @parsed ?= do (self=this) ->
      $ = self.$
      self.prefName ?= $('td.titleText').text().trim().split(' ')[1]
      $dataRows = $('table#forecasttablefont').children('tr')
      areas = for areaTitleElem, areaNo in $('th.th-area')
        area =  $(areaTitleElem).text().trim()
        data = for day in [1..2]
          $row = $dataRows.eq(areaNo * 4 + day)
          self.areaData($row)
        {area: area, data: data}
      {pref: self.prefName, areas: areas}

  areaData: ($row)->
    $ = @$
    {
      date: $row.find('th.weather').text().trim(),
      weather: $row.find('th.weather').find('img').attr('title'),
      rains: $row.find('td.rain')
                 .find('td')
                 .filter (i, elem) ->
                    $(elem).attr('align') == 'right'
                 .map (i, elem) ->
                   $(elem).text().slice(0, -1)
                 .toArray()
      description: $row.find('td.info')
                       .text()
                       .trim()
                       .replace /\s/g, ' '
                       .replace /[０-ｚ．]/g, ($0)->
                         String.fromCharCode(parseInt($0.charCodeAt(0))-65248)
      temps: {
        min: $row.find('td.temp tr').eq(1).find('.min').text().trim().slice(0, -1) ? '',
        max: $row.find('td.temp tr').eq(1).find('.max').text().trim().slice(0, -1) ? '',
      }
    }

  to_json: ->
    @json ?= JSON.stringify(@parse())

module.exports = Page
