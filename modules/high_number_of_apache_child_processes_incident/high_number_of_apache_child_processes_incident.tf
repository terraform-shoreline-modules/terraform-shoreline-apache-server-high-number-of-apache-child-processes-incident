resource "shoreline_notebook" "high_number_of_apache_child_processes_incident" {
  name       = "high_number_of_apache_child_processes_incident"
  data       = file("${path.module}/data/high_number_of_apache_child_processes_incident.json")
  depends_on = [shoreline_action.invoke_edit_apache_max_connections]
}

resource "shoreline_file" "edit_apache_max_connections" {
  name             = "edit_apache_max_connections"
  input_file       = "${path.module}/data/edit_apache_max_connections.sh"
  md5              = filemd5("${path.module}/data/edit_apache_max_connections.sh")
  description      = "Reduce the number of processes by limiting the number of concurrent connections that can be made to Apache."
  destination_path = "/agent/scripts/edit_apache_max_connections.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_edit_apache_max_connections" {
  name        = "invoke_edit_apache_max_connections"
  description = "Reduce the number of processes by limiting the number of concurrent connections that can be made to Apache."
  command     = "`chmod +x /agent/scripts/edit_apache_max_connections.sh && /agent/scripts/edit_apache_max_connections.sh`"
  params      = ["MAX_CONNECTIONS"]
  file_deps   = ["edit_apache_max_connections"]
  enabled     = true
  depends_on  = [shoreline_file.edit_apache_max_connections]
}

