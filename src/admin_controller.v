module main

import vweb

["/admin/data"; get]
pub fn(mut app App) admin_get() vweb.Result {
	println("top secret content")

	return app.json("top secret content")
}

["/admin/data"; post]
pub fn(mut app App) admin_post() vweb.Result {
	println("top secret content")

	return app.json("top secret content")
}

['/bla/ca'; get]
pub fn(mut app App) bla_req() vweb.Result {
	return app.json("u got it")
}