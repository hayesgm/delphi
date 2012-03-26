express = require("express")
mongoose = require("mongoose")
fs = require("fs")
routes = require("./routes/routes")

app = module.exports = express.createServer()
app.configure ->
	app.set "views", __dirname + "/views"
	app.set "view engine", "jade"
	app.use express.bodyParser()
	app.use express.methodOverride()
	app.use app.router
	app.use express.static(__dirname + "/public")

app.configure "development", ->
	app.use express.errorHandler(
		dumpExceptions: true
		showStack: true
	)

app.configure "production", ->
	app.use express.errorHandler()

# Configure App
console.log process.env.NODE_ENV


config = require("./config/database")[process.env.NODE_ENV]
mongoose.connect "mongodb://#{config.username}:#{config.password}@#{config.host}:#{config.port}/#{config.database}"

# Routes	
app.get '/', routes.home
app.get '/horoscopes.:format?', routes.index
app.get '/horoscopes/new', routes.newHoroscope
app.post '/horoscopes/new', routes.addHoroscope
app.get '/horoscopes/:id.:format?', routes.viewHoroscope

app.listen process.env.PORT || 3000
console.log "Express server listening on port %d in %s mode", app.address().port, app.settings.env
