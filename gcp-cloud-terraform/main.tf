# ==========================================Google Cloud Storage ===========================================
resource "google_storage_bucket" "cloud-storage-bucket-lubs" {
  name          = "terraform-gcp-bucket-1"
  location      = "asia-northeast3"
  storage_class = "STANDARD"
  force_destroy = true

  # How long u wish to keep the object.
  lifecycle_rule {
    condition {
      age = 1
    }
    action {
      type = "Delete"
    }
  }

  # Prevents the deletion or modification of the bucket's objects. 
  retention_policy {
    is_locked        = true
    retention_period = 86400
  }

  labels = {
    "env" = "terraform_dev_test"
    "dep" = "compliance"
  }

  # Used to create and manage managed folders in that bucket.
  uniform_bucket_level_access = true
}

# Adding Objects into a bucket.
resource "google_storage_bucket_object" "application_objects" {
  name   = "frontend_application"
  bucket = google_storage_bucket.cloud-storage-bucket-lubs.name
  source = "terraform.png"
}

# ======================================== NETWORK VPC ==================================================

# Auto network provisioned by google managed services.
resource "google_compute_network" "auto-vpc-network-terraform" {
  name = "auto-vpc-network"
  auto_create_subnetworks = true
}

#  Custom network
resource "google_compute_network" "custom-vpc-network-terraform" {
  name = "custom-vpc-network"
  auto_create_subnetworks = false
}

# Subnet configuartion for the custom network
resource "google_compute_subnetwork" "custom-subnet-terraform" {
  name = "custom-subnet-terraform"
  network = google_compute_network.custom-vpc-network-terraform.id 
  ip_cidr_range = "10.1.0.0/24"
  region = "asia-northeast3"
  private_ip_google_access = false
}

# Firewall rules for the project
resource "google_compute_firewall" "allow-icmp" {
  name = "allow-icmp"
  network = google_compute_network.custom-vpc-network-terraform.id
  allow {
    protocol = "icmp"
  }
  source_ranges = ["0.0.0.0/0"]
  priority = 455
}


# ============================================ Outputs ============================================================
# Output information for the networks
output "auto-output" {
  value = google_compute_network.auto-vpc-network-terraform.id
}

output "custom-output" {
  value = google_compute_network.custom-vpc-network-terraform.id
}
