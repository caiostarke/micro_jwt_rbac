module main 

import databases
import os

const (
	rbac_config_file = "./config/rbac_config.config"
	red = '\033[1;31m'
	white = '\033[1;37m'
	green = '\033[1;32m'
	reset = '\033[0m'
)

pub fn load_rbac_policies(file string) {
	lines := os.read_lines(file) or {
		panic(err)
	}

	for line in lines {
		policy := line.split(",")
		policy_trim := policy.map(it.trim(' '))

		create_permissions(policy_trim[1], policy_trim[2], policy_trim[3])
	}
}

pub fn update_rbac_policies(file string) {
	mut db := databases.create_db_connection() or {
		panic(err)
	}

	query := 'DELETE FROM permissions'

	db.exec(query)

	load_rbac_policies(file)
}

fn create_permissions(role string, resource string, action string) {
	mut db := databases.create_db_connection() or {
		panic(err)
	} 

	mut role_id := 0

	match role {
		"user" { role_id = 0}
		"admin" { role_id = 1}
		else {
			role_id = 2
		}
	}

	p := Permission{
		role_id: role_id
		resource: resource
		permissions: action 

	}

	sql db {
		insert p into Permission
	}

	print('${green}CREATED SUCCESSFULLY${reset}')
	print(' Role: ${white} ${role} ${reset} with permission for ${white} ${action} ${reset} in resource ${white} ${resource} ${reset}\n')
}

