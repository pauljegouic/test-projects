resource "ibm_resource_instance" "kms" {
  name              = "${var.db_name}-kp"
  service           = "kms"
  plan              = "tiered-pricing"
  location          = var.region
  resource_group_id = data.ibm_resource_group.resource_group.id
  tags              = var.tags
}

resource "ibm_kms_key" "encryption_key" {
  instance_id    = ibm_resource_instance.kms.guid
  key_name       = "${var.db_name}-key"
  standard_key   = false
  force_delete   = true
}

resource "ibm_kms_key" "backup_encryption_key" {
  instance_id    = ibm_resource_instance.kms.guid
  key_name       = "${var.db_name}-key-backup"
  standard_key   = false
  force_delete   = true
}

resource "ibm_iam_authorization_policy" "policy" {
  source_service_name         = "databases-for-postgresql"
  target_service_name         = "kms"
  target_resource_instance_id = ibm_resource_instance.kms.guid
  roles                       = ["Reader"]
}
