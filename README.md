This gem adds magnet links for the given anime from "nyaa.si" to transmission. By
default it will look for 1080p episodes from EraiRaws.

# Quickstart

1. Install transmission-daemon e.g. `apt install transmission-daemon`
2. Install this gem
3. Run `nyaa`

e.g.

```
Usage: nyaa [OPTIONS] QUERY
    -d, --database=DATABASE          The SQLite3 database [default: $HOME/.local/share/nyaa.db]
    -p, --provider=PROVIDER          One of: Blackjaxx, EraiRaws, HorribleSubs [default: EraiRaws]
    -h, --help                       Shows this help
```

```
$ nyaa "Hamefura"
I, [2020-04-27T13:13:18.200330 #28717]  INFO -- : [HorribleSubs] Hamefura - 04 [1080p].mkv
I, [2020-04-27T13:13:18.220550 #28717]  INFO -- : [HorribleSubs] Hamefura - 03 [1080p].mkv
I, [2020-04-27T13:13:18.237193 #28717]  INFO -- : [HorribleSubs] Hamefura - 02 [1080p].mkv
I, [2020-04-27T13:13:18.255391 #28717]  INFO -- : [HorribleSubs] Hamefura - 01 [1080p].mkv
```
