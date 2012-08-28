# -*- encoding : utf-8 -*-
# reCAPTCHA Keys
# ENV['RECAPTCHA_PUBLIC_KEY']  = '6LecK7sSAAAAANHZLw61YKk-FL8Iuvy_jCDiz71c'
# ENV['RECAPTCHA_PRIVATE_KEY'] = '6LecK7sSAAAAAGB1p81MJrYTwAP5yr8B81YAn68z'
Recaptcha.configure do |config|
  config.public_key  = '6LecK7sSAAAAANHZLw61YKk-FL8Iuvy_jCDiz71c'
  config.private_key = '6LecK7sSAAAAAGB1p81MJrYTwAP5yr8B81YAn68z'
  # config.proxy = 'http://myproxy.com.au:8080'
end