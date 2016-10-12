provider "google" {
	region = "${var.region}"
	credentials = "${file("${var.credentials_file_path}")}"
	project = "${var.project_name}"
}

resource "google_compute_http_health_check" "default" {
	name = "tf-www-basic-check"
	request_path = "/"
	check_interval_sec = 1
	healthy_threshold = 1
	unhealthy_threshold = 10
	timeout_sec = 1
}

resource "google_compute_target_pool" "default" {
	name = "tf-default-target-pool"
	instances = ["${google_compute_instance.default.*.self_link}"]
	health_checks = ["${google_compute_http_health_check.default.name}"]
}

resource "google_compute_forwarding_rule" "default" {
	name = "tf-default-forwarding-rule"
	target = "${google_compute_target_pool.default.self_link}"
	port_range = "80"
}

resource "google_compute_firewall" "default" {
	name = "main-test-fw"
	network = "default"

	 allow {
	 	protocol = "tcp"
	 	ports = ["80"]
	 }

	 source_ranges = ["0.0.0.0/0"]
	 target_tags = ["www-node"]

}

resource "google_compute_instance" "default" {
	count = 3

	name = "main-server-${count.index + 1}"
	machine_type = "n1-standard-1"
	zone = "${var.zone}"
	tags = ["main", "test"]

	disk {
		image = "ubuntu-os-cloud/ubuntu-1604-xenial-v20160930"
		size = 100
		type = "pd-standard"

	}

	network_interface {
		network = "default"

		access_config {
			// Ephemeral IP
		}
	}

	metadata {
		ssh-keys = "root:${file("${var.public_key_path}")}"
	}

	service_account {
		scopes = ["https://www.googleapis.com/auth/compute.readonly"]
	}


	
}
