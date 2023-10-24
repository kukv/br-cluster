packer {
	required_plugins {
		ansible = {
			version = ">=1.1.0"
			source  = "github.com/hashicorp/ansible"
		}
	}
}

build {
	sources = ["source.arm.ubuntu_rpi"]

	#################################################################
	# cloud-init
	#################################################################
	provisioner "file" {
		sources = var.cloud_init_include_files
		destination = "/boot/firmware/"
	}

	#################################################################
	# ansible provisioning
	#################################################################
	provisioner "shell" {
		inline = [
			"mv /etc/resolv.conf /etc/resolv.conf.bk",
			"echo 'nameserver 8.8.8.8' > /etc/resolv.conf"
		]
	}

	provisioner "ansible" {
		inventory_file_template = "default ansible_host=/tmp/rpi_chroot ansible_connection=chroot\n"
		playbook_file = "/build/ansible/${var.hostname}.yml"
		extra_arguments = [ "-vvvv" ]
	}
}
