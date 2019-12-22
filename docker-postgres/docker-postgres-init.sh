docker run --name docker-postgres -v /apps/home/postgres/data:/var/lib/postgresql/data -p 5432:5432 -e POSTGRES_PASSWORD=mysecretpassword -d postgres:latest
