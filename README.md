# pgenv1

Среда для тестирования работы конфигураций 1С:Предприятие и PostgreSQL.

Включает в себя:
* PostgreSQL с патчами фирмы 1С (сборка от [Postgres Professionals](https://postgrespro.ru/products/1c_build))
* Средства администрирования:
    * [PostgreSQL Studio](http://www.postgresqlstudio.org/)
    * [pgAdmin4 (beta)](https://www.pgadmin.org/)
* Средства анализа
    * [POWA](http://dalibo.github.io/powa/)

## Развертывание

* Установить [Vagrant](https://www.vagrantup.com/)
* Установить плагин *vagrant-docker-compose*
    ```
    vagrant plugin install vagrant-docker-compose
    ```
* Запускаем
    ```
    vagrant up
    ```
