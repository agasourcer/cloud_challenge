provider "google" {
  project = "kinetic-anvil-400904"
  region  = "us-central1"
  zone    = "us-central1-c"
}

resource "google_compute_instance" "dare-id-vm" {
  name         = "dareit-vm-tf"
  machine_type = "e2-medium"
  zone         = "us-central1-a"

  tags = ["dareit"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      labels = {
        managed_by_terraform = "true"
      }
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral public IP
    }
  }
}

resource "google_storage_bucket" "auto-expire" {
  name    = "aga-cloud-storage"
  location      = "US"
  force_destroy = true
}

resource "google_sql_database_instance" "main" {
  name             = "aga-sql-instance"
  database_version = "POSTGRES_15"
  region           = "us-central1"

  settings {
    tier = "db-f1-micro"
    }
}  

resource "google_sql_database" "database" {
  name     = "dareit"
  instance = google_sql_database_instance.instance.name
}

resource "google_sql_user" "users" {
  name     = "dareit_user"
  instance = google_sql_database_instance.main.name
  password = "passwordchanged"
}



                                                                                                                                                                                                                                                                                                                    10,16         Top