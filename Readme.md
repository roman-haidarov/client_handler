# Get started
### Start the Application and Database Containers
```sh
docker compose -f docker-compose.yml up --build
```

### Create Database and Run Migrations
Run the following command in a separate terminal inside the project directory:
```sh
docker-compose exec app bundle exec bash
RACK_ENV=development bundle exec rake db:migrate
```

---

## Troubleshooting

### Issues with Ruby Version Changes
If you encounter issues due to a Ruby version change, run the following command for a clean installation:
```sh
docker-compose down --rmi all --volumes --remove-orphans
```
