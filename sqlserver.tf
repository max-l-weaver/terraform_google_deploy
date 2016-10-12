resource "google_compute_instance" "sqlserver" {

	name = "mysql-server-001"
	machine_type = "n1-highmem-2"
	zone = "${var.zone}"

	tags = ["database", "mysql"]

	disk {

		image = "${var.main_image}"
		size = 120
	}

	network_interface {
		network = "default"

		access_config {	
		// Ephemeral IP
		}
	}

	service_account {
		scopes = ["https://www.googleapis.com/auth/compute.readonly"]
	}

	metadata {
		ssh-keys = "root:${file("${var.public_key_path}")}"
	}
	
}