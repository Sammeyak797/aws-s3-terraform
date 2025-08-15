output "website_url" {
    value               = aws_s3_bucket_website_configuration.my_static_website_config.website_endpoint
    description          = "The URL of the static website"
}