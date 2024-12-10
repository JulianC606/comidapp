importScripts(RAILS_ASSET_URL("/@maslick/koder/zbar_cjs.js"));
importScripts(RAILS_ASSET_URL("/@maslick/koder/browser.js"));

(async () => {
  // Initialize Koder
  const koder = await new Koder().initialize({wasmDirectory: "./../../.."});

  // Listen for messages from JS main thread containing raw image data
  self.addEventListener('message', event => {
    if ('width' in event.data && 'height' in event.data) {
      this.width = event.data.width;
      this.height = event.data.height;
    }

    const {data} = event.data;
    if (!data) return;

    const t0 = new Date().getTime();
    const scanResult = koder.decode(data, this.width, this.height);
    const t1 = new Date().getTime();
    if (scanResult) {
      postMessage({
        data: scanResult,
        ms: t1 - t0
      });
    }
  });
})();
