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
    post_id int NOT NULL AUTO_INCREMENT,
    poster varchar(20) NOT NULL,
    caption varchar(750),
    post_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (post_id),
    CONSTRAINT username_reference
        FOREIGN KEY (poster) REFERENCES Accounts (username)
);

CREATE TABLE IF NOT EXISTS Tags (
    tag_id int NOT NULL AUTO_INCREMENT,
    post_id int NOT NULL,
    tag_name varchar(20),
    PRIMARY KEY (tag_id),
    CONSTRAINT tag_reference
        FOREIGN KEY (post_id) REFERENCES Posts (post_id)
);

CREATE TABLE IF NOT EXISTS Likes (
    like_id int NOT NULL AUTO_INCREMENT,
    liker varchar(20) NOT NULL,
    post_id int NOT NULL,
    PRIMARY KEY (like_id),
    CONSTRAINT username_reference2
        FOREIGN KEY (liker) REFERENCES Accounts (username),
    CONSTRAINT post_id_reference
        FOREIGN KEY (post_id) REFERENCES Posts (post_id)
);

CREATE TABLE IF NOT EXISTS Comments (
    comment_id int NOT NULL AUTO_INCREMENT,
    commenter varchar(20) NOT NULL,
    post_id int NOT NULL,
    content varchar(200),
    comment_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (comment_id),
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
    recipe_name varchar(80),
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
    ingredient_name varchar(50) NOT NULL,
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
INSERT INTO Accounts (username, pword, first_name, last_name, bio, email_address, phone_number)
VALUES
('jdoe', 'P@ssw0rd', 'John', 'Doe', 'Software engineer, coffee lover, and avid runner.', 'jdoe@email.com', '4555551234'),
('msmith', 'S3cur3Pwd', 'Megan', 'Smith', 'Marketing professional, amateur chef, and dog enthusiast.', 'msmith@email.com', '5935555678'),
('jlee', 'Pa$$word1', 'Jennifer', 'Lee', 'Designer, bookworm, and coffee snob.', 'jlee@email.com', '5551559012'),
('khan', 'P@ss123', 'Kamal', 'Hassan', 'Actor, writer, and film director. Dedicated to promoting education and social justice.', 'khan@email.com', '8885553456'),
('rwilliams', 'W1lliam5', 'Rachel', 'Williams', 'Journalist, adventurer, and environmentalist.', 'rwilliams@email.com', '8395557890'),
('tjohnson', 'Passw0rd!', 'Tyler', 'Johnson', 'Aspiring musician, passionate about travel and learning new languages.', 'tjohnson@email.com', '2125552345'),
('jrobinson', 'Robinson123', 'Jessica', 'Robinson', 'Social worker, community organizer, and advocate for social justice.', 'jrobinson@email.com', '5505956789'),
('klee', 'Klee1234', 'Kevin', 'Lee', 'Investor, entrepreneur, and technology enthusiast.', 'klee@email.com', '5115550123'),
('mgarcia', 'Garcia123', 'Maria', 'Garcia', 'Artist, activist, and environmentalist.', 'mgarcia@email.com', '5250554567'),
('jthomas', 'Thomas456', 'James', 'Thomas', 'Engineer, innovator, and technology evangelist.', 'jthomas@email.com', '2355558901'),
('ahernandez', 'Hernandez1', 'Ana', 'Hernandez', 'Educator, researcher, and advocate for immigrant rights.', 'ahernandez@email.com', '5551552945'),
('bchen', 'Chen1234', 'Brian', 'Chen', 'Investor, entrepreneur, and technology enthusiast.', 'bchen@email.com', '5555556789'),
('jwang', 'Wang1234', 'Jennifer', 'Wang', 'Designer, artist, and photographer. Passionate about creating beautiful and functional products.', 'jwang@email.com', '5555550123'),
('rpatel', 'Patel123', 'Raj', 'Patel', 'Doctor, humanitarian, and advocate for public health.', 'rpatel@email.com', '5830554567'),
('slee', 'Lee12345', 'Samantha', 'Lee', 'Software engineer, gamer, and anime enthusiast.', 'slee@email.com', '5558558901'),
('jrivera', 'Rivera123', 'Juan', 'Rivera', 'Lawyer, activist, and advocate for civil rights.', 'jrivera@email.com', '1555552345'),
('klam', 'Lam12345', 'Karen', 'Lam', 'Marketing professional, fashionista, and foodie.', 'klam@email.com', '4567358934'),
('mjones', 'Jones123', 'Michael', 'Jones', 'Entrepreneur, investor, and fitness enthusiast.', 'mjones@email.com', '5555551234'),
('ssmith', 'Smith456', 'Sarah', 'Smith', 'UX designer, coffee addict, and travel enthusiast.', 'ssmith@email.com', '6555515678'),
('dlee', 'Lee456', 'David', 'Lee', 'Product manager, avid cyclist, and music lover.', 'dlee@email.com', '5555559012'),
('mturner', 'Turner123', 'Megan', 'Turner', 'Writer, storyteller, and lover of all things sci-fi and fantasy.', 'mturner@email.com', '5545553456'),
('jmorris', 'Morris123', 'Jessica', 'Morris', 'Social media manager, food blogger, and cat lover.', 'jmorris@email.com', '5509557890'),
('kjohnson', 'Johnson123', 'Katherine', 'Johnson', 'Researcher, data scientist, and advocate for women in tech.', 'kjohnson@email.com', '5255552345'),
('bthomas', 'Thomas123', 'Benjamin', 'Thomas', 'Software developer, gamer, and board game enthusiast.', 'bthomas@email.com', '5555056789'),
('jjackson', 'Jackson456', 'Julia', 'Jackson', 'Writer, editor, and lover of all things books and literature.', 'jjackson@email.com', '5885950123'),
('arobinson', 'Robinson456', 'Alex', 'Robinson', 'Graphic designer, artist, and traveler.', 'arobinson@email.com', '5955554567'),
('hhernandez', 'Hernandez123', 'Hector', 'Hernandez', 'Chef, food critic, and lover of all things culinary.', 'hhernandez@email.com', '5505558901'),
('ssanchez', 'Sanchez456', 'Sofia', 'Sanchez', 'Marketing professional, fashion enthusiast, and blogger.', 'ssanchez@email.com', '5595552345'),
('tnguyen', 'Nguyen123', 'Trang', 'Nguyen', 'Product manager, traveler, and lover of all things outdoors.', 'tnguyen@email.com', '5545556789'),
('swhite', 'White123', 'Stephanie', 'White', 'Engineer, innovator, and technology enthusiast.', 'swhite@email.com', '5585550123'),
('mjackson', 'Jackson123', 'Marcus', 'Jackson', 'Entrepreneur, investor, and fitness enthusiast.', 'mjackson@email.com', '5555554567'),
('bdavis', 'Davis456', 'Bethany', 'Davis', 'Researcher, data scientist, and advocate for women in tech.', 'bdavis@email.com', '5555558901'),
('jlai', 'Lai123', 'Jennifer', 'Lai', 'Designer, artist, and photographer. Passionate about creating beautiful and functional products.', 'jlai@email.com', '5555552345'),
('skim', 'Kim123', 'Samantha', 'Kim', 'Lawyer, activist, and advocate for civil rights.', 'skim@email.com', '5505586789'),
('jkim', 'Kim456', 'Jonathan', 'Kim', 'Doctor, humanitarian, and advocate for public health.', 'jkim@email.com', '3457890126');

-- nagiaboushaca : 0 followers, 2 following
-- wcolsey : 1 followers, 1 following
-- sena.szczepaniuk : 2 followers, 0 following
INSERT INTO FollowerRelationship
VALUES ('nagiaboushaca','wcolsey');

INSERT INTO FollowerRelationship
VALUES ('nagiaboushaca','sena.szczepaniuk');

INSERT INTO FollowerRelationship
VALUES ('wcolsey','sena.szczepaniuk');

INSERT INTO FollowerRelationship
VALUES
('tnguyen', 'bdavis'),
('slee', 'jmorris'),
('jwang', 'jmorris'),
('bchen', 'ahernandez'),
('jdoe', 'jkim'),
('skim', 'jkim'),
('rwilliams', 'skim'),
('hhernandez', 'jdoe'),
('dlee', 'jkim'),
('mjones', 'wcolsey'),
('msmith', 'jkim'),
('msmith', 'jjackson'),
('mgarcia', 'jjackson'),
('jjackson', 'tnguyen'),
('rwilliams', 'ssanchez'),
('khan', 'ssanchez'),
('ssanchez', 'mgarcia'),
('jrivera', 'jkim'),
('dlee', 'jjackson'),
('hhernandez', 'dlee'),
('dlee', 'hhernandez'),
('bchen', 'jdoe'),
('jwang', 'rwilliams'),
('jwang', 'skim'),
('jlai', 'jwang'),
('wcolsey', 'msmith'),
('swhite', 'sena.szczepaniuk'),
('jthomas', 'jkim'),
('jthomas', 'tnguyen'),
('kjohnson', 'mturner'),
('mturner', 'jjackson'),
('mturner', 'ssanchez'),
('slee', 'rwilliams'),
('rwilliams', 'bchen'),
('bchen', 'jrivera'),
('swhite', 'dlee'),
('swhite', 'mturner'),
('jwang', 'swhite'), 
('jrobinson', 'skim'),
('jrobinson', 'ssanchez'),
('jrobinson', 'jlai');


INSERT INTO Posts (poster, caption, post_time)
VALUES ('nagiaboushaca',
        'I wanted to share this pasta recipe with you guys! Perfect for a quick lunch!',
        CURRENT_TIMESTAMP);
INSERT INTO Posts (poster, caption, post_time)
VALUES ('wcolsey',
        'I LOVE making Beef Stroganoff, so I wanted to shore with you all my *secret!* family recipe :)',
        CURRENT_TIMESTAMP);
INSERT INTO Posts (poster, caption, post_time)
VALUES ('sena.szczepaniuk',
        'PB&J for hard times',
        CURRENT_TIMESTAMP);
INSERT INTO Posts (poster, caption, post_time)
VALUES ('bthomas',
        'my moms recipe!',
        CURRENT_TIMESTAMP),
        ('jlee',
        'just whipped this up, its fire',
        CURRENT_TIMESTAMP),
        ('mjones',
        'wanted to shareeee',
        CURRENT_TIMESTAMP),
        ('mgarcia',
        'my toddler loves this',
        CURRENT_TIMESTAMP),
        ('wcolsey',
        'im trying to be healthier',
        CURRENT_TIMESTAMP),
        ('ssanchez',
        'this helped me lose a ton of weight',
        CURRENT_TIMESTAMP),
        ('dlee',
        'my house smelled AMAZING after making this',
        CURRENT_TIMESTAMP),
        ('jdoe',
        'yummmm',
        CURRENT_TIMESTAMP),
        ('nagiaboushaca',
        'woowwwwww',
        CURRENT_TIMESTAMP),
        ('rpatel',
        'i hope this is good!!!',
        CURRENT_TIMESTAMP),
        ('mturner',
        'Something we used to make a lot in my restaurant.',
        CURRENT_TIMESTAMP),
        ('jmorris',
        'taco night :)))',
        CURRENT_TIMESTAMP),
        ('swhite',
        'my cats favorite',
        CURRENT_TIMESTAMP),
        ('mjackson',
        'final meal',
        CURRENT_TIMESTAMP),
        ('bchen',
        'heheheh',
        CURRENT_TIMESTAMP),
        ('jrobinson',
        'theres a lot of protein in this',
        CURRENT_TIMESTAMP),
        ('jwang',
        'i usually dont like feta but this was so good',
        CURRENT_TIMESTAMP),
        ('klee',
        'im not japanese',
        CURRENT_TIMESTAMP),
        ('jrivera',
        'A classic in my household, the husband loves this!',
        CURRENT_TIMESTAMP),
        ('tnguyen',
        'tuna is the BEST!',
        CURRENT_TIMESTAMP),
        ('kjohnson',
        'souuuuppp',
        CURRENT_TIMESTAMP),
        ('sena.szczepaniuk',
        'sooo aromaticccc',
        CURRENT_TIMESTAMP),
        ('ahernandez',
        'i love CHICKEN!',
        CURRENT_TIMESTAMP),
        ('rwilliams',
        'theres no way a vegetable fried this rice',
        CURRENT_TIMESTAMP),
        ('khan',
        'mama mia',
        CURRENT_TIMESTAMP),
        ('ssmith',
        'SPICY!!!!!!',
        CURRENT_TIMESTAMP),
        ('slee',
        'NOT HALAL!',
        CURRENT_TIMESTAMP),
        ('tjohnson',
        'weeeee',
        CURRENT_TIMESTAMP),
        ('jjackson',
        'my mother is mexican and she loved making this when i was little',
        CURRENT_TIMESTAMP),
        ('kjohnson',
        'i love asian food',
        CURRENT_TIMESTAMP),
        ('bchen',
        'souppyyyy',
        CURRENT_TIMESTAMP),
        ('wcolsey',
        'KASJGAJKSBFGJKA',
        CURRENT_TIMESTAMP),
        ('nagiaboushaca',
        'make this in foil and its soooo good',
        CURRENT_TIMESTAMP),
        ('mgarcia',
        'sooo yummyyy',
        CURRENT_TIMESTAMP),
        ('jdoe',
        'trying to discover myself using this soup',
        CURRENT_TIMESTAMP),
        ('jwang',
        'SOOOO GOOD!!!!',
        CURRENT_TIMESTAMP),
        ('jwang',
        'SOOOO mf GOOD!!!!',
        CURRENT_TIMESTAMP),
        ('mgarcia',
        'yummylicious',
        CURRENT_TIMESTAMP),
        ('jdoe',
        'broooo on god u pmo',
        CURRENT_TIMESTAMP);



INSERT INTO Tags (post_id, tag_name)
VALUES (1, '#cheesy');
INSERT INTO Tags (post_id, tag_name)
VALUES (1, '#quicklunch');
INSERT INTO Tags (post_id, tag_name)
VALUES (2, '#hearty');
INSERT INTO Tags (post_id, tag_name)
VALUES (2, '#juicy');
INSERT INTO Tags (post_id, tag_name)
VALUES (3, '#depressionmeal');
INSERT INTO Tags (post_id, tag_name)
VALUES (3, '#college');


-- Post_id: 1, Num_Likes: 2
-- Post_id: 2, Num_Likes: 2
-- Post_id: 3, Num_Likes: 1
INSERT INTO Likes (liker, post_id)
VALUES ('nagiaboushaca', 1);
INSERT INTO Likes (liker, post_id)
VALUES ('nagiaboushaca', 2);
INSERT INTO Likes (liker, post_id)
VALUES ('nagiaboushaca', 3);
INSERT INTO Likes (liker, post_id)
VALUES ('wcolsey', 2);
INSERT INTO Likes (liker, post_id)
VALUES ('sena.szczepaniuk', 1);


-- Post_id: 1, Num_Comments: 2
-- Post_id: 2, Num_Comments: 1
-- Post_id: 3, Num_Comments: 1
INSERT INTO Comments (commenter, post_id, content, comment_time)
VALUES ('nagiaboushaca',
        1,
        'Like and follow for more content!',
        CURRENT_TIMESTAMP);
INSERT INTO Comments (commenter, post_id, content, comment_time)
VALUES ('wcolsey',
        3,
        'pb&j never really whetted my tastebuds, but this is rad!!',
        CURRENT_TIMESTAMP);
INSERT INTO Comments (commenter, post_id, content, comment_time)
VALUES ('sena.szczepaniuk',
        2,
        'Nice Beef Stroganoff',
        CURRENT_TIMESTAMP);
INSERT INTO Comments (commenter, post_id, content, comment_time)
VALUES ('sena.szczepaniuk',
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
 INSERT INTO Cuisines
 VALUES (6, 'Indian');
 INSERT INTO Cuisines
 VALUES (7, 'Thai');
 INSERT INTO Cuisines
 VALUES (8, 'European');
 INSERT INTO Cuisines
 VALUES (9, 'Mexican');
 INSERT INTO Cuisines
 VALUES (10, 'African');

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

INSERT INTO Recipes
Values (4, 'Creamy Mushroom Risotto',
        '1. In a large pot, heat the olive oil over medium heat. Add the onion and cook until softened, about 5 minutes. Add the mushrooms and cook until browned, about 10 minutes.
         2. Add the rice and cook for 1-2 minutes, stirring constantly. Add the wine and cook until the liquid is absorbed, stirring constantly.
         3. Add the broth, 1/2 cup at a time, stirring constantly and waiting until each addition is absorbed before adding more.
         4. Stir in the parmesan cheese, butter, and parsley. Season with salt and pepper to taste.',
         40,
         3,
         4,
         500,
         2);

INSERT INTO Recipes
Values (6, 'Spicy Thai Green Curry',
        '1. In a large pot, heat the olive oil over medium heat. Add the onion and cook until softened, about 5 minutes. Add the mushrooms and cook until browned, about 10 minutes.
         2. Add the rice and cook for 1-2 minutes, stirring constantly. Add the wine and cook until the liquid is absorbed, stirring constantly.
         3. Add the broth, 1/2 cup at a time, stirring constantly and waiting until each addition is absorbed before adding more.
         4. Stir in the parmesan cheese, butter, and parsley. Season with salt and pepper to taste.',
         40,
         3,
         4,
         500,
         2);

INSERT INTO Recipes
Values (7, 'Classic Beef Stroganoff',
        '1. In a large skillet, heat the butter over medium heat. Add the onions and cook until softened, about 5 minutes. Add the mushrooms and cook until browned, about 10 minutes.
         2. Add the beef and cook until browned on all sides, about 5 minutes.
         3. Stir in the flour and cook for 1 minute. Add the beef broth, mustard, and Worcestershire sauce. Bring to a boil, then reduce heat and simmer for 15-20 minutes.
         4. Stir in the sour cream and heat through, but do not boil.
         5. Serve with noodles or rice.',
         45,
         3,
         4,
         700,
         1);

INSERT INTO Recipes
Values (8, 'Crispy Baked Chicken Tenders',
         '1. Preheat oven to 400°F. Line a baking sheet with parchment paper.
          2. Combine the breadcrumbs, parmesan cheese, garlic powder, salt, and pepper in a shallow dish.
          3. Place the beaten eggs in another shallow dish.
          4. Dip each chicken tender in the egg mixture, then coat in the breadcrumb mixture. Place on the prepared baking sheet.
          5. Bake for 15-20 minutes, or until golden brown and crispy.',
          25,
          2,
          4,
          400,
          8);

INSERT INTO Recipes
Values (9, 'Roasted Vegetable Quinoa Bowl',
         '1. Preheat oven to 425°F. Line a baking sheet with parchment paper.
          2. Toss the vegetables with olive oil and season with salt and pepper. Place on the prepared baking sheet.
          3. Roast for 20-25 minutes, or until tender and golden brown.
          4. Meanwhile, cook the quinoa',
          30,
          2,
          3,
          300,
          6);

INSERT INTO Recipes
Values (10, 'Thai Basil Chicken Stir-Fry',
         '1. Heat oil in a wok. Add chicken and stir-fry until browned.
          2. Add garlic, chili, and onion. Cook for 1-2 minutes.
          3. Add peppers and stir-fry for another minute.
          4. Add basil, fish sauce, and sugar.
          5. Serve with rice.',
          20,
          3,
          2,
          450,
          6);

INSERT INTO Recipes
Values (11, 'Baked Honey Mustard Salmon',
        '1. Preheat oven to 400°F.
        2. In a small bowl, mix mustard, honey, and garlic.
        3. Place salmon on a baking sheet lined with parchment paper.
        4. Brush salmon with the mustard mixture.
        5. Bake for 12-15 minutes, or until cooked through.',
        20,
        2,
        4,
        350,
        9);

INSERT INTO Recipes
Values (12, 'Mushroom and Spinach Quiche',
        '1. Preheat oven to 375°F.
         2. Roll out pie crust and place in a 9-inch pie dish.
         3. In a skillet, cook mushrooms until tender. Add spinach and cook until wilted.
         4. In a bowl, whisk eggs, milk, salt, and pepper.
         5. Pour egg mixture into the pie crust. Top with mushroom and spinach mixture.
         6. Bake for 30-35 minutes, or until set.',
         40,
         3,
         6,
         400,
         3);

INSERT INTO Recipes
Values (13, 'Slow Cooker Beef Stew',
         '1. In a slow cooker, combine beef, potatoes, carrots, onions, and garlic.
          2. In a separate bowl, whisk together beef broth, tomato paste, Worcestershire sauce, thyme, and bay leaves. Pour over beef and vegetables.
          3. Cover and cook on low for 6-8 hours.
          4. Stir in frozen peas and cook for an additional 10-15 minutes.
          5. Serve with bread.',
          480,
          4,
          6,
          500,
          1);

INSERT INTO Recipes
Values (14, 'Caprese Salad with Balsamic Glaze',
        '1. In a small saucepan, bring balsamic vinegar to a boil. Reduce heat and simmer until reduced and thickened.
         2. Layer sliced tomatoes and mozzarella on a plate.
         3. Drizzle with olive oil and sprinkle with salt and pepper.
         4. Drizzle with balsamic glaze.
         5. Garnish with fresh basil leaves.',
         10,
         1,
         2,
         250,
         2);

INSERT INTO Recipes
Values (15, 'Beef and Broccoli Stir-Fry',
         '1. Marinate sliced beef in soy sauce and cornstarch for 15 minutes.
          2. In a wok, heat oil and stir-fry beef until browned.
          3. Add garlic and ginger and cook for 1-2 minutes.
          4. Add broccoli and stir-fry for another 2-3 minutes.
          5. Add oyster sauce and water. Cook until the sauce thickens.
          6. Serve with rice.',
          25,
          2,
          3,
          400,
          2);

INSERT INTO Recipes
Values (16, 'Greek Salad',
         'Mix tomatoes, cucumber, red onion, olives, and feta cheese. Drizzle with olive oil and lemon juice.',
          15,
           1,
           2,
         200,
           1);

INSERT INTO Recipes
Values (17, 'Beef Tacos',
         'Cook ground beef with taco seasoning. Serve in taco shells with lettuce, tomato, cheese, and sour cream.',
          25,
           2,
           4,
         400,
           2);

INSERT INTO Recipes
Values (18, 'Butternut Squash Soup',
         'Roast butternut squash, onion, and garlic. Blend with vegetable broth, cream, and spices. Heat and serve.',
          40,
           3,
           4,
         300,
           3);

INSERT INTO Recipes
Values (19, 'Grilled Pork Chops',
         'Season pork chops with salt and pepper. Grill until cooked. Serve with grilled vegetables.',
          30,
           2,
           2,
         350,
           5);

INSERT INTO Recipes
Values (20, 'Chicken Alfredo',
        'Cook chicken in a pan with garlic and butter. Add heavy cream and parmesan cheese. Toss with cooked pasta.',
         35,
          3,
          4,
        450,
          6);

INSERT INTO Recipes
Values (21, 'Falafel Wrap',
         'Mix chickpeas, onion, garlic, and spices in a food processor. Form into patties and fry. Serve in a wrap with hummus and veggies.',
          50,
           4,
           2,
         400,
          7);

INSERT INTO Recipes
Values (22, 'Shrimp Scampi',
         'Cook shrimp in a pan with garlic and butter. Toss with cooked pasta, lemon juice, and parmesan cheese.',
          25,
           3,
           2,
         400,
          8);

INSERT INTO Recipes
Values (23, 'Spinach and Feta Stuffed Chicken',
        'Pound chicken breasts thin. Stuff with spinach and feta cheese. Bake until cooked.',
        40,
        4,
        2,
        400,
        9);

INSERT INTO Recipes
Values (24, 'Sushi Rolls',
        'Lay out nori sheets. Add sushi rice, avocado, cucumber, and crab meat. Roll tightly and cut into pieces.',
        60,
        5,
        4,
        300,
        10);

INSERT INTO Recipes
Values (25, 'Vegetable Stir-Fry',
         'Cook vegetables in a wok with soy sauce and ginger. Serve with rice or noodles.',
          20,
           2,
           3,
         250,
          1);

INSERT INTO Recipes
Values (26, 'Tuna Salad',
        'Mix canned tuna, celery, red onion, and mayo. Serve over lettuce or in a sandwich.',
         10,
         1,
         2,
         200,
         2);

INSERT INTO Recipes
Values (27, 'Lentil Soup',
        'Cook lentils, carrots, and celery in a pot with vegetable broth and spices. Serve hot.',
         30,
         2,
         4,
         300,
         3);

INSERT INTO Recipes
Values (28, 'Beef Stew',
        'Brown beef in a pot with onions and garlic. Add potatoes, carrots, and beef broth. Simmer until cooked.',
        60,
        4,
        4,
        500,
        4);

INSERT INTO Recipes
Values (29, 'Chicken Fajitas',
         '1. In a large skillet, heat olive oil over medium-high heat.
          2. Add chicken and cook until browned and cooked through.
          3. Remove chicken from skillet and set aside.
          4. Add bell peppers and onion to the skillet and cook until softened.
          5. Add garlic and cook for 1 minute.
          6. Add chicken back to skillet with cumin, chili powder, and salt.
          7. Stir to combine.
          8. Serve hot with tortillas, salsa, and sour cream.',
           25,
            3,
            4,
          450,
           6);

INSERT INTO Recipes
Values (30, 'Vegetable Fried Rice',
         '1. In a large skillet or wok, heat sesame oil over medium-high heat.
          2. Add onion, garlic, and ginger and stir-fry for 2-3 minutes.
          3. Add carrots and peas and stir-fry for 1-2 minutes.
          4. Add cooked rice to the skillet and stir-fry for 2-3 minutes.
          5. Push the rice to the side of the skillet and add the beaten eggs to the empty space.
          6. Scramble the eggs and then stir them into the rice mixture.
          7. Add soy sauce and stir to combine. 8. Serve hot.',
          25,
          2,
          4,
          300,
          8);

INSERT INTO Recipes
Values (31, 'Pesto Pasta',
         '1. Cook pasta according to package instructions.
          2. Meanwhile, in a food processor, combine basil, garlic, pine nuts, and Parmesan cheese.
          3. Pulse until finely chopped.
          4. With the food processor running, slowly pour in olive oil until the mixture is smooth.
          5. Drain pasta and return it to the pot.
          6. Add pesto sauce and stir to combine.
          7. Serve hot with additional Parmesan cheese, if desired.',
           20,
            2,
            4,
          400,
           2);

INSERT INTO Recipes
Values (32, 'Mediterranean Stuffed Peppers',
         '1. Preheat the oven to 375°F.
          2. Cut the tops off of the bell peppers and remove the seeds and membranes.
          3. In a large skillet, heat the olive oil over medium-high heat.
          4. Add the onion, garlic, and tomato and cook until softened.
          5. Add the ground turkey and cook until browned.
          6. Stir in the cooked rice, spinach, and feta cheese.
          7. Spoon the mixture into the bell peppers.
          8. Place the stuffed peppers in a baking dish and bake for 25-30 minutes.',
          45,
           3,
           4,
         300,
           8);

INSERT INTO Recipes
Values (33, 'Pulled Pork Sandwiches',
         '1. Preheat the oven to 325°F.
          2. Rub the pork shoulder with the dry rub seasoning.
          3. Place the pork shoulder in a large baking dish and cover with foil.
          4. Bake for 3-4 hours, or until the pork is tender and pulls apart easily with a fork.
          5. Remove the pork from the baking dish and shred with two forks.
          6. In a large skillet, heat the barbecue sauce over medium-high heat.
          7. Add the shredded pork to the skillet and stir to coat with the sauce.
          8. Serve hot on hamburger buns.',
          240,
          3,
          6,
          600,
          1);

INSERT INTO Recipes
Values (34, 'Spaghetti Carbonara',
         '1. Cook the spaghetti according to package instructions.
          2. Meanwhile, in a large skillet, cook the bacon over medium heat until crisp.
          3. Remove the bacon from the skillet and set aside.
          4. In a small bowl, whisk together the eggs, Parmesan cheese, salt, and pepper.
          5. Drain the spaghetti and reserve 1 cup of the pasta water.
          6. Add the spaghetti to the skillet with the bacon grease and toss to coat.
          7. Remove the skillet from the heat and pour in the egg mixture, tossing quickly to combine.
          8. Add pasta water as needed to thin out the sauce.
          9. Serve hot, garnished with additional Parmesan cheese and chopped parsley.',
          25,
          3,
          4,
          500,
          2);

INSERT INTO Recipes
Values (35, 'Chicken Enchiladas',
         '1. Preheat the oven to 350°F.
          2. In a large skillet, heat the oil over medium-high heat.
          3. Add the chicken and cook until browned.
          4. Remove the chicken from the skillet and set aside.
          5. Add the onion, garlic, and jalapeño to the skillet and cook until softened.
          6. Stir in the enchilada sauce, black beans, and corn.
          7. Add the chicken back',
          45,
          3,
          3,
          600,
          3);

INSERT INTO Recipes
Values (36, 'Miso Soup',
         '1. In a large saucepan, bring water to a boil.
          2. Reduce heat to low and whisk in miso paste.
          3. Add tofu, mushrooms, and green onions.
          4. Simmer for 5-10 minutes.
          5. Serve hot.',
          15,
           1,
           2,
         100,
          10);

INSERT INTO Recipes
Values (37, 'Beef and Bean Chili',
         '1. In a large pot or Dutch oven, cook ground beef over medium heat until browned.
          2. Add chopped onions, minced garlic, and chopped bell peppers and cook until vegetables are soft.
          3. Add canned diced tomatoes, canned kidney beans, tomato paste, and chili powder.
          4. Bring to a boil, then reduce heat and simmer for 30 minutes.
          5. Serve hot with shredded cheddar cheese, sour cream, and chopped green onions.',
           45,
            2,
            6,
          500,
            3);

INSERT INTO Recipes
Values (38, 'Spicy Chicken Curry',
         '1. In a large skillet or Dutch oven, heat oil over medium heat.
          2. Add chopped onions and cook until translucent.
          3. Add minced garlic and ginger and cook for 1 minute.
          4. Add chopped chicken breast and cook until browned.
          5. Stir in curry powder, garam masala, and cayenne pepper.
          6. Add canned diced tomatoes, coconut milk, and chicken broth.
          7. Bring to a boil, then reduce heat and simmer for 20-25 minutes.
          8. Serve hot over rice or with naan bread.',
          35,
          3,
          4,
          400,
          4);

INSERT INTO Recipes
Values (39, 'Grilled Teriyaki Salmon',
         '1. In a small bowl, whisk together soy sauce, brown sugar, minced garlic, and grated ginger to make a marinade.
          2. Place salmon fillets in a resealable plastic bag and pour marinade over them.
          3. Marinate in the fridge for at least 30 minutes.
          4. Preheat grill to medium-high heat.
          5. Grill salmon for 5-7 minutes per side or until cooked through.
          6. Serve hot with rice and steamed vegetables.',
          40,
          3,
          4,
          400,
          9);

INSERT INTO Recipes
Values (40, 'Spicy Shrimp Tacos',
         '1. In a large skillet, heat oil over medium-high heat.
          2. Add peeled and deveined shrimp and cook until pink.
          3. Remove shrimp from skillet and set aside.
          4. In the same skillet, sauté sliced bell peppers and chopped onions until soft.
          5. Add minced garlic and cook for 1 minute.
          6. Stir in chili powder, cumin, and paprika.
          7. Return shrimp to skillet and toss everything together.
          8. Warm up corn tortillas and fill with shrimp mixture.
          9. Top with sliced avocado and chopped cilantro.
          10. Serve hot.',
          30,
           3,
           6,
         400,
           8);

INSERT INTO Recipes
Values (41, 'Vegetarian Lentil Soup',
         '1. In a large pot, heat oil over medium heat.
          2. Add chopped onions, minced garlic, and chopped carrots and cook until soft.
          3. Add dried lentils, canned diced tomatoes, vegetable broth, and dried thyme.
          4. Bring to a boil, then reduce heat and simmer for 30-40 minutes or until lentils are tender.
          5. Serve hot with a dollop of sour cream and chopped fresh parsley.',
           50,
            2,
            6,
          300,
            2);

INSERT INTO Recipes
Values (5, 'Pork Tenderloin with Apple Chutney',
         '1. Preheat oven to 400°F.
          2. Rub pork tenderloin with olive oil and sprinkle with salt and pepper.
          3. Place tenderloin in a roasting pan and roast for 25-30 minutes or until cooked through.
          4. Let the pork rest for 10 minutes before slicing.
          5. In a small saucepan, combine chopped apples, chopped onion, apple cider vinegar, brown sugar, cinnamon, and a pinch of salt.
          6. Cook over medium heat until the mixture thickens, stirring occasionally.
          7. Serve the sliced pork tenderloin with the apple chutney on top.',
          40,
           3,
           4,
         400,
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
INSERT INTO Ingredients
VALUES ('Flour', 12, 3, 1.5, 'cups');
INSERT INTO Ingredients
VALUES ('Sugar', 12, 3, 1, 'cup');
INSERT INTO Ingredients
VALUES ('Baking Powder', 12, 3, 1, 'tbsp');
INSERT INTO Ingredients
VALUES ('Salt', 12, 3, 0.5, 'tsp');
INSERT INTO Ingredients
VALUES('Milk', 12, 3, 1, 'cup');
INSERT INTO Ingredients
VALUES('Egg', 12, 3, 1, 'large');
INSERT INTO Ingredients
VALUES('Butter', 12, 3, 0.5, 'cup');
INSERT INTO Ingredients
VALUES('Vanilla Extract', 12, 3, 1, 'tsp');
INSERT INTO Ingredients
VALUES('Chocolate Chips', 12, 3, 1.5, 'cups');
INSERT INTO Ingredients
VALUES('Ground Beef', 22, 1, 1, 'lb');
INSERT INTO Ingredients
VALUES('Onion', 22, 1, 1, 'medium');
INSERT INTO Ingredients
VALUES('Garlic', 22, 1, 2, 'cloves');
INSERT INTO Ingredients
VALUES('Tomato Sauce', 22, 1, 1, 'can');
INSERT INTO Ingredients
VALUES('Water', 22, 1, 1.5, 'cups');
INSERT INTO Ingredients
VALUES('Spaghetti', 22, 1, 12, 'oz');
INSERT INTO Ingredients
VALUES('Mozzarella Cheese', 22, 1, 2, 'cups');
INSERT INTO Ingredients
VALUES('Rock salt', 22, 1, 1, 'tsp');
INSERT INTO Ingredients
VALUES('Black Pepper', 22, 1, 0.5, 'tsp');
INSERT INTO Ingredients
VALUES('Olive Oil', 22, 1, 2, 'tbsp');
INSERT INTO Ingredients
VALUES('Lemon Juice', 17, 2, 2, 'tbsp');
INSERT INTO Ingredients
VALUES('Olive Oil', 17, 2, 1, 'tbsp');
INSERT INTO Ingredients
VALUES('Garlic', 17, 2, 2, 'cloves');
INSERT INTO Ingredients
VALUES('Parsley', 17, 2, 2, 'tbsp');
INSERT INTO Ingredients
VALUES('Salt', 17, 2, 1, 'tsp');
INSERT INTO Ingredients
VALUES('Black Pepper', 17, 2, 0.5, 'tsp');
INSERT INTO Ingredients
VALUES('Chicken Breasts', 17, 2, 2, 'lbs');
INSERT INTO Ingredients
VALUES('Bell Pepper', 17, 2, 1, 'medium');
INSERT INTO Ingredients
VALUES('Onion', 17, 2, 1, 'medium');
INSERT INTO Ingredients
VALUES('Zucchini', 17, 2, 1, 'medium');
INSERT INTO Ingredients
VALUES('Yellow Squash', 17, 2, 1, 'medium');
INSERT INTO Ingredients
VALUES('Olive Oil', 17, 2, 2, 'tbsp');
INSERT INTO Ingredients
VALUES('Cumin', 17, 2, 1, 'tsp');
INSERT INTO Ingredients
VALUES('Paprika', 17, 2, 1, 'tsp');
INSERT INTO Ingredients
VALUES('Chili Powder', 17, 2, 1, 'tsp');
INSERT INTO Ingredients
VALUES('Salt', 17, 2, 1, 'tsp');
INSERT INTO Ingredients
VALUES('Black Pepper', 17, 2, 0.5, 'tsp');
INSERT INTO Ingredients
VALUES('Tortilla Chips', 17, 2, 2, 'cups');
INSERT INTO Ingredients
VALUES('Cheddar Cheese', 17, 2, 1, 'cup');
INSERT INTO Ingredients
VALUES('Monterey Jack Cheese', 17, 2, 1, 'cup');
INSERT INTO Ingredients (ingredient_name, recipe_id, category_id, amount, unit)
VALUES
  ('Ground Beef', 5, 1, 1, 'lb'),
  ('Onion', 5, 1, 1, 'medium'),
  ('Garlic', 5, 1, 2, 'cloves'),
  ('Tomato Sauce', 5, 1, 1, 'can'),
  ('Water', 5, 1, 1.5, 'cups'),
  ('Spaghetti', 5, 1, 12, 'oz'),
  ('Mozzarella Cheese', 5, 1, 2, 'cups'),
  ('Salt', 5, 1, 1, 'tsp'),
  ('Black Pepper', 5, 1, 0.5, 'tsp'),
  ('Olive Oil', 5, 1, 2, 'tbsp'),
  ('Boneless Chicken Breasts', 8, 2, 4, 'pieces'),
  ('Bell Pepper', 8, 2, 1, 'large'),
  ('Onion', 8, 2, 1, 'large'),
  ('Zucchini', 8, 2, 1, 'medium'),
  ('Yellow Squash', 8, 2, 1, 'medium'),
  ('Olive Oil', 8, 2, 3, 'tbsp'),
  ('Cumin', 8, 2, 1, 'tsp'),
  ('Paprika', 8, 2, 1, 'tsp'),
  ('Chili Powder', 8, 2, 1, 'tsp'),
  ('Salt', 8, 2, 1, 'tsp'),
  ('Black Pepper', 8, 2, 0.5, 'tsp'),
  ('Tortilla Chips', 8, 2, 2, 'cups'),
  ('Cheddar Cheese', 8, 2, 1, 'cup'),
  ('Monterey Jack Cheese', 8, 2, 1, 'cup'),
  ('Sour Cream', 8, 2, 1, 'cup'),
  ('Salsa', 8, 2, 1, 'cup'),
  ('Lemon', 19, 4, 1, 'medium'),
  ('Orange', 19, 4, 1, 'medium'),
  ('Grapefruit', 19, 4, 1, 'medium'),
  ('Honey', 19, 4, 2, 'tbsp'),
  ('Fresh Mint Leaves', 19, 4, 2, 'tbsp'),
  ('Ice', 19, 4, 2, 'cups'),
  ('Boneless Skinless Chicken Breasts', 24, 6, 4, 'pieces'),
  ('Soy Sauce', 24, 6, 1, 'tbsp'),
  ('Sesame Oil', 24, 6, 1, 'tbsp'),
  ('Garlic', 24, 6, 2, 'cloves'),
  ('Ginger', 24, 6, 1, 'tbsp'),
  ('Brown Sugar', 24, 6, 2, 'tbsp'),
  ('Cornstarch', 24, 6, 1, 'tbsp'),
  ('Green Onion', 24, 6, 1, 'unit'),
  ('Russet Potato', 1, 1, 4, 'medium'),
  ('Butter', 1, 1, 3, 'tbsp'),
  ('Milk', 1, 1, 0.5, 'cup'),
  ('Salt', 1, 1, 1, 'tsp'),
  ('Black Pepper', 1, 1, 0.5, 'tsp'),
  ('Garlic Powder', 1, 1, 0.5, 'tsp'),
  ('Dried Basil', 1, 1, 0.5, 'tsp'),
  ('Shredded Cheddar Cheese', 1, 1, 1, 'cup'),
  ('Ground Beef', 2, 1, 1, 'lb'),
  ('Onion', 2, 1, 1, 'medium'),
  ('Green Bell Pepper', 2, 1, 1, 'medium'),
  ('Garlic', 2, 1, 2, 'cloves'),
  ('Tomato Sauce', 2, 1, 1, 'can'),
  ('Diced Tomatoes', 2, 1, 1, 'can'),
  ('Water', 2, 1, 1, 'cup'),
  ('Chili Powder', 2, 1, 1, 'tbsp'),
  ('Ground Cumin', 2, 1, 1, 'tsp'),
  ('Salt', 2, 1, 1, 'tsp'),
  ('Black Pepper', 2, 1, 0.5, 'tsp'),
  ('Corn Chips', 2, 1, 2, 'cups'),
  ('Shredded Cheddar Cheese', 2, 1, 1, 'cup'),
  ('Green Onion', 2, 1, 2, 'stalks'),
  ('Boneless Chicken Breasts', 3, 2, 4, 'pieces'),
  ('Butter', 3, 2, 4, 'tbsp'),
  ('Garlic', 3, 2, 3, 'cloves'),
  ('Lemon', 3, 2, 1, 'medium'),
  ('Chicken Broth', 3, 2, 1, 'cup'),
  ('Dried Oregano', 3, 2, 1, 'tsp'),
  ('Salt', 3, 2, 1, 'tsp'),
  ('Black Pepper', 3, 2, 0.5, 'tsp'),
  ('Fresh Parsley', 3, 2, 2, 'tbsp'),
  ('Boneless Pork Shoulder', 4, 2, 2, 'lbs'),
  ('Soy Sauce', 4, 2, 0.5, 'cup'),
  ('Hoisin Sauce', 4, 2, 0.5, 'cup'),
  ('Honey', 4, 2, 3, 'tbsp'),
  ('Rice Wine Vinegar', 4, 2, 2, 'tbsp'),
  ('Garlic', 4, 2, 2, 'cloves'),
  ('Ginger', 4, 2, 1, 'tbsp');

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
INSERT INTO Equipment
VALUES
('Tsp', 1),
('Chopping Knife', 2),
('Bowl', 3),
('Spatula', 4),
('Tbsp', 3),
('Measuring Cups', 5),
('Oven', 6),
('Grill', 7),
('Skillet', 8),
('Kettle', 8),
('Salt shaker', 8),
('Fork', 9),
('Big fork', 10),
('Whisk', 11),
('Mixing bowl', 12),
('Cups', 12),
('Tiny spoon', 13),
('Tiny fork', 14),
('Pyrex', 15),
('Container', 16),
('Aluminum foil', 17),
('Plastic wrap', 18),
('Parchment paper', 19),
('Toaster oven', 20),
('Microwave', 21),
('Sink', 22),
('Chopsticks', 23),
('Salad bowl', 24),
('Wooden serving utensils', 25),
('Rice bowl', 26),
('Wooden bowl', 27),
('Serving dishes', 28),
('Dough scraper', 29),
('Automatic mixer', 30)
('Big whisk', 31),
('Glass bowl', 31),
('Metal Bowl', 32),
('Really big bowl', 33), 
('Sifter', 34),
('Plastic bags', 35),
('Roller', 36);

INSERT INTO Saved_recipes
VALUES ('nagiaboushaca', 2);
INSERT INTO Saved_recipes
VALUES ('wcolsey', 1);
INSERT INTO Saved_recipes
VALUES ('sena.szczepaniuk', 3);
INSERT INTO Saved_recipes
VALUES
('tnguyen', 1),
('slee', 2),
('jwang', 3),
('bchen', 4),
('jdoe', 3),
('skim', 5),
('rwilliams', 6),
('hhernandez', 7),
('dlee', 8),
('mjones', 8),
('msmith', 8),
('msmith', 9),
('mgarcia', 10),
('jjackson', 11),
('rwilliams', 12),
('khan', 12),
('ssanchez', 13),
('jrivera', 14),
('dlee', 15),
('hhernandez', 16),
('dlee', 17),
('bchen', 18),
('jwang', 19),
('jwang', 20),
('jlai', 21),
('wcolsey', 22),
('swhite', 23),
('jthomas', 24),
('jthomas', 25),
('kjohnson', 26),
('mturner', 27),
('mturner', 28),
('slee', 29),
('rwilliams', 30),
('bchen', 31),
('swhite', 31),
('swhite', 32),
('jwang', 33), 
('jrobinson', 34),
('jrobinson', 35),
('jrobinson', 36);
