enablePlugins(FlywayPlugin)

name := "pagila-flyway"

version := "0.1"

scalaVersion := "2.13.3"

libraryDependencies += "org.flywaydb" % "flyway-core" % "6.4.4"
libraryDependencies += "org.postgresql" % "postgresql" % "42.2.14"

flywayUrl := "jdbc:postgresql://localhost:5432/postgres?currentSchema=pagila_test"
flywayUser := "postgres"
flywayPassword := "mysecretpassword"
//flywayLocations += "db/migration"
//flywayUrl in Test := "jdbc:hsqldb:file:target/flyway_sample;shutdown=true"
//flywayUser in Test := "SA"
//flywayPassword in Test := ""
