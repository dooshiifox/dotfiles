let
  dooshii = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC/2BjmTFaXXCHo8dNcKO+sECh6+5XpuzUHllr/hSE3E71OW8IoD1ias2tLsSQrMg4hyQnX3sVEMELFWINw9Z7LAf9r6gvv4pKMqMDYiASSRy8gDpLbjdbD3620wZCdBgRNmhaiV2qLU0CyX+LhjTsajTEYx0JyDFasElFERX5uzavwqnLWf/qIod3kUjuwIYL+tYvKVdhEAVKoIdfQbITmfvGP9zBybZPMoCtGDRB6Z1hZz3Cby8/7cMU/RDhVS2/MpUGh/GA/MLEon/N06KIn0UVsClScIvOKzBbRmo94pxGbLYv8Eq3qt0oD/dkfceIColkp4VSfnPYcrj7Bw48+A+90yQY9FVGtbuszsa4PVCV7ZNLxEJ1SEfMK6S/dgsGAdgKwTkS8azXKpxKvAlljE+edMAvaRoU2GcjqX62jRulrvhdyppj/cFQRo6DUM/qIL5MMs9V8nVfyUWxaZM4SkBVpFSCPHzk9alQH4t3W/lBx5ooh/GTHhuHz0IG4IUE= dooshii@dooshii";
  system = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCyRcZveDHLtrNRAbvKTJ5MYJnem4/t0eK6IDK6a6U5OA3ttIvAUkkN7QfNqOAethy6ApZFufN12+9tjLc2+lU9rKwORmybMM8ZPI0lUt+OPLIqHPC9apLx7GSsT3tBMOkO/GdSZRUcZS0T4yVAsHUZguzSdnYhyhi8uN/3u3PuWHp4bP+ZmDC3kkHfusE2mnoXIpuK31QYoODNJ/o3qiljymBFTLcNAk5PQvHSrxdiG6GBB9qgI+lCz1sYzJ8fb0kYbw256I3LB/TxmBYsb7ae6RgQniFLAuuZR5qyv0HY3C6stRU0Z/UJ4pLJRpVTJoZ0971e8eHo96yLrogA04UXDentE4JdalRxUwZj6k3SN0ZQahgpt0zPBSUrna+B1wlF65eua5mCRuEvr30oSjW66oi5oOPaY5UtNxIL0/UARt+Z7jIPYjWsxUj6bHLeFRXsUtPgD/8qJUM60xuZL7n2zovN7KOYjezRk1mfb+CIp97nRLy56p10cO5aQqrXLWs= root@dooshii";
in {
  "secret1.age".publicKeys = [dooshii];
}
