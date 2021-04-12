locals {
  # Sort environment variables so terraform will not try to recreate on each plan/apply
  env_vars_keys        = var.map_environment != null ? keys(var.map_environment) : []
  env_vars_values      = var.map_environment != null ? values(var.map_environment) : []
  env_vars_as_map      = zipmap(local.env_vars_keys, local.env_vars_values)
  sorted_env_vars_keys = sort(local.env_vars_keys)

  sorted_environment_vars = [
  for key in local.sorted_env_vars_keys :
  {
    name  = key
    value = lookup(local.env_vars_as_map, key)
  }
  ]

  # Sort secrets so terraform will not try to recreate on each plan/apply
  secrets_keys        = var.map_secrets != null ? keys(var.map_secrets) : []
  secrets_values      = var.map_secrets != null ? values(var.map_secrets) : []
  secrets_as_map      = zipmap(local.secrets_keys, local.secrets_values)
  sorted_secrets_keys = sort(local.secrets_keys)

  sorted_secrets_vars = [
  for key in local.sorted_secrets_keys :
  {
    name      = key
    valueFrom = lookup(local.secrets_as_map, key)
  }
  ]

  mount_points = length(var.mount_points) > 0 ? [
  for mount_point in var.mount_points : {
    containerPath = lookup(mount_point, "containerPath")
    sourceVolume  = lookup(mount_point, "sourceVolume")
    readOnly      = tobool(lookup(mount_point, "readOnly", false))
  }
  ] : var.mount_points

  final_environment_vars = length(local.sorted_environment_vars) > 0 ? local.sorted_environment_vars : null
  final_secrets_vars     = length(local.sorted_secrets_vars) > 0 ? local.sorted_secrets_vars : null

  log_configuration = {
    logDriver = "awslogs"
    options   = {
      "awslogs-group": var.log_group,
      "awslogs-region": "eu-north-1",
      "awslogs-stream-prefix": "ecs"
    }
  }

  container_definition = {
    name             = var.container_name
    image            = var.container_image
    essential        = var.essential
    entryPoint       = var.entrypoint
    command          = var.command
    workingDirectory = var.working_directory
    mountPoints      = local.mount_points
    dependsOn        = var.container_depends_on
    portMappings     = var.port_mappings
    logConfiguration = local.log_configuration
    memory           = var.container_memory
    cpu              = var.container_cpu
    environment      = local.final_environment_vars
    secrets          = local.final_secrets_vars
  }

  json_map = jsonencode(local.container_definition)
}