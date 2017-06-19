//
//dataSource {
//	pooled = false//pooled = true
//	//jmxExport = true
//	driverClassName = "com.microsoft.sqlserver.jdbc.SQLServerDriver"
//	username = "auditoria"
//	password = "E5c0m100"
//}
//dataSource_legacySaeec {
//	pooled = false//pooled = true
//	//jmxExport = true
//	driverClassName = "com.microsoft.sqlserver.jdbc.SQLServerDriver"
//	username = "auditoria"
//	password = "E5c0m100"
//}
//dataSource_membership {
//	pooled = false//pooled = true
//	//jmxExport = true
//	driverClassName = "com.microsoft.sqlserver.jdbc.SQLServerDriver"
//	username = "auditoria"
//	password = "E5c0m100"
//}

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
			driverClassName = "com.microsoft.sqlserver.jdbc.SQLServerDriver"
			username = "auditoria"
			password = "E5c0m100"
			dbCreate = "validate"
//			url = "jdbc:sqlserver://10.100.128.58:1433;databaseName=qa_amib_registro"
			url = "jdbc:sqlserver://10.0.2.2:1433;databaseName=qa_amib_registro"
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
			driverClassName = "com.microsoft.sqlserver.jdbc.SQLServerDriver"
			username = "auditoria"
			password = "E5c0m100"
			dbCreate = "validate"
//			url = "jdbc:sqlserver://10.100.128.58:1433;databaseName=certificacion"
			url = "jdbc:sqlserver://10.0.2.2:1433;databaseName=certificacion"
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
			driverClassName = "com.microsoft.sqlserver.jdbc.SQLServerDriver"
			username = "auditoria"
			password = "E5c0m100"
			dbCreate = "validate"
//			url = "jdbc:sqlserver://10.100.128.58:1433;databaseName=qa_amib_membership"
			url = "jdbc:sqlserver://10.0.2.2:1433;databaseName=qa_amib_membership"
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
		dataSource_solicitudOnline {
//            dbCreate = "validate"
			username = "auditoria"
			password = "E5c0m100"
			dbCreate = "create"
//			url = "jdbc:sqlserver://10.100.128.58:1433;databaseName=amibqa"
			url = "jdbc:sqlserver://10.0.2.2:1433;databaseName=amibqa"
			driverClassName = "com.microsoft.sqlserver.jdbc.SQLServerDriver"
			dialect = "org.hibernate.dialect.SQLServerDialect"
            pooled = true
            properties {
               maxActive = -1
               minEvictableIdleTimeMillis=1800000
               timeBetweenEvictionRunsMillis=1800000
               numTestsPerEvictionRun=3
               testOnBorrow=true
               testWhileIdle=true
               testOnReturn=true
               validationQuery="SELECT 1"
            }
        }
		dataSource_unificada {
            dbCreate = "validate"
			username = "auditoria"
			password = "E5c0m100"
//			url = "jdbc:sqlserver://10.100.128.58:1433;databaseName=constanciasCertificacion"
			url = "jdbc:sqlserver://10.0.2.2:1433;databaseName=constanciasCertificacion"
			driverClassName = "com.microsoft.sqlserver.jdbc.SQLServerDriver"
			dialect = "org.hibernate.dialect.SQLServerDialect"
            pooled = true
            properties {
               maxActive = -1
               minEvictableIdleTimeMillis=1800000
               timeBetweenEvictionRunsMillis=1800000
               numTestsPerEvictionRun=3
               testOnBorrow=true
               testWhileIdle=true
               testOnReturn=true
               validationQuery="SELECT 1"
            }
        }
		
	}
	test {
			dataSource {
				dbCreate = "validate"
				url = "jdbc:sqlserver://10.100.128.58:1433;databaseName=dbamibregistro"
			}
			dataSource_legacySaeec {
				dbCreate = "validate"
				url = "jdbc:sqlserver://10.100.128.58:1433;databaseName=certificacion"
			}
			dataSource_membership {
				dbCreate = "validate" // one of 'create', 'create-drop', 'update', 'validate', ''
				url = "jdbc:sqlserver://10.100.128.58:1433;databaseName=dbamibmembership"
				logSql = true
			}
	}
	production {
			dataSource {
				driverClassName = "com.microsoft.sqlserver.jdbc.SQLServerDriver"
				username = "auditoria"
				password = "E5c0m100"
				dbCreate = "validate"
				url = "jdbc:sqlserver://10.100.128.58:1433;databaseName=qa_amib_registro"
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
				driverClassName = "com.microsoft.sqlserver.jdbc.SQLServerDriver"
				username = "auditoria"
				password = "E5c0m100"
				dbCreate = "validate"
				url = "jdbc:sqlserver://10.100.128.58:1433;databaseName=certificacion2"
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
				driverClassName = "com.microsoft.sqlserver.jdbc.SQLServerDriver"
				username = "auditoria"
				password = "E5c0m100"
				dbCreate = "validate"
				url = "jdbc:sqlserver://10.100.128.58:1433;databaseName=qa_amib_membership"
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
		dataSource_solicitudOnline {
            dbCreate = "validate"
			username = "auditoria"
			password = "E5c0m100"
			url = "jdbc:sqlserver://10.100.128.58:1433;databaseName=amibqa"
//			url = "jdbc:sqlserver://10.0.2.2:1433;databaseName=amibqa"
			driverClassName = "com.microsoft.sqlserver.jdbc.SQLServerDriver"
			dialect = "org.hibernate.dialect.SQLServerDialect"
            pooled = true
            properties {
               maxActive = -1
               minEvictableIdleTimeMillis=1800000
               timeBetweenEvictionRunsMillis=1800000
               numTestsPerEvictionRun=3
               testOnBorrow=true
               testWhileIdle=true
               testOnReturn=true
               validationQuery="SELECT 1"
            }
        }
		dataSource_unificada {
            dbCreate = "validate"
			username = "auditoria"
			password = "E5c0m100"
			url = "jdbc:sqlserver://10.100.128.58:1433;databaseName=constanciasCertificacion"
//			url = "jdbc:sqlserver://10.0.2.2:1433;databaseName=constanciasCertificacion"
			driverClassName = "com.microsoft.sqlserver.jdbc.SQLServerDriver"
			dialect = "org.hibernate.dialect.SQLServerDialect"
            pooled = true
            properties {
               maxActive = -1
               minEvictableIdleTimeMillis=1800000
               timeBetweenEvictionRunsMillis=1800000
               numTestsPerEvictionRun=3
               testOnBorrow=true
               testWhileIdle=true
               testOnReturn=true
               validationQuery="SELECT 1"
            }
        }
	}
}
