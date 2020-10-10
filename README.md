# README

This gem adds magnet links for the given anime from
[NyaaTorrents](https://nyaa.si) to [Transmission](https://transmissionbt.com/).
By default it will look for 1080p episodes from EraiRaws.

Magnet links that have been added to **transmission** will be recorded in a
sqlite3 database, and will not be fetched again later.

This means that it will be safe to create a cron script that downloads the same
anime repeatedly, and only new episodes will be fetched.

e.g. An example cron script to get the latest episodes of two anime series:

```
#!/bin/sh

nyaa "Enen no Shouboutai"
nyaa "Mahouka Koukou no Rettousei"
```

This gem uses the default username, password and port number for
**transmission**.

| Setting  | Value        |
| -------- | ------------ |
| Username | transmission |
| Password | transmission |
| Port     | 9091         |

# Quickstart

1. Install dependencies

    ```
    apt install build-essential patch ruby-dev zlib1g-dev liblzma-dev # for Nokogiri
    apt install transmission-daemon libsqlite3-dev
    ```

2. Install this gem

    ```
    gem install nyaa-transmission
    ```

3. Run `nyaa`

    ```
    Usage: nyaa [OPTIONS] QUERY
        -d, --database=DATABASE   The SQLite3 database [default: $HOME/.local/share/nyaa.db]
        -p, --provider=PROVIDER   One of: Blackjaxx, EraiRaws, HorribleSubs [default: EraiRaws]
        -h, --help                Shows this help
    ```

Example of downloading the anime "Hamefura" from HorribleSubs

```
$ nyaa --provider=HorribleSubs "Hamefura"
I, [2020-04-27T13:13:18.200330 #28717]  INFO -- : [HorribleSubs] Hamefura - 04 [1080p].mkv
I, [2020-04-27T13:13:18.220550 #28717]  INFO -- : [HorribleSubs] Hamefura - 03 [1080p].mkv
I, [2020-04-27T13:13:18.237193 #28717]  INFO -- : [HorribleSubs] Hamefura - 02 [1080p].mkv
I, [2020-04-27T13:13:18.255391 #28717]  INFO -- : [HorribleSubs] Hamefura - 01 [1080p].mkv
```
