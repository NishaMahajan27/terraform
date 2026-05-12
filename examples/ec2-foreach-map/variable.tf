variable "instances" {
  default = {
    BACKEND   = "t3.micro"
    FRONTEND  = "m7i-flex.large"
    DATABASES = "c7i-flex.large"
  }
}
