const puppeteer = require('puppeteer');
(async () => {
  const browser = await puppeteer.launch();
  const page = await browser.newPage();
  await page.goto('file://' + process.cwd() + '/test.html');
  const h1 = await page.evaluate(() => document.querySelector('.carousel-inner').offsetHeight);
  const h2 = await page.evaluate(() => document.querySelector('.carousel-item').offsetHeight);
  const h3 = await page.evaluate(() => document.querySelector('.intro-section').offsetHeight);
  console.log('inner:', h1, 'item:', h2, 'section:', h3);
  await browser.close();
})();
