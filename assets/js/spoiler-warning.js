(function () {
  function safeUrl(url, fallback) {
    try {
      var parsed = new URL(url, window.location.origin);
      if ((parsed.protocol !== 'http:' && parsed.protocol !== 'https:') ||
          parsed.origin !== window.location.origin) {
        return fallback;
      }
      return parsed.pathname + parsed.search + parsed.hash;
    } catch (e) {
      return fallback;
    }
  }

  var modal = document.getElementById('spoiler-warning-modal');
  if (!modal) return;

  var postKey = modal.getAttribute('data-post-key');
  var homeUrl = safeUrl(modal.getAttribute('data-home-url') || '/', '/');
  var storageKey = 'sw_accepted' + postKey;

  // Already accepted — remove modal immediately so content is visible
  if (localStorage.getItem(storageKey)) {
    modal.parentNode.removeChild(modal);
    return;
  }

  document.body.classList.add('sw-open');

  document.getElementById('sw-modal-accept').addEventListener('click', function () {
    localStorage.setItem(storageKey, '1');
    document.body.classList.remove('sw-open');
    modal.parentNode.removeChild(modal);
  });

  document.getElementById('sw-modal-cancel').addEventListener('click', function () {
    window.location.href = homeUrl;
  });

  // Allow Escape key to trigger cancel
  document.addEventListener('keydown', function (e) {
    if (e.key === 'Escape') {
      window.location.href = homeUrl;
    }
  });
}());
