module Constants
  TWEET_APP_BASE_URL = 'https://arcane-ravine-29792.herokuapp.com/'
  OAUTH_PATH = 'oauth/'
  CODE_PATH = 'authorize?'
  TOKEN_PATH = 'token'
  TWEET_API = 'api/tweets'

  CLIENT_ID = 'f17620f69de54893c5df06796da7271e0fa6911e318bff0b8ea54a7cce7980ce'
  CLIENT_SECRET = 'e3140d157ced3fbbc2900bd64ad4f93b1a0ae034174a89ce1844e3ad61715d4e'
  REDIRECT_URI = 'http://localhost:3000/oauth/callback'

  RESPONSE_TYPE = 'response_type=code'
  CLIENT_ID_PARAM = 'client_id=' + CLIENT_ID
  REDIRECT_URI_PARAM = 'redirect_uri=' + REDIRECT_URI

  GRANT_TYPE = 'authorization_code'

  GET_CODE_PATH = TWEET_APP_BASE_URL +
                  OAUTH_PATH +
                  CODE_PATH + 
                  [RESPONSE_TYPE, CLIENT_ID_PARAM, REDIRECT_URI_PARAM].join('&')

  GET_TOKEN_PATH = TWEET_APP_BASE_URL +
                   OAUTH_PATH +
                   TOKEN_PATH

  TWEET_PATH = TWEET_APP_BASE_URL +
               TWEET_API
end