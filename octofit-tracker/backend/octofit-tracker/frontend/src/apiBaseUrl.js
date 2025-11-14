// Utility to get the correct API base URL for Codespaces or localhost
export function getApiBaseUrl() {
  const { hostname } = window.location;
  if (hostname.endsWith('app.github.dev')) {
    // Codespace: extract codespace name
    const match = hostname.match(/^([^-]+)-8000\.app\.github\.dev/);
    if (match) {
      return `https://${match[1]}-8000.app.github.dev/api/`;
    }
  }
  // Default to localhost
  return 'http://localhost:8000/api/';
}
