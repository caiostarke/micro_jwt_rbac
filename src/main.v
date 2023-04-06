module main

import vweb

const (
	http_port = 8081
	rbac_policies_file = './config/rbac_config.config'
)

struct App {
	vweb.Context
	middlewares map[string][]vweb.Middleware
}

pub fn (app App) before_request() {
	println('[Vweb] ${app.Context.req.method} ${app.Context.req.url}')
}

fn main() {
	vweb.run(new_app(), http_port) 
}

fn new_app() &App {
	mut app := &App{
		middlewares: {
			'/admin/': [rbac_middleware]
			'/blog/': [rbac_middleware]
			'/features/': [rbac_middleware]
			'/bla/': [rbac_middleware]
		}
	}

	return app
}

["/"; get] 
pub fn(mut app App) ping() ?vweb.Result {
	return app.text('ping')
}
