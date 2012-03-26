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

config = JSON.parse( fs.readFileSync "./config/database.json", "utf8" )[process.env.NODE_ENV]
console.log [ config.host, config.database, config.port, { username: config.username, password: config.password } ]
mongoose.connect config.host, config.database, config.port, { username: config.username, password: config.password }

# Routes	
app.get '/', routes.index
app.get '/post/new', routes.newPost
app.post '/post/new', routes.addPost
app.get '/post/:id', routes.viewPost

app.listen process.env.PORT || 3000
console.log "Express server listening on port %d in %s mode", app.address().port, app.settings.env
