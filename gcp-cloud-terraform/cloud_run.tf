# resource "google_cloud_run_service" "run-terraform-app" {
#   name     = " run-terraform-app "
#   location = " asia-northeast3 "

#   template {
#     spec {
#       containers {
#         image = "lawrencejews/cinema-aws-terraform-db:development-146"
#         # image = "us-docker.pkg.dev/cloudrun/container/hello"
#       }
#     }
#   }

# }

# resource "google_cloud_run_service_iam_policy" "public-access-terraform" {
#   service = google_cloud_run_service.run-terraform-app.name
#   location = google_cloud_run_service.run-terraform-app.location
#   policy_data = data.google_iam_policy.public-data-terraform
# }

# data "google_iam_policy" "public-data-terraform" {
#   binding {
#     role = "roles/run.invoker"
#     members = ["allUsers"]
#   }
# }