# Copy this file to `secrets.nix` and edit it.
{...}: {
  ####################
  ##  WARNING!!!!!  ##
  ####################
  #
  # This will add all of these to your environment variables!
  # If this is a concern for you (especially around mail!), you should
  # make a PR. Please.
  #

  home.sessionVariables = {
    # EWW configuration.

    IMAP_MAIL_CONFIG = ''
      [
        {
          \"server\": \"imap.gmail.com\",
          \"email\": \"<redacted>@gmail.com\",
          \"nickname\": \"Primary\",
          \"password\": \"<redacted>\",
          \"color\": \"#dbab39\",
          \"link\": \"https://mail.google.com/mail/u/0/#inbox\"
        },
        {
          \"server\": \"imap.gmail.com\",
          \"email\": \"<redacted>@gmail.com\",
          \"nickname\": \"Junk\",
          \"password\": \"<redacted>\",
          \"color\": \"#e66161\",
          \"link\": \"https://mail.google.com/mail/u/1/#inbox\"
        }
      ]
    '';
    # Your OpenWeatherMap API key. See See https://home.openweathermap.org/users/sign_in
    OPENWEATHER_KEY = "";
    # City ID. See http://bulk.openweathermap.org/sample/
    OPENWEATHER_CITY_ID = "";
    # Available options : 'metric' or 'imperial'
    OPENWEATHER_UNIT = "";
  };
}
