# EduMeet

## Lancer le backend

- Générer la base de données ou après modification de schema faire

```sh
go generate ./ent
```

- Mode normal : 

```sh
go run .
```

- Executer les migrations BDD : 

```sh
go run . -mode=migrate
```

- Executer les fixtures 

```sh
go run . -mode=fixture
```

- Executer avec air pour le live reload

```sh
cd server && air
```