-- This file is to bootstrap a database for the CS3200 project. 

-- Create a new database.  You can change the name later.  You'll
-- need this name in the FLASK API file(s),  the AppSmith 
-- data source creation.
create database ReciPeople;

-- Via the Docker Compose file, a special user called webapp will 
-- be created in MySQL. We are going to grant that user 
-- all privilages to the new database we just created. 
-- TODO: If you changed the name of the database above, you need 
-- to change it here too.
grant all privileges on cool_db.* to 'webapp'@'%';
flush privileges;

-- Move into the database we just created.
-- TODO: If you changed the name of the database above, you need to
-- change it here too. 

use ReciPeople;

-- Put your DDL

CREATE TABLE IF NOT EXISTS Accounts (
    username varchar(20) PRIMARY KEY,
    pword varchar(20) NOT NULL,
    first_name varchar(20) NOT NULL,
    last_name varchar(20) NOT NULL,
    bio varchar(200),
    email_address varchar(100) UNIQUE NOT NULL,
    phone_number char(10) UNIQUE
);

CREATE TABLE IF NOT EXISTS FollowerRelationship (
    -- illustrates the relationship that A follows B
    A varchar(20) NOT NULL,
    B varchar(20) NOT NULL,
    CONSTRAINT follower_reference
        FOREIGN KEY (A) REFERENCES Accounts (username),
    CONSTRAINT follower_reference2
        FOREIGN KEY (B) REFERENCES Accounts (username)
);

CREATE TABLE IF NOT EXISTS Posts (
    post_id int PRIMARY KEY,
    poster varchar(20) UNIQUE NOT NULL,
    caption varchar(750),
    post_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT username_reference
        FOREIGN KEY (poster) REFERENCES Accounts (username)
);

CREATE TABLE IF NOT EXISTS Tags (
    tag_id int PRIMARY KEY,
    post_id int NOT NULL,
    tag_name varchar(20),
    CONSTRAINT tag_reference
        FOREIGN KEY (post_id) REFERENCES Posts (post_id)
);

CREATE TABLE IF NOT EXISTS Likes (
    like_id int PRIMARY KEY,
    liker varchar(20) NOT NULL,
    post_id int NOT NULL,
    CONSTRAINT username_reference2
        FOREIGN KEY (liker) REFERENCES Accounts (username),
    CONSTRAINT post_id_reference
        FOREIGN KEY (post_id) REFERENCES Posts (post_id)
);

CREATE TABLE IF NOT EXISTS Comments (
    comment_id int PRIMARY KEY,
    commenter varchar(20) NOT NULL,
    post_id int NOT NULL,
    content varchar(200),
    comment_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT username_reference3
        FOREIGN KEY (commenter) REFERENCES Accounts (username),
    CONSTRAINT post_id_reference2
        FOREIGN KEY (post_id) REFERENCES Posts (post_id)
);

CREATE TABLE IF NOT EXISTS Skill_Level (
    skill_level_id int PRIMARY KEY,
    skill_name varchar(20)
);

CREATE TABLE IF NOT EXISTS Cuisines (
    cuisine_id int PRIMARY KEY,
    cuisine_name varchar(20)
);

CREATE TABLE IF NOT EXISTS Recipes (
    recipe_id int PRIMARY KEY,
    recipe_name varchar(30),
    steps varchar(16000),
    recipe_time int NOT NULL,
    skill_level_id int NOT NULL,
    serving_size int NOT NULL,
    calories int,
    cuisine_id int NOT NULL,
    CONSTRAINT recipe_post_reference
        FOREIGN KEY (recipe_id) REFERENCES Posts (post_id),
    CONSTRAINT skill_level_reference
        FOREIGN KEY (skilL_level_id) REFERENCES Skill_Level (skill_level_id),
    CONSTRAINT cuisine_reference
        FOREIGN KEY (cuisine_id) REFERENCES Cuisines (cuisine_id)
);

CREATE TABLE IF NOT EXISTS Ingredient_Category (
    category_id int PRIMARY KEY,
    category_name varchar(50)
);

CREATE TABLE IF NOT EXISTS Ingredients (
    ingredient_name varchar(50) UNIQUE NOT NULL,
    recipe_id int NOT NULL,
    category_id int NOT NULL,
    amount double,
    unit varchar(30),
    CONSTRAINT recipe_reference2
        FOREIGN KEY (recipe_id) REFERENCES Recipes (recipe_id),
    CONSTRAINT category_reference
        FOREIGN KEY (category_id) REFERENCES Ingredient_Category (category_id)
);

CREATE TABLE IF NOT EXISTS Equipment (
    equipment_name varchar(30),
    recipe_id int NOT NULL,
    CONSTRAINT recipe_reference
        FOREIGN KEY (recipe_id) REFERENCES Recipes (recipe_id)
);

CREATE TABLE IF NOT EXISTS Saved_recipes (
    username varchar(20) NOT NULL,
    saved_recipe_id int NOT NULL,
    CONSTRAINT username_reference4
        FOREIGN KEY (username) REFERENCES Accounts (username),
    CONSTRAINT recipe_reference3
        FOREIGN KEY (saved_recipe_id) REFERENCES Recipes (recipe_id)

);

-- Add sample data. 

INSERT INTO Accounts
VALUES ('nagiaboushaca', 'secretpassword',
        'Nagi', 'Aboushaca', 'I love food!!!', 'nagishaca@gmail.com', '2014508996' );
INSERT INTO Accounts
VALUES ('wcolsey', 'bjorn',
        'Will', 'Colsey', 'Chef. Northeastern. I love Dogs.',
        'wcolsey@gmail.com', '8583425074' );
INSERT INTO Accounts
VALUES ('sena.szczepaniuk', 'sean',
        'Sena', 'Szczepaniuk', 'I love to code! And make ER diagrams!!',
        'senaszczepaniuk@gmail.com','9178882222' );

-- nagiaboushaca : 0 followers, 2 following
-- wcolsey : 1 followers, 1 following
-- sena.szczepaniuk : 2 followers, 0 following
INSERT INTO FollowerRelationship
VALUES ('nagiaboushaca','wcolsey');

INSERT INTO FollowerRelationship
VALUES ('nagiaboushaca','sena.szczepaniuk');

INSERT INTO FollowerRelationship
VALUES ('wcolsey','sena.szczepaniuk');


INSERT INTO Posts
VALUES (1, 'nagiaboushaca',
        'I wanted to share this pasta recipe with you guys! Perfect for a quick lunch!',
        CURRENT_TIMESTAMP);
INSERT INTO Posts
VALUES (2, 'wcolsey',
        'I LOVE making Beef Stroganoff, so I wanted to shore with you all my *secret!* family recipe :)',
        CURRENT_TIMESTAMP);
INSERT INTO Posts
VALUES (3, 'sena.szczepaniuk',
        'PB&J for hard times',
        CURRENT_TIMESTAMP);


INSERT INTO Tags
VALUES (1, 1, '#cheesy');
INSERT INTO Tags
VALUES (2, 1, '#quicklunch');
INSERT INTO Tags
VALUES (3, 2, '#hearty');
INSERT INTO Tags
VALUES (4, 2, '#juicy');
INSERT INTO Tags
VALUES (5, 3, '#depressionmeal');
INSERT INTO Tags
VALUES (6, 3, '#college');


-- Post_id: 1, Num_Likes: 2
-- Post_id: 2, Num_Likes: 2
-- Post_id: 3, Num_Likes: 1
INSERT INTO Likes
VALUES (1,
        'nagiaboushaca',
        1);
INSERT INTO Likes
VALUES (2,
        'nagiaboushaca',
        2);
INSERT INTO Likes
VALUES (3,
        'nagiaboushaca',
        3);
INSERT INTO Likes
VALUES (4,
        'wcolsey',
        2);
INSERT INTO Likes
VALUES (5,
        'sena.szczepaniuk',
        1);


-- Post_id: 1, Num_Comments: 2
-- Post_id: 2, Num_Comments: 1
-- Post_id: 3, Num_Comments: 1
INSERT INTO Comments
VALUES (1,
        'nagiaboushaca',
        1,
        'Like and follow for more content!',
        CURRENT_TIMESTAMP);
INSERT INTO Comments
VALUES (2,
        'wcolsey',
        3,
        'pb&j never really whetted my tastebuds, but this is rad!!',
        CURRENT_TIMESTAMP);
INSERT INTO Comments
VALUES (3,
        'sena.szczepaniuk',
        2,
        'Nice Beef Stroganoff',
        CURRENT_TIMESTAMP);
INSERT INTO Comments
VALUES (4,
        'sena.szczepaniuk',
        1,
        'I dont really like pasta tbh',
        CURRENT_TIMESTAMP);


INSERT INTO Skill_Level
VALUES (1, 'Beginner');
INSERT INTO Skill_Level
VALUES (2, 'Intermediate');
INSERT INTO Skill_Level
VALUES (3, 'Amateur');
INSERT INTO Skill_Level
VALUES (4, 'Advanced');
INSERT INTO Skill_Level
VALUES (5, 'Professional Chef');


INSERT INTO Cuisines
VALUES (1, 'Asian');
INSERT INTO Cuisines
VALUES (2, 'Caribbean');
INSERT INTO Cuisines
VALUES (3, 'Mediterrean');
INSERT INTO Cuisines
VALUES (4, 'Fusion');
INSERT INTO Cuisines
VALUES (5, 'New American');

INSERT INTO Recipes
VALUES (1, 'Broccoli Cheddar Pasta',
        '1. Salt some water and bring to a boil in a pot, and boil the pasta
         2. Wash and cut your broccoli crown into bite size pieces
         3. Stir-fry broccoli in a pan with oil
         4. Add cheese
         5. Add the pasta in once done
         6. Stir well and enjoy!',
        20,
        2,
        1,
        300,
        5);

INSERT INTO Recipes
VALUES (2, 'Beef Stroganoff',
        '1. Sear 2 batches of beef, 1 minute per side on high heat
         2. Add butter and onions and mushrooms, and sautee for 6-8 minutes
         3. Add one minced garlic clove and sautee for one minute
         4. Pour in one cup of beef broth, and 3/4 cup whipping cream
         5. Add dijon mustard, salt, and pepper
         6. Stir well and enjoy!',
        60,
        3,
        2,
        689,
        5);

INSERT INTO Recipes
VALUES (3, 'PB&J Sandwich',
        '1. Toast bread for 3 minutes
         2. Spread peanut butter on one piece of bread
         3. Spread jelly on the other piece of bread
         4. Close, and enjoy!!!',
        5,
        1,
        1,
        200,
        5);


INSERT INTO Ingredient_Category
VALUES (1, 'Fruits');
INSERT INTO Ingredient_Category
VALUES (2, 'Vegetables');
INSERT INTO Ingredient_Category
VALUES (3, 'Meat');
INSERT INTO Ingredient_Category
VALUES (4, 'Seafood');
INSERT INTO Ingredient_Category
VALUES (5, 'Grains, nuts, and baking products');
INSERT INTO Ingredient_Category
VALUES (6, 'Seasonings');
INSERT INTO Ingredient_Category
VALUES (7, 'Dairy');
INSERT INTO Ingredient_Category
VALUES (8, 'Fats and oils');
INSERT INTO Ingredient_Category
VALUES (9, 'Other');


INSERT INTO Ingredients
VALUES ('Broccoli', 1, 2, 1, 'crown');
INSERT INTO Ingredients
VALUES ('Pasta', 1, 9, 2, 'ounces');
INSERT INTO Ingredients
VALUES ('Cheddar Cheese', 1, 7, 0.5, 'ounces');
INSERT INTO Ingredients
VALUES ('Beef', 2, 3, 1, 'pound');
INSERT INTO Ingredients
VALUES ('Mushrooms', 2, 2, 6, 'mushrooms');
INSERT INTO Ingredients
VALUES ('Dijon Mustard', 2, 6, 1, 'tablespoon');
INSERT INTO Ingredients
VALUES ('Peanut Butter', 3, 9, 2, 'generous spreads');
INSERT INTO Ingredients
VALUES ('Jelly', 3, 9, 2, 'generous spreads');
INSERT INTO Ingredients
VALUES ('Bread', 3, 5, 2, 'slices');


INSERT INTO Equipment
VALUES ('Pot', 1);
INSERT INTO Equipment
VALUES ('Wooden Spoon', 1);
INSERT INTO Equipment
VALUES ('Knife', 1);
INSERT INTO Equipment
VALUES ('Pan', 2);
INSERT INTO Equipment
VALUES ('Mallet', 2);
INSERT INTO Equipment
VALUES ('Knife', 2);
INSERT INTO Equipment
VALUES ('Butter knife', 3);
INSERT INTO Equipment
VALUES ('Toaster', 3);

INSERT INTO Saved_recipes
VALUES ('nagiaboushaca', 2);
INSERT INTO Saved_recipes
VALUES ('wcolsey', 1);
INSERT INTO Saved_recipes
VALUES ('sena.szczepaniuk', 3);
