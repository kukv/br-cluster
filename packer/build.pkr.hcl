source "arm" "ubuntu_rpi" {
	file_urls             = ["https://cdimage.ubuntu.com/releases/23.04/release/ubuntu-23.04-preinstalled-server-arm64+raspi.img.xz"]
	file_checksum_url     = "http://cdimage.ubuntu.com/releases/23.04/release/SHA256SUMS"
	file_checksum_type    = "sha256"
	file_target_extension = "xz"
	file_unarchive_cmd    = ["xz", "--decompress", "$ARCHIVE_PATH"]
	image_build_method    = "reuse"
	image_path            = "/build/generated/${var.hostname}.img"
	image_size            = "3.1G"
	image_type            = "dos"
	image_partitions {
		name         = "boot"
		type         = "c"
		start_sector = "2048"
		filesystem   = "fat"
		size         = "256M"
		mountpoint   = "/boot/firmware"
	}
	image_partitions {
		name         = "root"
		type         = "83"
		start_sector = "526336"
		filesystem   = "ext4"
		size         = "0"
		mountpoint   = "/"
	}
	image_chroot_env             = ["PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin"]
	qemu_binary_source_path      = "/usr/bin/qemu-aarch64-static"
	qemu_binary_destination_path = "/usr/bin/qemu-aarch64-static"
}

build {
	sources = ["source.arm.ubuntu_rpi"]

	#################################################################
	# cloud-init configuration
	#################################################################
	provisioner "file" {
		sources = var.cloud_init_include_files
		destination = "/boot/firmware/"
	}
}
