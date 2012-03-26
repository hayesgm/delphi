Horoscope = require '../models/Horoscope'

# TODO: 
module.exports =
	home: (req, res) ->
		res.render 'home',
			title: 'Delphi'
			
	index: (req, res) ->
		Horoscope.find {}, (err, horoscopes) ->
			switch req.params.format
				when 'json'
					res.json horoscopes
				else
					res.render 'index',
						title: 'Delphi | Horoscopes'
						horoscopes: horoscopes
	
	newHoroscope: (req, res) ->
		res.render 'add_horoscope', title: 'Write New Horoscope'
		
	addHoroscope: (req, res) ->
		req.body.horoscope.tags = req.body.horoscope.tags.split(',')
		new Horoscope(req.body.horoscope).save ->
			res.redirect '/horoscopes'
	
	viewHoroscope: (req, res) ->
		Horoscope.findById req.params.id, (err, horoscope) ->
			
			switch req.params.format
				when 'json'
					res.json horoscope
				else
					res.render 'horoscope', horoscope: horoscope, title: horoscope.title
					
	