variable "resource_group" {
  type        = string
  description = "Resource Group Name"
}
variable "vpc_name" {
  type        = string
  description = "VPC Name. Used to get the IP filters of your VPC."
}
variable "db_name" {
  type        = string
  description = "Resource instance name for example 'my-pg-database'"
}
variable "region" {
  type        = string
  default     = "eu-fr2"
  description = "The location or the region in which Database instance exists"
}
variable "database_version" {
  default     = null
  type        = string
  description = "The database version to provision if specified, latest if not specified. Warning."
}
variable "memory_allocation" {
  default     = 1024
  type        = number
  description = "Memory allocation required for database"
}
variable "disk_allocation" {
  default     = 61440
  type        = number
  description = "Disk allocation required for database"
}
variable "cpu_allocation" {
  default     = 0
  type        = number
  description = "CPU allocation required for database"
}
variable "service_endpoints" {
  default     = null
  type        = string
  description = "Types of the service endpoints. Possible values are 'public', 'private', 'public-and-private'."
}
variable "backup_id" {
  default     = null
  type        = string
  description = "The CRN of backup source database"
}
variable "tags" {
  default     = null
  type        = set(string)
  description = "Tags for the database"
}

variable "cpu_rate_increase_percent" {
  default     = null
  type        = number
  description = "Auto Scaling CPU Rate: Increase Percent"
}
variable "cpu_rate_limit_count_per_member" {
  default     = null
  type        = number
  description = "Auto Scaling CPU Rate: Limit count per number"
}
variable "cpu_rate_period_seconds" {
  default     = null
  type        = number
  description = "Auto Scaling CPU Rate: Period Seconds"
}
variable "cpu_rate_units" {
  default     = null
  type        = string
  description = "Auto Scaling CPU Rate: Units "
}
variable "disk_capacity_enabled" {
  default     = null
  type        = bool
  description = "Auto Scaling Disk Scalar: Capacity Enabled"
}
variable "disk_free_space_less_than_percent" {
  default     = null
  type        = number
  description = "Auto Scaling Disk Scalar: Capacity Free Space Less Than Percent"
}
variable "disk_io_above_percent" {
  default     = null
  type        = number
  description = "Auto Scaling Disk Scalar: IO Utilization Above Percent"
}
variable "disk_io_enabled" {
  default     = null
  type        = bool
  description = "Auto Scaling Disk Scalar: IO Utilization Enabled"
}
variable "disk_io_over_period" {
  default     = null
  type        = string
  description = "Auto Scaling Disk Scalar: IO Utilization Over Period"
}
variable "disk_rate_increase_percent" {
  default     = null
  type        = number
  description = "Auto Scaling Disk Rate: Increase Percent"
}
variable "disk_rate_limit_mb_per_member" {
  default     = null
  type        = number
  description = "Auto Scaling Disk Rate: Limit mb per member"
}
variable "disk_rate_period_seconds" {
  default     = null
  type        = number
  description = "Auto Scaling Disk Rate: Period Seconds"
}
variable "disk_rate_units" {
  default     = null
  type        = string
  description = "Auto Scaling Disk Rate: Units "
}
variable "memory_io_above_percent" {
  default     = null
  type        = number
  description = "Auto Scaling Memory Scalar: IO Utilization Above Percent"
}
variable "memory_io_enabled" {
  default     = null
  type        = bool
  description = "Auto Scaling Memory Scalar: IO Utilization Enabled"
}
variable "memory_io_over_period" {
  default     = null
  type        = number
  description = "Auto Scaling Memory Scalar: IO Utilization Over Period"
}
variable "memory_rate_increase_percent" {
  default     = null
  type        = number
  description = "Auto Scaling Memory Rate: Increase Percent"
}
variable "memory_rate_limit_mb_per_member" {
  default     = null
  type        = number
  description = "Auto Scaling Memory Rate: Limit mb per member"
}
variable "memory_rate_period_seconds" {
  default     = null
  type        = number
  description = "Auto Scaling Memory Rate: Period Seconds"
}
variable "memory_rate_units" {
  default     = null
  type        = string
  description = "Auto Scaling Memory Rate: Units "
}

variable vpc_cluster_name {
  type        = string
  default     = null
  description = "Name of the cluster where you want to bind your postgreSQL service"
}
variable namespaces {
  type        = list(string)
  default     = []
  description = "Namespace where the secret bind service will be deployed to"
}