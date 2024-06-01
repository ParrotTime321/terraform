variable "aws_access_key" {
    type = string
    default = "xxxxxx" // paste your aws key here

}

variable "aws_secret_key" {
    type = string
    default = "xxxxxx" // secret key
}

variable "aws_instance_type" {
    type = string
    default = "t3.micro" // instance type cna be changed
}

variable "aws_ami" {
  type = string
  default = "xxxxxx" // ami
}

variable "aws_key" {
  type = string
  default = "xxxxxx" // paste name of your ssh key here
}
