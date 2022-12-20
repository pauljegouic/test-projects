data "ibm_is_vpc" "vpc" {
  name = var.vpc_name
}

data "ibm_resource_group" "resource_group" {
  name       = (var.resource_group != null ? var.resource_group : null)
  is_default = (var.resource_group == null ? true : null)
}

resource "ibm_database" "db_postgresql" {
  resource_group_id                    = data.ibm_resource_group.resource_group.id
  name                                 = var.db_name
  service                              = "databases-for-postgresql"
  plan                                 = "standard"
  location                             = var.region
  version                              = (var.database_version != null ? var.database_version : null)
  group {
    group_id = "member"
    memory { 
      allocation_mb = var.memory_allocation
    }

    disk { 
      allocation_mb = var.disk_allocation 
    }

    cpu {
      allocation_count = var.cpu_allocation
    }
  }
  service_endpoints                    = "private"
  key_protect_instance                 = ibm_resource_instance.kms.guid
  key_protect_key                      = ibm_kms_key.encryption_key.crn
  backup_encryption_key_crn            = ibm_kms_key.backup_encryption_key.crn
  tags                                 = (var.tags != null ? var.tags : [])

  dynamic "whitelist" {
    for_each = data.ibm_is_vpc.vpc.cse_source_addresses.*.address
    content {
      address     = format("%s/32", whitelist.value)
      description = whitelist.value
    }
  }
  auto_scaling {
    cpu {
      rate_increase_percent       = (var.cpu_rate_increase_percent != null ? var.cpu_rate_increase_percent : null)
      rate_limit_count_per_member = (var.cpu_rate_limit_count_per_member != null ? var.cpu_rate_limit_count_per_member : null)
      rate_period_seconds         = (var.cpu_rate_period_seconds != null ? var.cpu_rate_period_seconds : null)
      rate_units                  = (var.cpu_rate_units != null ? var.cpu_rate_units : null)
    }
    disk {
      capacity_enabled             = (var.disk_capacity_enabled != null ? var.disk_capacity_enabled : null)
      free_space_less_than_percent = (var.disk_free_space_less_than_percent != null ? var.disk_free_space_less_than_percent : null)
      io_above_percent             = (var.disk_io_above_percent != null ? var.disk_io_above_percent : null)
      io_enabled                   = (var.disk_io_enabled != null ? var.disk_io_enabled : null)
      io_over_period               = (var.disk_io_over_period != null ? var.disk_io_over_period : null)
      rate_increase_percent        = (var.disk_rate_increase_percent != null ? var.disk_rate_increase_percent : null)
      rate_limit_mb_per_member     = (var.disk_rate_limit_mb_per_member != null ? var.disk_rate_limit_mb_per_member : null)
      rate_period_seconds          = (var.disk_rate_period_seconds != null ? var.disk_rate_period_seconds : null)
      rate_units                   = (var.disk_rate_units != null ? var.disk_rate_units : null)
    }
    memory {
      io_above_percent         = (var.memory_io_above_percent != null ? var.memory_io_above_percent : null)
      io_enabled               = (var.memory_io_enabled != null ? var.memory_io_enabled : null)
      io_over_period           = (var.memory_io_over_period != null ? var.memory_io_over_period : null)
      rate_increase_percent    = (var.memory_rate_increase_percent != null ? var.memory_rate_increase_percent : null)
      rate_limit_mb_per_member = (var.memory_rate_limit_mb_per_member != null ? var.memory_rate_limit_mb_per_member : null)
      rate_period_seconds      = (var.memory_rate_period_seconds != null ? var.memory_rate_period_seconds : null)
      rate_units               = (var.memory_rate_units != null ? var.memory_rate_units : null)
    }
  }
}

resource "ibm_container_bind_service" "bind_postgresql" {
  for_each = toset(var.namespaces)
  cluster_name_id       = var.vpc_cluster_name
  service_instance_name = var.db_name
  resource_group_id = data.ibm_resource_group.resource_group.id
  namespace_id          = each.key
}