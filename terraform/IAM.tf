resource "aws_iam_user" "lr_users" {
  count = length(var.username)
  name = element(var.username,count.index )
}

resource "aws_iam_policy" "lr_default_policy" {
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

resource "aws_iam_group" "lr_developers" {
  name = "lr_developers"
  path = "/users/"
}

resource "aws_iam_policy_attachment" "lr_attach" {
  name = "lr_attach"
  groups     = [aws_iam_group.lr_developers.name]
  policy_arn = aws_iam_policy.lr_default_policy.arn
}

resource "aws_iam_group_membership" "group_mem" {
  name = "lr_group_membership"
  users = var.username
  group = aws_iam_group.lr_developers.name
}

/*resource "aws_iam_user_login_profile" "lr_login_profile" {
  count = length(var.username)
  user = element(var.username,count.index)
  pgp_key = aws_iam_access_key.lr_access_key.pgp_key
  password_reset_required = true
}*/

resource "aws_iam_access_key" "lr_access_key" {
  count = length(var.username)
  user = element(var.username,count.index)
  pgp_key = "keybase:user"
}

output "access_key" {
  value = aws_iam_access_key.lr_access_key[*].id

}
output "encrypted_secret" {
  value = aws_iam_access_key.lr_access_key[*].encrypted_secret
}

output "encrypted_password" {
  value =  aws_iam_access_key.lr_access_key[*].encrypted_ses_smtp_password_v4
}


/*for user in aws_iam_user.lr_users :
user.name => {
access_key         = aws_iam_access_key.[user.name].id,
encrypted_secret   = aws_iam_access_key.user[user.name].encrypted_secret,
encrypted_password = aws_iam_user_login_profile.user[user.name].encrypted_password,
}*/
