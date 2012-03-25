routes = require "../routes/routes"

describe "routes", ->
	res = {}
	req = {}
	describe "index", ->
		it "should display index with posts", (done) ->
			req = null
			res.render = (view,vars) ->
					view.should.equal "index"
					vars.title.should.equal "My Coffeepress Blog"
					vars.posts.should.eql []
					done()
			routes.index req, res
	describe "new post", ->
		it "should display the add post page", (done) ->
			res.render = (view, vars) ->
				view.should.equal "add_post"
				vars.title.should.equal "Write New Post"
				done()
			routes.newPost req, res
	
	describe "add post", ->
		it "should add new post object", (done) ->
			req.body.post = 
				title: 'My New Post',
				body: 'My awesome post'
			res.render = (view, vars) ->
				view.should.equal 'index'
		routes.addPost req, res
		
	describe "view post", ->
		it "should show a given post", (done) ->
			req.params.post =
				title: "hi",
				body: "bye"
			res.render = (view, vars) ->
				view.should.equal 'post'
		
		routes.viewPost req, res
		
describe "feature", ->
	it "should add two numbers", ->
		(2+2).should.equal 4