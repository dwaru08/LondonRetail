resource "aws_instance" "Jenkins_Server" {
  ami           = "ami-0a8e758f5e873d1c1"
  instance_type = "t2.micro"
  subnet_id =aws_subnet.public_subnet.id
  security_groups = [aws_security_group.default.id]
  }