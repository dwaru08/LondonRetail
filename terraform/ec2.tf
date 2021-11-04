resource "aws_instance" "Jenkins_Server" {
  ami           = "ami-0a8e758f5e873d1c1"
  instance_type = "t2.micro"
  tags = {
    name = "Jenkins-Server"
  }
  subnet_id =aws_subnet.public_subnet.id
  security_groups = [aws_security_group.default.id]
/*

  provisioner "remote-exec" {
    connection {
      type = "ssh"
      user = "Ben, Nneka, Mani, root"
      host = aws_instance.Jenkins_Server.public_ip
      timeout = "10m"
    }
    inline = [<<EOF
      "wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -",
      "sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'",
      "sudo apt update",
      "sudo apt install jenkins",
      "sudo systemctl start jenkins",

      EOF
    ]
  }*/


}

resource "tls_private_key" "mykey" {
  algorithm = "RSA"
}


resource "aws_key_pair" "jenkins_key" {
  public_key = tls_private_key.mykey.public_key_openssh
}

/*output "key" {
  value = aws_key_pair.jenkins_key.public_key
}*/



resource "aws_instance" "web_server" {
  ami = "ami-0a8e758f5e873d1c1"
  instance_type = "t2.micro"
  tags = {
    name = "web-instance"
  }
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  subnet_id = aws_subnet.public_subnet.id
  associate_public_ip_address = true
  source_dest_check = false

}


resource "aws_instance" "mysql_db" {
  ami = "ami-0a8e758f5e873d1c1"
  instance_type = "t2.micro"
  tags = {
    name = "Database-instance"
  }
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  subnet_id = aws_subnet.private_subnet.id
  source_dest_check = false

}