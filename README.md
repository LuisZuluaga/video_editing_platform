# README

## Running Locally
🚀 Running the App Locally
1. Clone the repo
```
git clone https://github.com/LuisZuluaga/video_editing_platform.git
cd your-repo
```
2. Install dependencies
```
bundle install
```
3. Start Redis (required for background jobs with ActiveJob/Sidekiq)

# macOS (Homebrew)
```
brew services start redis
```
# Linux (Ubuntu)
```
sudo service redis-server start
```
To check if Redis is running:

```
redis-cli ping
```

# => PONG
4. Set up the database
```
bin/rails db:create db:migrate db:seed
```

5. Start the Rails server
```
rails server
```
6. Start the background job processor (Sidekiq or default async)
If you're using Sidekiq, run in a separate terminal:

```
bundle exec sidekiq
```
7. If you want to reset the database
```
bin/rails db:reset
```

## Database Diagram
<img width="1556" height="398" alt="Screenshot 2025-07-28 at 9 22 51 AM" src="https://github.com/user-attachments/assets/ae643490-38ca-4896-a767-5724766b8119" />
