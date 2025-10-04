const lang = (navigator.language || navigator.userLanguage || 'en').toLowerCase();
const loadingText = document.getElementById('loading-text');

if (lang.startsWith('de')) {
  loadingText.textContent = 'Lädt...';
} else {
  loadingText.textContent = 'Loading...';
}

// Remove the loader div when Flutter renders first frame
window.addEventListener('flutter-first-frame', function () {
  const loaderDiv = document.getElementById('loading-overlay');
  if (loaderDiv) {
    loaderDiv.remove();
  }
});