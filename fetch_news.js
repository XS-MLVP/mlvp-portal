const puppeteer = require('puppeteer');
(async () => {
  const browser = await puppeteer.launch();
  const page = await browser.newPage();
  await page.goto('https://www.minimaxi.com/news', {waitUntil: 'networkidle2'});
  const html = await page.content();
  const fs = require('fs');
  fs.writeFileSync('news.html', html);
  await page.screenshot({path: 'news.png', fullPage: true});
  await browser.close();
})();
