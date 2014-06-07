# Hong Kong LegCo Data Scraper

A script to extract legco data in both Chinese and English.

1. Legco members' biography, includes:
- name
- profile picture URL
- constituency
- URL to their biographies.
- Office Address
- Office Telephone Number(s)
- Office Fax Number(s)
- Email Address
- Website Address
(amended based on https://github.com/OpenDataHK/legco_members)

2. To be continued...

## Usage

###Legco Members Biography
[legco_members_bio_ch.json](https://raw.githubusercontent.com/kenyiu/Legco-Scraper/master/data/json/legco_members_bio_chi.json)

[legco_members_bio_en.json](https://raw.githubusercontent.com/kenyiu/Legco-Scraper/master/data/json/legco_members_bio_eng.json)

## Do It Yourself

Clone this project, run following command to generate the data yourself.

###Installation
```
bundle install
```

###Legco Members Biography
```
rake members:bio_ch #Chinese version
rake members:bio_en #English version
```

## CC0 1.0 Universal

To the extent possible under law, I waived all copyright and related or neighboring rights to this app.

Made in Hong Kong.

http://creativecommons.org/publicdomain/zero/1.0
