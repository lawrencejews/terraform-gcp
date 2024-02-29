resource "google_spanner_instance" "spanner-terraform" {
  name = "spanner-terraform"
  config = "regional-asia-northeast3"
  display_name = "Spanner from terraform"
  num_nodes = 1
  labels = {
    "environment" = "cloud_spanner_practice"
  }
}

resource "google_spanner_database" "spanner-database-terraform" {
  name = "spanner-database-terraform"
  instance = google_spanner_instance.spanner-terraform.name
}