# Prisma & TS POC
## Description
This is a POC to learn how to use Prisma with TypeScript. This is not deployed and as such is not intended for production use. This is a learning project.

As it stands you are able to create a menu, which will contain menu groups (categories). These categories will include items. You are able to update the order of the menu groups to adjust how they will show in the menu, and you can add items to a menu group. Removal is not yet implemented. 

## Installation
1. Clone the repository
2. Run `npm install`
3. Setup .env file with the following:
```
DATABASE_URL="postgresql://<username>:<password>@localhost:5432/<database>"
```
4. Setup Postgres database by running `docker-compose up -d` (remember to change the username & password in the docker-compose file)
5. Run `npm run migrate` or `npm run db:push` to create the database and tables
6. Run `npm run start`
7. Server will be running on `http://localhost:3000`
