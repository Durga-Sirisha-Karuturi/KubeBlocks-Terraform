output "backup_repo_status" {

  value = var.enable_backup ? try(
    data.kubernetes_resource.backuprepo[0].object.status.phase,
    "Not Ready"
  ) : "Backup Disabled"
}

output "backup_repo_name" {

  value = var.enable_backup ? try(
    data.kubernetes_resource.backuprepo[0].object.metadata.name,
    "Unknown"
  ) : "Backup Disabled"
}
