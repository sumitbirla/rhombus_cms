SearchPath.create(short_code: 'loc', url: '/admin/cms/locations', description: 'Search for a location by its name')

Permission.create(section: 'cms', resource: 'admin', action: 'login')

Permission.create(section: 'cms', resource: 'page', action: 'create')
Permission.create(section: 'cms', resource: 'page', action: 'update')
Permission.create(section: 'cms', resource: 'page', action: 'destroy')

Permission.create(section: 'cms', resource: 'content_block', action: 'create')
Permission.create(section: 'cms', resource: 'content_block', action: 'update')
Permission.create(section: 'cms', resource: 'content_block', action: 'destroy')

Permission.create(section: 'cms', resource: 'menu', action: 'create')
Permission.create(section: 'cms', resource: 'menu', action: 'update')
Permission.create(section: 'cms', resource: 'menu', action: 'destroy')

Permission.create(section: 'cms', resource: 'location', action: 'read')
Permission.create(section: 'cms', resource: 'location', action: 'create')
Permission.create(section: 'cms', resource: 'location', action: 'update')
Permission.create(section: 'cms', resource: 'location', action: 'destroy')

Permission.create(section: 'cms', resource: 'photo_album', action: 'read')
Permission.create(section: 'cms', resource: 'photo_album', action: 'create')
Permission.create(section: 'cms', resource: 'photo_album', action: 'update')
Permission.create(section: 'cms', resource: 'photo_album', action: 'destroy')

Permission.create(section: 'cms', resource: 'comment', action: 'read')
Permission.create(section: 'cms', resource: 'comment', action: 'create')
Permission.create(section: 'cms', resource: 'comment', action: 'update')
Permission.create(section: 'cms', resource: 'comment', action: 'destroy')
Permission.create(section: 'cms', resource: 'comment', action: 'approve')
