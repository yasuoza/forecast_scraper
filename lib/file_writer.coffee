BaseWriter = require './base_writer'
mkdirp     = require 'mkdirp'
fs         = require 'fs'

class FileWriter extends BaseWriter
  prepare: (options)->
    mkdirp.sync(options.dir)

  writeSync: (filename, text)->
    fs.writeFileSync(filename, text)

module.exports = new FileWriter()
