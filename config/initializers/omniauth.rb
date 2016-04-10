Rails.application.config.middleware.use OmniAuth::Builder do
 provider :coub, "8479dbfc74549a1b8f01f87519295a3032b02200e2027449898b8b2ab8cf4630", "d38cda36fb391a7ca094ec27fdca44ca949523aa7dbadf2cac8273084d4d1916", scope: "logged_in,create,like", callback_url: 'http://localhost:3000/auth/coub/callback', redirect_uri: 'http://localhost:3000/auth/coub/callback'
end