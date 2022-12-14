### Folder structure

Root structure

```
├── app/                             - source code folders and files
├── test/                            - test folder
├── db/                              - migrations and db schema
├── config/                          - setup and environment
├── bin/                             - Rails default scripts
```

Source code structure (`app`)

```
├── controllers/                   - Rails default controllers folder
├── mailers/                       - Rails default mailers folder
├── mailers/                       - Rails default Active Record model folder
├── shared/                        - some shared value objects
├── views/                         - e-mail templates
├── contexts/                      - modules by domain, eg: invoice, identity
|	├── identity/
|	|	├── application/
|	|	├── domain/
|	|	├── infrastructure/
```

### How to run

Run in the local machine

```bash
bundle install
# then
rails db:migrate
# and
rails server
```

The server will start in the port 5000 (http://localhost:5000)

### Setup E-mail

Add an application.yml file to /config with the following variables

```yml
GMAIL_USERNAME: <gmail_username>
GMAIL_PASSOWRD: <gmail_app_password>
```

### Tests

Run tests

```bash
rails test
```
