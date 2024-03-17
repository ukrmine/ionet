# Скрипт для моніторингу та перезапуску воркера IO.NET 
на базі Linux Ubuntu 20.04

Ви маєте бути під користувачем root (рядок в консолі має починатися з root)

![Image alt](https://github.com/ukrmine/ionet/blob/main/pics/1root.png)

Переходимо до папки root
<!--sec data-title="OS X и Linux" data-id="OSX_Linux_whoami" data-collapse=true ces-->
```
cd /root/
```
<!--endsec-->
Перевіряємо наявність файлу launch_binary_linux
<!--sec data-title="OS X и Linux" data-id="OSX_Linux_whoami" data-collapse=true ces-->
```
ls -l
```
<!--endsec-->


![Image alt](https://github.com/ukrmine/ionet/blob/main/pics/2launch_binary_linux.png)

Якщо файлу немає скачуємо
<!--sec data-title="OS X и Linux" data-id="OSX_Linux_whoami" data-collapse=true ces-->
```
curl -L https://github.com/ionet-official/io_launch_binaries/raw/main/launch_binary_linux -o launch_binary_linux
chmod +x launch_binary_linux
```
<!--endsec-->

![Image alt](https://github.com/ukrmine/ionet/blob/main/pics/3Download_binary.png)

створюємо файл скрипта
<!--sec data-title="OS X и Linux" data-id="OSX_Linux_whoami" data-collapse=true ces-->
```
cat > /root/check.sh <<EOF 
#!/bin/bash 
if docker ps | grep -q "io-worker-monitor" && docker ps | grep -q "io-worker-vc"; then
echo "NODE IS WORKING." 
else 
echo "NODE ERROR, RUNING NEW NODE" 
./launch_binary_linux --device_id= YOURDEVICEID --user_id=YOURUSERID --operating_system="Linux" --usegpus=false --device_name= YOURDEVICENAME
fi 
EOF
```
<!--endsec-->
Рядок виділений червоним потрібно замінити, беремо з кабінету (2. Copy and run the command below)

Перевіряємо як працює скрипт: /root/check.sh
Якщо воркер працює, то отримаємо:
Якщо воркер не працює, отримаємо:
Налаштуємо автозапуск скрипта: crontab -e
Якщо ця команда запускається вперше на сервері, спитає якою програмою редагувати (для початківців рекомендую nano)
Добавляємо в кінець файлу цей текст:
HOME=/root/
*/1 * * * * /root/check.sh

Якщо використовуєте програму nanoдля редагування, для того щоб вийти натисніть ctrl+x потім y і Enter 
 
Скрипт кожної хвилини буде перевіряти чи працює воркер, і запускатиме якщо він не запущений.
Для того щоб перевірити роботу скрипта, перезапустіть сервер командою reboot і дочекайтесь щоб воркер запустився без Вашої участі.






