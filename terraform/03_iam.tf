// Role | policy attached to the glue jobs
resource "aws_iam_role" "lmu_glue" {
    name = "glue_lmu_role"
    assume_role_policy = file("./file/roles/glue_lmu_role.json")
}

// Inspired from AWSGlueServiceRole
resource "aws_iam_policy" "lmu_glue_policy" {
    name = "lmu_glue_policy"
    description = "A policy for the AWS Glue jobs"

    policy = file("./file/policies/glue_lmu.json")
}
    
resource "aws_iam_policy_attachment" "lmu_glue_policy" {
    name = "lmu_glue_policy_attachment"
    roles = [aws_iam_role.lmu_glue.name]
    policy_arn = aws_iam_policy.lmu_glue_policy.arn
}
