terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.51.0"
    }
  }

}

#  Provider Configuration Option
provider "google" {
  project     = "terraform-gcp-415411"
  region      = "asia-northeast3"
  zone        = " asia-northeast3-a	"
  credentials = "terraform-gcp-415411-4f3aca0a89f0.json"
}

