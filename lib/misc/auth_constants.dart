const kAuthDomain = 'keycloakspotspeakwebsite.website';
const kAuthClientId = 'flutter-frontend';
const kCloseWebViewUrl = 'com.odwaznistudenci.spotspeak://close-webview';
const kPasswordResetUrl =
    'https://keycloakspotspeakwebsite.website/realms/spotspeak/protocol/openid-connect/auth?client_id=flutter-frontend&redirect_uri=$kCloseWebViewUrl&response_type=code&scope=openid&kc_action=UPDATE_PASSWORD';
const kAuthClientSecret = String.fromEnvironment('AUTH_CLIENT_SECRET');
const kAuthIssuer = 'https://keycloakspotspeakwebsite.website/realms/spotspeak';
const kBundleIdentifier = 'com.odwaznistudenci.spotspeak';
const kAuthRedirectUri = '$kBundleIdentifier://login-callback';
const kLogoutRedirectUri = '$kBundleIdentifier://logout-callback';
const kAuthRefreshTokenKey = 'refresh_token';
const kAuthRealms = 'spotspeak';
