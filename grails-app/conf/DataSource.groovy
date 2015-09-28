
dataSource {
	pooled = false//pooled = true
	//jmxExport = true
	driverClassName = "com.microsoft.sqlserver.jdbc.SQLServerDriver"
	username = "sa"
	password = "bimalatrop2014"
}
dataSource_legacySaeec {
	pooled = false//pooled = true
	//jmxExport = true
	driverClassName = "com.microsoft.sqlserver.jdbc.SQLServerDriver"
	username = "sa"
	password = "bimalatrop2014"
}
dataSource_membership {
	pooled = false//pooled = true
	//jmxExport = true
	driverClassName = "com.microsoft.sqlserver.jdbc.SQLServerDriver"
	username = "sa"
	password = "bimalatrop2014"
}

hibernate {
	cache.use_second_level_cache = true
	cache.use_query_cache = false
    //cache.region.factory_class = 'net.sf.ehcache.hibernate.EhCacheRegionFactory' // Hibernate 3
	cache.region.factory_class = 'org.hibernate.cache.ehcache.EhCacheRegionFactory' // Hibernate 4
	singleSession = true // configure OSIV singleSession mode
}

// environment specific settings
environments {
	development {
			dataSource {
				dbCreate = "validate" // one of 'create', 'create-drop', 'update', 'validate', ''
				url = "jdbc:sqlserver://bimalatrop.no-ip.biz:1433;databaseName=dbamibregistro"
				logSql = true
			}
			dataSource_legacySaeec {
				dbCreate = "validate" // one of 'create', 'create-drop', 'update', 'validate', ''
				url = "jdbc:sqlserver://bimalatrop.no-ip.biz:1433;databaseName=certificacion"
				logSql = true
			}
			dataSource_membership {
				dbCreate = "validate" // one of 'create', 'create-drop', 'update', 'validate', ''
				url = "jdbc:sqlserver://bimalatrop.no-ip.biz:1433;databaseName=dbamibmembership"
				logSql = true
			}
	}
	test {
			dataSource {
				dbCreate = "validate"
				url = "jdbc:sqlserver://bimalatrop.no-ip.biz:1433;databaseName=dbamibregistro"
			}
			dataSource_legacySaeec {
				dbCreate = "validate"
				url = "jdbc:sqlserver://bimalatrop.no-ip.biz:1433;databaseName=certificacion"
			}
			dataSource_membership {
				dbCreate = "validate" // one of 'create', 'create-drop', 'update', 'validate', ''
				url = "jdbc:sqlserver://bimalatrop.no-ip.biz:1433;databaseName=dbamibmembership"
				logSql = true
			}
	}
	production {
			dataSource {
				dbCreate = "validate"
				url = "jdbc:sqlserver://bimalatrop.no-ip.biz:1433;databaseName=dbamibregistro"
				properties {
					// See http://grails.org/doc/latest/guide/conf.html#dataSource for documentation
					jmxEnabled = true
					initialSize = 5
					maxActive = 50
					minIdle = 5
					maxIdle = 25
					maxWait = 10000
					maxAge = 10 * 60000
					timeBetweenEvictionRunsMillis = 5000
					minEvictableIdleTimeMillis = 60000
					validationQuery = "SELECT 1"
					validationQueryTimeout = 3
					validationInterval = 15000
					testOnBorrow = true
					testWhileIdle = true
					testOnReturn = false
					jdbcInterceptors = "ConnectionState"
					defaultTransactionIsolation = java.sql.Connection.TRANSACTION_READ_COMMITTED
				}
			}
			dataSource_legacySaeec {
				dbCreate = "validate"
				url = "jdbc:sqlserver://bimalatrop.no-ip.biz:1433;databaseName=certificacion"
				properties {
					// See http://grails.org/doc/latest/guide/conf.html#dataSource for documentation
					jmxEnabled = true
					initialSize = 5
					maxActive = 50
					minIdle = 5
					maxIdle = 25
					maxWait = 10000
					maxAge = 10 * 60000
					timeBetweenEvictionRunsMillis = 5000
					minEvictableIdleTimeMillis = 60000
					validationQuery = "SELECT 1"
					validationQueryTimeout = 3
					validationInterval = 15000
					testOnBorrow = true
					testWhileIdle = true
					testOnReturn = false
					jdbcInterceptors = "ConnectionState"
					defaultTransactionIsolation = java.sql.Connection.TRANSACTION_READ_COMMITTED
				}
			}
			dataSource_membership {
				dbCreate = "validate"
				url = "jdbc:sqlserver://bimalatrop.no-ip.biz:1433;databaseName=dbamibmembership"
				properties {
					// See http://grails.org/doc/latest/guide/conf.html#dataSource for documentation
					jmxEnabled = true
					initialSize = 5
					maxActive = 50
					minIdle = 5
					maxIdle = 25
					maxWait = 10000
					maxAge = 10 * 60000
					timeBetweenEvictionRunsMillis = 5000
					minEvictableIdleTimeMillis = 60000
					validationQuery = "SELECT 1"
					validationQueryTimeout = 3
					validationInterval = 15000
					testOnBorrow = true
					testWhileIdle = true
					testOnReturn = false
					jdbcInterceptors = "ConnectionState"
					defaultTransactionIsolation = java.sql.Connection.TRANSACTION_READ_COMMITTED
				}
			}
	}
}
