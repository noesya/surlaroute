# Sur la route


Ce projet s'appuie sur un fork de l'[écothèque](https://github.com/noesya/ecotheque)
## Setup

### Pré-requis

- ElasticSearch (voir la [doc](https://docs.ecotheque.fr/docs/recherche/))

### Récupération du projet

```
git clone git@github.com:noesya/surlaroute.git
cd surlaroute
bin/setup
```

Ensuite, remplir le fichier .env avec les infos secrètes.

En cas d'erreur `Asset application.css was not declared to be precompiled`, vider le cache local avec `rails tmp:cache:clear`
