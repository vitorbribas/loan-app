# Loan App

## Dependências
- Ruby >= 3.1.4
- Docker

## Iniciando a aplicação

1. Suba os serviços que servem à aplicação principal:

```
docker-compose up -d
```

2. Inicie o banco de dados:
```
rails db:setup
```

3. Inicie a aplicação principal (API):
```
rails s
```

4. Envie requisições de simulação de propostas:

```
curl --request POST \
  --url http://localhost:3000/api/v1/proposals \
  --header 'Content-Type: application/json' \
  --data '{
	"proposal": {
		"amount": 200000.0,
		"payment_term": 62,
		"birthdate": "11/11/1983",
		"email": "bsbribas66@gmail.com"
	}
}'
```

## Tracking de e-mails

Acesse a URL [localhost:8025](localhost:8025) para visualizar os e-mails recebidos em ambiente local com o auxílio do [Mailhog](https://github.com/mailhog/MailHog)

## Execução dos testes unitários

Execute a bateria de testes unitários implementados com Rspec:

```
bundle exec rspec
```

## Execução do linter

Execute o linter Rubocop para checar e garantir a consistência do código:

```
bundle exec rubocop
```