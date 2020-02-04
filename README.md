# Read Me

Voilà mon travail.

## Utilisation

``` sh
docker-compose build
docker-compose run rake db:setup
docker-compose bundle exec rails webpacker:install
docker-compose run web rake spec
docker-compose up
```

L'appli est accessible à `http://0.0.0.0:5000`

Le moniteur RabbitMQ à`http://0.0.0.0:8080` (login/pass : `guest/guest`)

## Remarques
* J'ai préféré appeler le modèle `Trip`. Par expérience, je préfère coder rails en
 anglais à cause des règles d'inflexion.
* Idéalement, il faudrait un modèle `Status` avec un code et une description
  pour les vues, mais je suis resté simple de ce côté-là, je réponds aux specs.
* Quand on annule un trajet, j'ai redirigé vers l'accueil... Je ne sais pas si
  c'est ce qui était demandé. Mais ça me paraissait logique. De toutes façons,
  l'état est visible dans la liste en index.
* Tout n'est pas traduit, et/ou parfois c'est un peu à l'arrache de ce côté-là.
  J'ai préféré me concentrer sur le code ruby.
* J'ai fait aussi une petite UI avec semantic-ui
* Les vues ne sont pas testées à 100%, par manque de temps
