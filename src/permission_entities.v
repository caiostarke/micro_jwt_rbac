module main

const (
	// This is hardcoded but for improve configurability it can be
	// set by external files

	resources = {
		'admin': 'admin_data',
		'blog': 'blog',
		'features': 'features'
	}

	actions = {
		'GET': 'read',
		'POST': 'write',
		'DELETE': 'delete',
		'PUT': 'update',
	}

	roles = {
		0: "user",
		1: "admin",
		2: "super_admin"
	}
)

[table: 'permissions']
struct Permission {
	id int [primary; sql: serial]
	role_id int [required]
	resource string [required; sql_type: 'TEXT']
	permissions string [required; sql_type: 'TEXT']
}

