CREATE TABLE IF NOT EXISTS brand (name TEXT, friendlyName TEXT, selected INTEGER);
CREATE TABLE IF NOT EXISTS weight (name TEXT, friendlyName TEXT, selected INTEGER);
CREATE TABLE IF NOT EXISTS fiber (name TEXT, friendlyName TEXT, selected INTEGER);
CREATE TABLE IF NOT EXISTS yarn (pk INTEGER PRIMARY KEY, brandName TEXT, weightName TEXT, fiberName TEXT, name TEXT, quantity DECIMAL, quantity_type TEXT, description TEXT);

--INSERT INTO weight (name, friendlyName) VALUES ('baby', 'Baby');
INSERT INTO weight (name, friendlyName) VALUES ('fingering', 'Fingering');
--INSERT INTO weight (name, friendlyName) VALUES ('sock', 'Sock');
--INSERT INTO weight (name, friendlyName) VALUES ('sport', 'Sport');
--INSERT INTO weight (name, friendlyName) VALUES ('dk', 'DK');
--INSERT INTO weight (name, friendlyName) VALUES ('light', 'Light');
--INSERT INTO weight (name, friendlyName) VALUES ('worsted', 'Worsted');
--INSERT INTO weight (name, friendlyName) VALUES ('chunky', 'Chunky');
--INSERT INTO weight (name, friendlyName) VALUES ('craft', 'Craft');
--INSERT INTO weight (name, friendlyName) VALUES ('rug', 'Rug');
--INSERT INTO weight (name, friendlyName) VALUES ('bulky', 'Bulky');
--INSERT INTO weight (name, friendlyName) VALUES ('roving', 'Roving');

INSERT INTO fiber (name, friendlyName) VALUES ('blue_faced_leceister','Blue-Faced Leceister');
INSERT INTO fiber (name, friendlyName) VALUES ('super_wash_merino','Super-wash Merino');

--INSERT INTO brand (name, friendlyName) VALUES ('all_things_heather','All Things Heather');
--INSERT INTO brand (name, friendlyName) VALUES ('alpaca_with_a_twist','Alpaca With a Twist');
--INSERT INTO brand (name, friendlyName) VALUES ('bees_knees_knits','Bees Knees Knits');
--INSERT INTO brand (name, friendlyName) VALUES ('bekah_knits','Bekah Knits');
--INSERT INTO brand (name, friendlyName) VALUES ('cascade','Cascade');
--INSERT INTO brand (name, friendlyName) VALUES ('chameleon_colorworks','Chameleon Colorworks');
--INSERT INTO brand (name, friendlyName) VALUES ('designs_by_romi','Designs by Romi');
--INSERT INTO brand (name, friendlyName) VALUES ('dream_in_color','Dream in Color');
--INSERT INTO brand (name, friendlyName) VALUES ('yarn_nerd','Yarn Nerd');
INSERT INTO brand (name, friendlyName) VALUES ('yarn_pirate','Yarn Pirate');
--INSERT INTO brand (name, friendlyName) VALUES ('zecca','Zecca');
--INSERT INTO brand (name, friendlyName) VALUES ('zen_string','Zen String');

INSERT INTO yarn (brandName, weightName, fiberName, name, quantity, quantity_type, description) VALUES ('yarn_pirate', 'fingering', 'super_wash_merino', 'Sample Yarn (Delete Me!)', 33.4, 'yard', 'Red & White');