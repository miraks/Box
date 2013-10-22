if Rails.configuration.x.bullet.enable
  Bullet.enable = true
  Bullet.alert = true
  Bullet.bullet_logger = true
  Bullet.console = true
  Bullet.rails_logger = true
  #Bullet.add_footer = true #undefined method `add_footer=' for Bullet:Module
end