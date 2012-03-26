mongoose = require 'mongoose'
subs = require '../config/subs'

Horoscope = new mongoose.Schema(
	title: String
	body: String
	tags: [String]
)

Horoscope.method 'horoscope', (gender, age) ->
	res = this.body
	# console.log res
	for sub in subs['subs']
		# console.log [ new RegExp("<" + sub['exp'] + ">", "i"), sub['replace'] ]
		res = res.replace new RegExp("<" + sub['exp'] + ">", "i"), sub['replace']
	# console.log res
	res

module.exports = mongoose.model 'Horoscope', Horoscope