#  Create Bucket
resource "google_storage_bucket" "function-terraform-bucket" {
  name = "function-terraform-bucket"
  location = " asia-northeast3"
}

# Upload index.zip 
resource "google_storage_bucket_object" "application-zip-terraform" {
  name = "index.zip"
  bucket = google_storage_bucket.cloud-storage-bucket-terraform.name
  source = "index.zip"
}

# Deploy Function
resource "google_cloudfunctions_function" "function-terraform-bucket" {
  name = "function-terraform-bucket-1"
  runtime = "nodejs14"
  description = "Google Cloudfunction with Terraform script"

  available_memory_mb =  128 
  source_archive_bucket = google_storage_bucket.function-terraform-bucket.name
  source_archive_object = google_storage_bucket_object.application-zip-terraform.name

  trigger_http = true 
  # Use an executable function from your code.
  entry_point = " helloworldtf" 
}

resource "google_cloudfunctions_function_iam_member" "allow-terraform-access" {
  region = google_cloudfunctions_function.function-terraform-bucket.region
  cloud_function = google_cloudfunctions_function.function-terraform-bucket.name

  role = "roles/cloudfunctions.invoker"
  member = "allUsers"
}