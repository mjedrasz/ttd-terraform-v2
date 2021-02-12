variable "delay_seconds" {
  description = "Delay in seconds"
  default     = 0
}

variable "max_message_size" {
  description = "Max message size"
  default     = 262144 #256kB
}

variable "message_retention_seconds" {
  description = "Message retention in seconds"
  default     = 345600 #4 days
}

variable "receive_wait_time_seconds" {
  description = "Receive wait time in seconds"
  default     = 0
}

variable "redrive_policy" {
  description = "Redrive policy"
  default     = ""
}

variable "fifo_queue" {
  description = "Is FIFO queue?"
  default     = false
}

variable "content_based_deduplication" {
  description = "Content based deduplication"
  default     = false
}

