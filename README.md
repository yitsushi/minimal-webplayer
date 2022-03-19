# Minimal WebPlayer

This is a very simple video player. My only goal with this project was, to be
able to be hosted on S3 (or compatible service), especially on my Minio instance.

[Demo](https://share-efertone.storage.efertone.me/dockercon2021/index.html)

## Deploy

1. Build the application: `make build-prod`
2. Update `index.html` args to match the available file extensions.
3. Upload the `public` folder content:
    * index.html
    * application.css
    * application.js

4. Create and upload a `videos.json` (next to index.html).
    ```json
    [
      {"Title": "This is the title", "Path": "path/to/the/file/without/extension"}
    , {"Title": "Another title", "Path": "another/file"}
    , {"Title": "Awesomeness", "Path": "path/to/awesome"}
    ]
    ```
