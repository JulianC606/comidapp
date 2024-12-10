import { Controller } from "@hotwired/stimulus";

import audioFix from "@maslick/koder/ios_audiocontext_fix";

export default class extends Controller {
  static values = {
    dimensions: {
      type: Object,
      default: { width: window.innerWidth, height: window.innerHeight },
    },
    focusBox: Object,
    oldTime: Number,
  };

  static targets = ["container", "startBtn", "stopBtn", "result", "time"];

  ctx = null;
  video = null;
  worker = null;

  connect() {
    console.log("connected");
    audioFix();
    this.#initServiceWorker();

    this.ctx = this.containerTarget.getContext("2d");

    this.init();
    this.hideElement(this.resultTarget);
    this.tick = this.tick.bind(this);
  }

  disconnect() {
    if (this.worker) return this.worker.terminate();
  }

  #initServiceWorker() {
    if (!navigator.serviceWorker) return;

    navigator.serviceWorker
      .register(RAILS_ASSET_URL("/@maslick/koder/worker.js"))
      .then(
        (registration) => {
          console.log(
            "ServiceWorker registration successful with scope:",
            registration.scope
          );
        },
        (err) => {
          console.error("ServiceWorker registration failed:", err);
        }
      );
  }

  initWorker() {
    this.worker = new Worker(RAILS_ASSET_URL("/@maslick/koder/job.js"));
    this.worker.onmessage = (ev) =>
      this.terminateWorker(ev.data.data, ev.data.ms);
  }

  terminateWorker(data, millis) {
    this.worker.terminate();
    this.beep();
    this.stopVideo();
    this.showCode(data, millis);
    console.log(data)
  }

  init() {
    this.showElement(this.startBtnTarget);
    this.hideElement(this.stopBtnTarget);
    this.hideCanvas();
  }

  tick(time) {
    if (this.video.readyState === this.video.HAVE_ENOUGH_DATA) {
      this.showElement(this.stopBtnTarget);
      this.containerTarget.width = Math.min(this.dimensionsValue.width, this.video.videoWidth);
      this.containerTarget.height = Math.min(
        this.dimensionsValue.height,
        this.video.videoHeight
      );

      const sx = (this.containerTarget.width - this.focusBoxValue.width) / 2;
      const sy = (this.containerTarget.height - this.focusBoxValue.height) / 2;

      this.ctx.drawImage(this.video, 0, 0);
      this.ctx.fillStyle = "black";
      this.ctx.globalAlpha = 0.6;
      this.ctx.fillRect(0, 0, this.containerTarget.width, this.containerTarget.height);
      this.ctx.drawImage(
        this.video,
        sx,
        sy,
        this.focusBoxValue.width,
        this.focusBoxValue.height,
        sx,
        sy,
        this.focusBoxValue.width,
        this.focusBoxValue.height
      );

      if (time - this.oldTimeValue > 600) {
        this.oldTimeValue = time;
        let imageData = this.ctx.getImageData(
          sx,
          sy,
          this.focusBoxValue.width,
          this.focusBoxValue.height
        );
        this.worker.postMessage({
          data: imageData.data,
          width: imageData.width,
          height: imageData.height,
        });
      }
    }
    requestAnimationFrame(this.tick);
  }

  ////////////////
  // Helpers
  ////////////////
  startVideo() {
    this.video = document.createElement("video");
    this.hideElement(this.startBtnTarget);
    this.hideElement(this.stopBtnTarget);
    this.showCanvas();

    this.initWorker();
    navigator.mediaDevices
      .getUserMedia({ audio: false, video: { facingMode: "environment" } })
      .then((stream) => {
        this.video.srcObject = stream;
        this.video.setAttribute("playsinline", "true");
        this.video.play();
        requestAnimationFrame(this.tick);
      });
  }

  stopVideo() {
    this.hideElement(this.stopBtnTarget);
    this.video.pause();
    this.video.srcObject.getVideoTracks().forEach((track) => track.stop());
    this.video.srcObject = null;
    this.init();
  }

  beep(freq = 750, duration = 150, vol = 5) {
    try {
      const context = window.audioContext;
      const oscillator = context.createOscillator();
      const gain = context.createGain();
      oscillator.connect(gain);
      oscillator.frequency.value = freq;
      oscillator.type = "square";
      gain.connect(context.destination);
      gain.gain.value = vol * 0.01;
      oscillator.start(context.currentTime);
      oscillator.stop(context.currentTime + duration * 0.001);
    } catch (e) {
      console.warn("Sorry, Web Audio API is not supported by your browser");
      console.warn(e.toString());
    }
  }

  ////////////////
  // DOM
  ////////////////
  hideElement(el) {
    el.style.display = "none";
  }

  showElement(el) {
    el.style.display = "initial";
  }

  hideCanvas() {
    this.containerTarget.hidden = true;
  }

  showCanvas() {
    this.containerTarget.hidden = false;
  }

  showCode(qr, ms) {
    this.resultTarget.style.display = "flex";
    this.resultTarget.innerText = qr;
    this.timeTarget.innerHTML = `<div>Scanned in ${ms} ms</div>`;
  }
}