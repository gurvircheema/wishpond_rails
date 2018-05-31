# Small Ruby on Rails for Wishpond

This app uses rails 5.2. This is so that we can use `activestorage` functionality added in this rails version to upload and store images.

# Setup

```shell
gem install rails -v 5.2
rails -v # should show 5.2
cd /wishpond_rails # if you are not currently in this directory
bundle install
rails db:create
rails db:migrate
rails s
```

### Notes

This app use `ruby 2.5.1`

For production deployment, please replace `config/credentials.yml.enc` with your own credentials file. Make sure your credentials file has aws_access_key, aws_secret_key, region and bucket name
