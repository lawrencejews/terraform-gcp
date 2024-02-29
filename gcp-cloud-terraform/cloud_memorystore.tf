resource "google_redis_instance" "redis-instance-terraform" {
  name = "redis-instance-terraform"
  memory_size_gb = 1 
  tier = "BASIC"

  location_id = "asia-northeast3"
  authorized_network = "default"

  redis_version = "REDIS_5_0"
}