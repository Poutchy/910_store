#!/bin/bash
set -e

# Wait for MySQL to be ready
until mysql -h localhost -u root -p"${MYSQL_ROOT_PASSWORD}" -e "SELECT 1;" &> /dev/null
do
  echo "Waiting for MySQL..."
  sleep 2
done

echo "✅ MySQL is up - creating databases and users..."

mysql -u root -p"${MYSQL_ROOT_PASSWORD}" <<-EOSQL
  CREATE USER IF NOT EXISTS '${DB_USERNAME}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
  CREATE USER IF NOT EXISTS 'store'@'%' IDENTIFIED BY '${STORE_DATABASE_PASSWORD}';

  CREATE DATABASE IF NOT EXISTS store_development;
  CREATE DATABASE IF NOT EXISTS store_test;
  CREATE DATABASE IF NOT EXISTS store_production;
  CREATE DATABASE IF NOT EXISTS store_production_cache;
  CREATE DATABASE IF NOT EXISTS store_production_queue;
  CREATE DATABASE IF NOT EXISTS store_production_cable;

  GRANT ALL PRIVILEGES ON store_development.* TO '${DB_USERNAME}'@'%';
  GRANT ALL PRIVILEGES ON store_test.* TO '${DB_USERNAME}'@'%';
  GRANT ALL PRIVILEGES ON store_production.* TO 'store'@'%';
  GRANT ALL PRIVILEGES ON store_production_cache.* TO 'store'@'%';
  GRANT ALL PRIVILEGES ON store_production_queue.* TO 'store'@'%';
  GRANT ALL PRIVILEGES ON store_production_cable.* TO 'store'@'%';

  FLUSH PRIVILEGES;
EOSQL

echo "✅ Databases and users ready!"
