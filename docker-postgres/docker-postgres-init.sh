docker run --name docker-postgres -v /apps/home/postgres/data:/var/lib/postgresql/data -e POSTGRES_PASSWORD=mysecretpassword -d postgres:latest
