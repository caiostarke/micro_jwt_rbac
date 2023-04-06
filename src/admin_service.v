module main

import databases

pub fn has_access(role_id int, resource string, action string) !bool {
	permissions := get_permissions(role_id) or {
		return err
	}

	for p in permissions {
		if p.resource == resource && p.permissions == action {
			return true
		}
	}

	return false
}

pub fn get_permissions(role_id int) ![]Permission {
	mut db := databases.create_db_connection() or {
		eprintln(err)
		panic(err)
	}

	result := sql db {
		select from Permission where role_id == role_id
	}

	if result.len == 0 {
		return error('permissions related to this resource not found')
	}

	db.close()!

	return result
} 