### Folder structure

Root structure

```
├── src/                             - source code folders and files
├── public/                          - static files, ex: fonts, images
```

Source code structure (`app`)

```
├── pages/                   - NextJS router folder - file-system routing
├── components/              - pure react components
├── services/                - services which access API
├── views/                   - page content, this file is imported inside pages
```

### How to run

Run in the local machine

```bash
npm install
# then
npm run dev
```

The server will start in the port 5000 (http://localhost:3000)
