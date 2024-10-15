# EduMeet

## Lancer le backend

- Générer la base de données

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