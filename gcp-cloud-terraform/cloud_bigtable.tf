resource "google_bigtable_instance" "bigtable-instance-terraform" {
  name = "bigtable-terraform"
  deletion_protection = false 
  labels = {
    "environment": "Bigtable-terraform"
  }

  cluster {
    cluster_id = "bigtable-terraform-1"
    num_nodes = 1 
    storage_type = "SSD"
  }
}

resource "google_bigtable_table" "bigtable-terraform" {
  name = "bigtable-terraform"
  instance_name = google_bigtable_instance.bigtable-instance-terraform.name
}