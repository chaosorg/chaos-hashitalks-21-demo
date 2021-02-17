output "master_ip_address" {
  value = aws_instance.master_cluster.public_ip
}