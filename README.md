![Image alt](https://github.com/ukrmine/ionet/blob/main/pics/mAa0QmH3Nl9IyKqDAZzvuFNZhE0.webp)

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
 docker rm -f $(docker ps -aq)
 yes | docker system prune -a
 тут потрібно вставити рядок з сайту (2. Copy and run the command below)
fi 
EOF
```
<!--endsec-->
Рядок ./launch_binary_linux... потрібно замінити, беремо з кабінету (2. Copy and run the command below)

![Image alt](https://github.com/ukrmine/ionet/blob/main/pics/4Copy_and_run_the_command.png)

Перевіряємо як працює скрипт
<!--sec data-title="OS X и Linux" data-id="OSX_Linux_whoami" data-collapse=true ces-->
```
/root/check.sh
```
<!--endsec-->
Якщо воркер працює, то отримаємо:

![Image alt](https://github.com/ukrmine/ionet/blob/main/pics/5check.png)

Якщо воркер не працює, отримаємо:

![Image alt](https://github.com/ukrmine/ionet/blob/main/pics/6run_new_node.png)

Налаштуємо автозапуск скрипта

<!--sec data-title="OS X и Linux" data-id="OSX_Linux_whoami" data-collapse=true ces-->
```
crontab<<EOF
HOME=/root/
*/5 * * * * /root/check.sh
EOF
```
<!--endsec-->

Скрипт кожні 5 хвилин буде перевіряти чи працює воркер, і запускатиме якщо він не запущений.
Для того щоб перевірити роботу скрипта, перезапустіть сервер командою reboot і дочекайтесь щоб воркер запустився без Вашої участі.






