# Скрипт для моніторингу та перезапуску воркера IO.NET 
на базі Linux Ubuntu 20.04

Ви маєте бути під користувачем root (рядок в консолі має починатися з root)

![Image alt](https://github.com/ukrmine/ionet/blob/main/pics/1root.png)

Переходимо до папки root: cd /root/
Перевіряємо наявність файлу launch_binary_linux: ls -l

Якщо файлу немає скачуємо
curl -L https://github.com/ionet-official/io_launch_binaries/raw/main/launch_binary_linux -o launch_binary_linux
chmod +x launch_binary_linux

створюємо файл скрипта

cat > /root/check.sh <<EOF 
#!/bin/bash 
if docker ps | grep -q "io-worker-monitor" && docker ps | grep -q "io-worker-vc"; then
echo "NODE IS WORKING." 
else 
echo "NODE ERROR, RUNING NEW NODE" 
./launch_binary_linux --device_id= YOURDEVICEID --user_id=YOURUSERID --operating_system="Linux" --usegpus=false --device_name= YOURDEVICENAME
fi 
EOF

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






