# Minimal WebPlayer

This is a very simple video player. My only goal with this project was, to be
able to be hosted on S3 (or compatible service), especially on my Minio instance.

[Demo](https://share-efertone.storage.efertone.me/dockercon2021/index.html)

## Deploy

1. Build the application: `make prod-build`
2. Update `index.html` args to match the available file extensions.
3. Upload the `public` folder content:
    * index.html
    * application.css
    * application.js

4. Create and upload a `videos.json` (next to index.html).
    ```json
    [
      {"Name": "Section 1", "Title": "This is the title", "Path": "path/to/the/file/without/extension"}
    , {"Name": "Section 1", "Title": "Another title", "Path": "another/file"}
    , {"Name": "Section 2", "Title": "Awesomeness", "Path": "path/to/awesome"}
    ]
    ```

## Hack

1. [optional] Start a server, for example with python: `make start-dev-server`
2. Make changes
3. Build: `make dev-build`
4. `goto 2`
