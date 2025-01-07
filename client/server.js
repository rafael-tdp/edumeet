const http = require('http');
const fs = require('fs');
const path = require('path');

const PORT = 5151;

const buildDir = path.join(__dirname, 'build', 'web');

const serveFile = (res, filePath) => {
  fs.readFile(filePath, (err, data) => {
    if (err) {
      res.writeHead(404, { 'Content-Type': 'text/plain' });
      res.end('Fichier non trouvé');
      return;
    }

    const extname = path.extname(filePath);
    let contentType = 'text/html';

    if (extname === '.js') {
      contentType = 'application/javascript';
    } else if (extname === '.css') {
      contentType = 'text/css';
    } else if (extname === '.json') {
      contentType = 'application/json';
    } else if (extname === '.png') {
      contentType = 'image/png';
    } else if (extname === '.jpg' || extname === '.jpeg') {
      contentType = 'image/jpeg';
    } else if (extname === '.svg') {
      contentType = 'image/svg+xml';
    }

    res.writeHead(200, { 'Content-Type': contentType });
    res.end(data);
  });
};

const server = http.createServer((req, res) => {
  let filePath = path.join(buildDir, req.url === '/' ? 'index.html' : req.url);

  fs.stat(filePath, (err, stats) => {
    if (err || stats.isDirectory()) {
      filePath = path.join(buildDir, 'index.html');
    }

    serveFile(res, filePath);
  });
});

server.listen(PORT, () => {
  console.log(`Serveur HTTP en écoute sur http://localhost:${PORT}`);
});
