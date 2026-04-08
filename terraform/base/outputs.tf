output "vm1_id" {
  value = oci_core_instance.vm1.id
}

output "vm2_id" {
  value = oci_core_instance.vm2.id
}

output "subnet_id" {
  value = oci_core_subnet.public.id
}

output "vcn_id" {
  value = oci_core_vcn.main.id
}
