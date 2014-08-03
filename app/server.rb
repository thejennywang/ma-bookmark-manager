require 'data_mapper'
require 'sinatra'
require 'rack-flash'
require 'rest_client'
require_relative 'models/link'
require_relative 'models/tag' 
require_relative 'models/user'
require_relative 'data_mapper_setup'
require_relative 'helpers/application'
require_relative 'helpers/session'

require_relative 'controllers/application'
require_relative 'controllers/links'
require_relative 'controllers/tags'
require_relative 'controllers/sessions'
require_relative 'controllers/users'

enable :sessions
set :sessions_secret, 'super secret'
use Rack::Flash
use Rack::MethodOverride
set :partial_template_engine, :erb
set :public_dir, Proc.new { File.join(root, "..", "public")}
# set :views, Proc.new { File.join(root, "views")}

include AppHelpers
include SessionHelpers

