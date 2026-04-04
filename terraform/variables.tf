variable "tenancy_ocid" {
  description = "OCI tenancy OCID"
  type        = string
}

variable "user_ocid" {
  description = "OCI user OCID"
  type        = string
}

variable "compartment_ocid" {
  description = "OCI compartment OCID"
  type        = string
}

variable "fingerprint" {
  description = "API key fingerprint"
  type        = string
}

variable "private_key_path" {
  description = "Path to OCI API private key"
  type        = string
}

variable "region" {
  description = "OCI region identifier"
  type        = string
}

variable "image_ocid" {
  description = "OCI image OCID"
  type        = string
}

variable "prefix" {
  description = "Resource name prefix"
  type        = string
  default     = "oracle19c-pdb-lab"
}

variable "vcn_cidr" {
  description = "VCN CIDR block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr" {
  description = "Subnet CIDR block"
  type        = string
  default     = "10.0.1.0/24"
}

variable "admin_cidr" {
  description = "Allowed admin source CIDR"
  type        = string
}

variable "vcn_dns_label" {
  description = "DNS label for VCN"
  type        = string
  default     = "pdbvcn"
}

variable "subnet_dns_label" {
  description = "DNS label for subnet"
  type        = string
  default     = "publicsub"
}

variable "shape" {
  description = "Compute instance shape"
  type        = string
  default     = "VM.Standard.E4.Flex"
}

variable "ocpus" {
  description = "Number of OCPUs"
  type        = number
  default     = 1
}

variable "memory_in_gbs" {
  description = "Memory size in GB"
  type        = number
  default     = 8
}

variable "boot_volume_size_in_gbs" {
  description = "Boot volume size in GB"
  type        = number
  default     = 100
}