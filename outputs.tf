output "container_ssh" {
  value = {
    container_name = docker_container.ubuntu.name
    ip_address     = docker_container.ubuntu.network_data[0].gateway
    ssh_status     = "Verify SSH by running: ssh root@${docker_container.ubuntu.network_data[0].gateway} -p 2222"
  }
}