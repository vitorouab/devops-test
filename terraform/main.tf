# Add this data source to get current AWS account ID
data "aws_caller_identity" "current" {}

# Update IAM Role Resource
resource "aws_iam_role" "ec2_role" {
  name = "ec2_ecr_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
      # Add this to allow the IAM user to assume the role
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/github-action-user"
        }
      }
    ]
  })
}

# Add explicit GetRole permission
resource "aws_iam_role_policy" "get_role_policy" {
  name = "GetRolePolicy"
  role = aws_iam_role.ec2_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "iam:GetRole",
          "iam:GetInstanceProfile"
        ]
        Effect   = "Allow"
        Resource = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/ec2_ecr_role"
      }
    ]
  })
}