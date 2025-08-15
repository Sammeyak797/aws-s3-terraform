resource "aws_s3_bucket" "my_static_website" {
    bucket = var.bucket_name

    force_destroy = true
}

resource "aws_s3_bucket_website_configuration" "my_static_website_config" {
    bucket = aws_s3_bucket.my_static_website.id

    index_document {
        suffix = "index.html"
    }

    error_document {
        key = "index.html"
    }
}

resource "aws_s3_bucket_public_access_block" "public_access" {
    bucket = aws_s3_bucket.my_static_website.id

    block_public_acls = false
    block_public_policy = false
    ignore_public_acls = false
    restrict_public_buckets = false

}

resource "aws_s3_bucket_policy" "public_policy" {
    bucket = aws_s3_bucket.my_static_website.id 

    policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
        {
            Sid = "PublicReadGetObject"
            Effect = "Allow"
            Principal = "*"
            Action = "s3:GetObject"
            Resource = "${aws_s3_bucket.my_static_website.arn}/*"
        }
        ]
    })
}


