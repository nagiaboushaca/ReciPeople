# Some set up for the application 

from flask import Flask
from flaskext.mysql import MySQL

# create a MySQL object that we will use in other parts of the API
db = MySQL()

def create_app():
    app = Flask(__name__)
    
    # secret key that will be used for securely signing the session 
    # cookie and can be used for any other security related needs by 
    # extensions or your application
    app.config['SECRET_KEY'] = 'someCrazyS3cR3T!Key.!'

    # these are for the DB object to be able to connect to MySQL. 
    app.config['MYSQL_DATABASE_USER'] = 'root'
    app.config['MYSQL_DATABASE_PASSWORD'] = open('/secrets/db_password.txt').readline()
    app.config['MYSQL_DATABASE_HOST'] = 'db'
    app.config['MYSQL_DATABASE_PORT'] = 3306
    app.config['MYSQL_DATABASE_DB'] = 'ReciPeople'  # Change this to your DB name

    # Initialize the database object with the settings above. 
    db.init_app(app)
    
    # Add a default route
    @app.route("/")
    def welcome():
        return "<h1>Welcome to the 3200 boilerplate app</h1>"

    # Import the various routes
    from src.views import views
    from src.accounts.accounts import accounts
    from src.followers.followers  import followers
    from src.posts.posts import posts
    from src.likes.likes  import likes
    from src.comments.comments import comments
    from src.recipes.recipes  import recipes
    from src.savedRecipes.savedRecipes import savedRecipes
    from src.ingredients.ingredients  import ingredients
    from src.skillLevel.skillLevel import skillLevel
    from src.cuisine.cuisine  import cuisine
    from src.equipment.equipment import equipment

    # Register the routes that we just imported so they can be properly handled
    app.register_blueprint(views,       url_prefix='/v')
    app.register_blueprint(accounts,   url_prefix='/a')
    app.register_blueprint(followers,    url_prefix='/f')
    app.register_blueprint(posts,   url_prefix='/p')
    app.register_blueprint(likes,    url_prefix='/l')
    app.register_blueprint(comments,   url_prefix='/c')
    app.register_blueprint(recipes,    url_prefix='/r')
    app.register_blueprint(savedRecipes,   url_prefix='/sr')
    app.register_blueprint(ingredients,    url_prefix='/i')
    app.register_blueprint(skillLevel,   url_prefix='/sl')
    app.register_blueprint(cuisine,    url_prefix='/cu')
    app.register_blueprint(equipment,   url_prefix='/eq')

    return app