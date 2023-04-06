module main

import json
import vweb

['/auth/login'; post]
pub fn(mut app App) controller_auth() vweb.Result {
	body := json.decode(AuthRequestDto, app.req.data) or {
		app.set_status(400, '')
		return app.json('Failed to decode json, err ${err}')
	}

	response := app.service_auth(body.username, body.password) or {
		return app.json('error ${err}')
	}

	return app.json(response)
}