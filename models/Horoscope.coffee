mongoose = require 'mongoose'

Horoscope = new mongoose.Schema(
	title: String
	body: String
)

module.exports = mongoose.model 'Horoscope', Horoscope