resource "google_sql_database_instance" "cloud-sql-terraform" {
  name = "cloud-sql-terraform"
  database_version = "POSTGRES_15"
  deletion_protection = false 
  region = "asia-northeast3"

  settings {
    tier = "db-1-micro"
  }
}

resource "google_sql_user" "myuser-terraform" {
  name = "Lawrence"
  password = "123"
  instance = google_sql_database_instance.cloud-sql-terraform.name 
}