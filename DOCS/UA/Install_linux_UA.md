# :checkered_flag: Встановлення воркера для IO.NET 

QEMU Virtual CPU version 2.5+

## 1. Реєструємось на сайті <a href="https://cloud.io.net/worker/devices/" target="_blank">IO.NET</a>

1.1 Підключаємо нового воркера

![Image alt](https://github.com/ukrmine/ionet/blob/main/pics/Create_new_worker.png)


<details>
<summary>1.2 Налаштовуємо створеного воркера</summary>

1. Select Operating System “OS”
    * `Linux`
2. Select Supplier
    * `io.net`
3. Name your device
    * `worker01`
4. Device Type
    * `CPU Worker`
5. Prerequisites for Linux
    - 5.1 Download the setup script
      * `Пропускаємо цей крок`
    - 5.2 Run the script
      * `Пропускаємо цей крок`
6. Start the containers using binary
    - 6.1 Run the command to download binary
      * `Пропускаємо цей крок`
    - 6.2 Run the command to launch binary
      * `Пропускаємо цей крок`
    - 6.3 Run the command to connect device
      * `Копіюємо цю команду, вона знадобиться в пункті 2.3-2`

</details>

![Image alt](https://github.com/ukrmine/ionet/blob/main/pics/Configure_worker.png)

## 2. Встановимо воркер на Linux Ubuntu 20.04 сервер
2.1 Зкопіюйте та вставте в термінал
```Bash
# Змінити користувача на root
sudo -s

# Скачати та запустити скрипт для створення VM та створення воркера io.net 
cd /home && curl -L https://github.com/ukrmine/ionet/raw/main/install.sh -o install.sh && chmod +x install.sh && ./install.sh
```

<details>
<summary> 2.3 Будь ласка виберіть </summary>

1. Хостинг чи тип CPU
    * `Введіть "1" якщо у Вас Digital Ocean (AMD Premium)`
    * `Введіть "2" якщо у Вас AZURE D2as_v5 or D4as_v5`
    * `Введіть "3" якщо у Вас AZURE D2s_v5 or D4s_v5`
    * `Введіть "4" якщо у Вас Google cloud N1, Kamatera`
    * `Введіть "5" якщо у Вас Enter custom CPU type`
  
2. Вставте команду для запуску воркера, яку ви копіювали в пункті 1.2-6.3
   * `./launch_binary_linux --device_id=f42ee2d8-1ae3-445e-9a63-f3eb5b75ab5a --user_id=11694796-9a22-4a58-9766-09573c0d9df9 --operating_system="Linux" --usegpus=false --device_name=worker01`
4. Введіть Hostname сервера
   * `Server01`

</details>

![Image alt](https://github.com/ukrmine/ionet/blob/main/pics/install.png)
    
Чекайте біля 10-20 хв.
Все готово, воркер встановлено та налаштовано

## Гайди

<a href="https://www.youtube.com/watch?v=Cs1ToGG2plQ" target="_blank">YouTube</a>

<a href="https://medium.com/@bitcoin_50400/how-instaling-io-net-cpu-worker-e6b528f73270" target="_blank">Medium CPU Worker</a>

<a href="https://medium.com/@bitcoin_50400/io-net-worker-on-google-cloud-7ce24c5b7797" target="_blank">Medium CPU Worker на Google Cloud</a>

