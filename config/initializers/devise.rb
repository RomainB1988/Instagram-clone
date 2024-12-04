Devise.setup do |config|
  # Mailer sender (modifiez l'adresse email avec une vraie adresse)
  config.mailer_sender = 'please-change-me-at-config-initializers-devise@example.com'

  # ORM utilisé par Devise
  require 'devise/orm/active_record'

  # Désactiver les formats HTML (important pour une API-only app)
  config.navigational_formats = [:json]
  config.http_authenticatable = true

  # Clés d'authentification (par défaut : email)
  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]

  # Validation des mots de passe
  config.password_length = 6..128
  config.email_regexp = /\A[^@\s]+@[^@\s]+\z/

  # Stockage des sessions (utile pour les API-only apps)
  config.skip_session_storage = [:http_auth]

  # Méthode HTTP pour la déconnexion (par défaut : DELETE)
  config.sign_out_via = :delete

  # Warden configuration (utilisé pour gérer les erreurs d'authentification)
  config.warden do |manager|
    manager.failure_app = lambda do |env|
      [
        401,
        { "Content-Type" => "application/json" },
        [{ error: "Unauthorized" }.to_json]
      ]
    end
  end
end
