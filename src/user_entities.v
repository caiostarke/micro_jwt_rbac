module main

[table: 'users']
struct User {
	mut:
		id int [primary; sql: serial]
		username string [required; sql_type: 'TEXT']
		password string [required; sql_type: 'TEXT']
		role_id int [default: '0'; sql_type: 'INT']
		created_at string [default: 'CURRENT_TIMESTAMP']
		updated_at string [default: 'CURRENT_TIMESTAMP']
		deleted_at string [default: 'CURRENT_TIMESTAMP']
		active bool
}