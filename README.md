# pgenv1

Среда для тестирования работы конфигураций 1С:Предприятие и PostgreSQL.

Включает в себя:
* PostgreSQL с патчами фирмы 1С (сборка от [Postgres Professionals](https://postgrespro.ru/products/1c_build))
* Средства администрирования:
    * [PostgreSQL Studio](http://www.postgresqlstudio.org/)
    * [pgAdmin4 (beta)](https://www.pgadmin.org/)
* Средства анализа
    * [POWA](http://dalibo.github.io/powa/)
    * [pgBadger](https://github.com/dalibo/pgbadger)

## Развертывание

1. Устанавливаем [Vagrant](https://www.vagrantup.com/)
2. Устанавливаем плагин *vagrant-docker-compose*   
   
        vagrant plugin install vagrant-docker-compose
   
3. Запускаем

        vagrant up

4. Открываем [стартовую страницу](http://localhost:8080)

Анализ логов при помощи pgBadger происходит при запуске соответсвующего контейнера.
Перезапустить контейнер вручную можно выполнив команду ```docker-compose restart pgbadger```.