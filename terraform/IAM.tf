resource "aws_iam_user" "lr_users" {
  count = length(var.username)
  name = element(var.username,count.index )
}

resource "aws_iam_user_policy" "lr_default_policy" {
  count = length(var.username)
  user = element(var.username,count.index)
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ec2:*"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_user_login_profile" "lr_login_profile" {
  count = length(var.username)
  user = element(var.username,count.index)
  pgp_key = "keybase:user"
}

/*output "password" {
  count=length(var.username)
  value = aws_iam_user_login_profile.lr_login_profile.encrypted_password
}*/