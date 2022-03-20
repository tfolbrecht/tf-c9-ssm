resource "aws_cloud9_environment_ec2" "cloud9ssm" {
  instance_type               = "t2.micro"
  name                        = "cloud9ssm"
  automatic_stop_time_minutes = 5
  connection_type             = "CONNECT_SSM"
  image_id                    = "ubuntu-18.04-x86_64"
  tags = {
    Environment = "Experiment"
  }
}

data "aws_instance" "cloud9_instance" {
  filter {
    name = "tag:aws:cloud9:environment"
    values = [
    aws_cloud9_environment_ec2.cloud9ssm.id]
  }
}

resource "aws_ssm_association" "install-code-server-association" {
  name = aws_ssm_document.install-code-server.name

  targets {
    key    = "InstanceIds"
    values = [data.aws_instance.cloud9_instance.id]
  }
}

resource "aws_ssm_document" "install-code-server" {
  name            = "install-code-server"
  document_format = "YAML"
  document_type   = "Command"
  content = file("./run-command/install-code-server.yml")
}