module main

import vweb
import json

pub fn rbac_middleware(mut ctx vweb.Context) bool {
	token := ctx.get_header('token')

	r := ctx.req.url.split("/")
	resource := r[1]
	
	method := ctx.req.method.str()
	
	if token == '' {
		ctx.set_status(401, '')
		ctx.json("failed, token invalid")
		return false
	}

	is_token_valid := auth_verify(token)
	if !is_token_valid {
		ctx.set_status(401, '')
		ctx.json("failed, token invalid")
		return false
	}

	token_payload_json := extract_token_payload(token)
	
	token_payload := json.decode(JwtPayload, token_payload_json) or {
		return false
	}

	println(resource)
	println('${red}| MIDDLEWARE |${reset} User: ${white}${token_payload.name}${reset} with role ${white}${roles[token_payload.role_id]}${reset} trying ${white}${actions[method]}${reset} to ${white}${resource} ${reset} ')

	a := has_access(token_payload.role_id, resources[resource], actions[method]) or {
		eprintln('error ${err}')
		ctx.set_status(500, 'server internal error')
		return false
	}
	if !a {
		ctx.set_status(401, '')
		ctx.json("unauthorized access")
		return false
	}

	return true
}
