module Constants
  TWEET_APP_BASE_URL = 'https://arcane-ravine-29792.herokuapp.com/'
  OAUTH_PATH = 'oauth/'
  CODE_PATH = 'authorize?'
  TOKEN_PATH = 'token/'

  RESPONSE_TYPE = 'response_type=code'
  CLIENT_ID = 'client_id=f17620f69de54893c5df06796da7271e0fa6911e318bff0b8ea54a7cce7980ce'
  REDIRECT_URI = 'redirect_uri=http://localhost:3000/oauth/callback'

  GET_CODE_PATH = TWEET_APP_BASE_URL +
                  OAUTH_PATH +
                  CODE_PATH + 
                  [RESPONSE_TYPE, CLIENT_ID, REDIRECT_URI].join('&')
end