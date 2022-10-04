variable user {
  type        = string
}

variable project_id {
  type        = string
}

variable billing_account {
  type        = string
  default     = ""
}

variable folder_id {
  type        = string
  default     = ""
}

variable region {
  type        = string
  default     = "us-east1"
}

variable zone {
  type        = string
  default     = "us-east1-b"
}

variable labels {
  type        = map(string)
  default     = {}
}
