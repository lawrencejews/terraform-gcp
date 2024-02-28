resource "google_compute_instance" "serve-terraform" {
  name         = "serve-terraform"
  zone         = "asia-northeast3-a"
  machine_type = "n1-standard-1"
  # allow_stopping_for_update = true

  network_interface {
    network    = "custom-vpc-network-terraform"
    subnetwork = "custom-subnet-terraform"
  }

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      size  = 10
    }
  }

  scheduling {
    preemptible       = false
    automatic_restart = false
  }

  service_account {
    email  = "terraform-service-key@terraform-gcp-415411.iam.gserviceaccount.com"
    scopes = ["cloud-platform"]
  }

  lifecycle {
    ignore_changes = [ attached_disk ]
  }
}

# Disk resource to be attached on the instance
resource "google_compute_disk" "vm-terraform-disk" {
  name = "vm-terraform-disk"
  size = 10 
  zone = "asia-northeast3-a"
  type = "pd-ssd"
}

# Disk attached on the instance
resource "google_compute_attached_disk" "attach-vm-disk-terraform" {
  disk = google_compute_disk.vm-terraform-disk.id 
  instance = google_compute_instance.serve-terraform.id
}