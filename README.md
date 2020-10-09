This gem adds magnet links for the given anime from "nyaa.si" to transmission. By
default it will look for 1080p episodes from EraiRaws.

Torrents that has been added to transmission will be recorded in a sqlite3
database, and will not be fetched again later.

Uses the default username, password and port number for transmission.

# Quickstart

1. Install dependencies

    ```
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

Example of downloading the anime "Hamefura"

```
$ nyaa --provider=HorribleSubs "Hamefura"
I, [2020-04-27T13:13:18.200330 #28717]  INFO -- : [HorribleSubs] Hamefura - 04 [1080p].mkv
I, [2020-04-27T13:13:18.220550 #28717]  INFO -- : [HorribleSubs] Hamefura - 03 [1080p].mkv
I, [2020-04-27T13:13:18.237193 #28717]  INFO -- : [HorribleSubs] Hamefura - 02 [1080p].mkv
I, [2020-04-27T13:13:18.255391 #28717]  INFO -- : [HorribleSubs] Hamefura - 01 [1080p].mkv
```
