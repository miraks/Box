set :stage, :production

# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary
# server in each group is considered to be the first
# unless any hosts have the primary property set.
role :app, %w{box@acidancer.dlinkddns.com}
role :web, %w{box@acidancer.dlinkddns.com}
role :db,  %w{box@acidancer.dlinkddns.com}

# Extended Server Syntax
# ======================
# This can be used to drop a more detailed server
# definition into the server list. The second argument
# something that quacks like a has can be used to set
# extended properties on the server.
server 'acidancer.dlinkddns.com', user: 'box', roles: %w{web app db}