DROP TABLE IF EXISTS books;
CREATE TABLE IF NOT EXISTS books (
  id          INTEGER PRIMARY KEY AUTOINCREMENT,
  title       TEXT    NOT NULL,
  publisher   TEXT    NOT NULL,
  year        INTEGER NOT NULL,
  cover       TEXT,
  sort_order  INTEGER NOT NULL DEFAULT 0
);
INSERT INTO books (id, title, publisher, year, cover, sort_order) VALUES
  (1, 'Not So Sorry: Abusers, False Apologies, and the Limits of Forgiveness', 'Broadleaf Books', 2024, '/images/books/not-so-sorry.jpg', 1),
  (2, 'The Defiant Middle: How Women Claim Life''s In-Betweens to Remake the World', 'Broadleaf Books', 2021, '/images/books/defiant-middle.png', 2),
  (3, 'The Nones Are Alright: A New Generation of Seekers, Believers, and Those In Between', 'Orbis Books', 2015, '/images/books/nones-are-alright.jpg', 3),
  (4, 'Radical Reinvention: An Unlikely Return to the Catholic Church', 'Counterpoint Press', 2012, '/images/books/radical-reinvention.jpg', 4),
  (5, 'Slanted and Enchanted: The Evolution of Indie Culture', 'Faber & Faber', 2009, '/images/books/slanted-and-enchanted.jpg', 5);

-- description paragraphs (ordered array of HTML strings)
DROP TABLE IF EXISTS book_descriptions;
CREATE TABLE IF NOT EXISTS book_descriptions (
  id         INTEGER PRIMARY KEY AUTOINCREMENT,
  book_id    INTEGER NOT NULL REFERENCES books(id) ON DELETE CASCADE,
  paragraph  TEXT    NOT NULL,
  position   INTEGER NOT NULL
);
INSERT INTO book_descriptions (id, book_id, paragraph, position) VALUES
  -- Not So Sorry (book_id 1)
  (1,  1, 'It''s time for a nuanced discussion about forgiveness.', 1),
  (2,  1, 'From religious communities to therapeutic spaces, the importance of forgiving those who''ve wronged us is often enshrined as an unqualified good. But what about horrifying cases of abuse, predatory behavior, or systemic wrong? Too often, when predators or abusers are exposed, the chorus comes immediately: "What about forgiveness?" In these cases, forgiveness places the onus on victims, diminishes real hurt and anger, lets perpetrators off the hook, and prevents justice from being done.', 2),
  (3,  1, 'In <em>Not So Sorry</em>, journalist and culture critic Kaya Oakes tackles these questions with intelligence, nuance, and a bit of righteous anger. Ranging effortlessly from Christian theology and world history to psychology and pop culture, Oakes takes us on a whirlwind tour of the many abuses of the concept of forgiveness, including the abuse scandals of the Catholic church, the outing of high-profile abusers like Larry Nassar, and white America''s obsession with false narratives of marginalized peoples granting forgiveness to oppressors. Ultimately, Oakes dares us to ask the necessary question: Is it ever better not to forgive?', 3),
  -- The Defiant Middle (book_id 2)
  (4,  2, 'For every woman, from the young to those in midlife and beyond, who has ever been told, "You can''t" and thought, "Oh, I definitely will!" – this book is for you.', 1),
  (5,  2, 'Women are expected to be many things. They should be young enough, but not too young; old enough, but not too old; creative, but not crazy; passionate, but not angry. They should be fertile and feminine and self-reliant, not barren or butch or solitary. Women, in other words, are caught between social expectations and a much more complicated reality.', 2),
  (6,  2, 'Women who don''t fit in, whether during life transitions or because of changes in their body, mind, or gender identity, are carving out new ways of being in and remaking the world. But this is nothing new: they have been doing so for thousands of years, often at the margins of the same religious traditions and cultures that created these limited ways of being for women in the first place.', 3),
  (7,  2, 'In <em>The Defiant Middle</em>, Kaya Oakes draws on the wisdom of women mystics and explores how transitional eras or living in marginalized female identities can be both spiritually challenging and wonderfully freeing, ultimately resulting in a reinvented way of seeing the world and changing it. "Change, after all," Oakes writes, "always comes from the margins."', 4),
  -- The Nones Are Alright (book_id 3)
  (8,  3, 'The ascent of the "Nones", those with no religious affiliation, has puzzled religious leaders from every denomination. But the increasing number of people in their 20s, 30s and 40s who have walked away from, or have never belonged to any religion, means that up to 40% of not one but two entire generations of Americans have chosen to live life without a traditional religious practice.', 1),
  (9,  3, 'And yet, some members of Gen X and Gen Y have chosen to embrace religion, but they''ve done so in a DIY fashion, recreating religion for a new generation of skeptics, in a time when past ideas of career, home ownership, and the nuclear family model are all changing. Through profiles of dozens of individuals, this book investigates how and why the exodus from organized religion is occurring, and contrasts the stories of Nones, atheists and agnostics with the stories of those who took different tracks: those who defied the trend and found religion as adults, or experienced a conversion from the religion of their childhood to a completely new set of beliefs, and those who''ve remained in the religion of their childhood, but have reimagined and redefined what religion means.', 2),
  (10, 3, 'Nominee, Religion News Service Best Book of 2015.', 3),
  -- Radical Reinvention (book_id 4)
  (11, 4, 'As someone who clocked more time in mosh pits and at pro-choice rallies than kneeling in a pew, Kaya Oakes was not necessarily the kind of Catholic girl the Vatican was after. But even while she immersed herself in the punk rock scene and proudly called herself an atheist, something kept pulling her back to the religion of her Irish roots.', 1),
  (12, 4, 'This is a story of transformation, not only of Kaya''s from ex-Catholic to amateur theologian, but ultimately of the cultural and ethical pushes for change that are rocking the world''s largest religion to its core.', 2),
  -- Slanted and Enchanted (book_id 5)
  (13, 5, 'You know the ethos: DIY with a big helping of irony. But what does it really mean to be "indie"? As popular television shows adopt indie soundtracks and the signature style bleeds into mainstream fashion, the quirky individuality of the movement seems to be losing ground. In <em>Slanted and Enchanted</em>, Kaya Oakes demonstrates how this phase is part of the natural cycle of a culture that reinvents itself continuously to preserve its core ideals of experimentation, freedom, and collaboration.', 1),
  (14, 5, 'Through interviews and profiles of the artists who have spearheaded the cause over the years — including Mike Watt, David Berman, Kathleen Hanna, and Dan Clowes — Oakes examines the collective creativity and cross-genre experimentation that are the hallmarks of this popular lifestyle trend. Her visits to music festivals, craft fairs, and smaller collectives around the country round out the story, providing a compelling portayal of indie life on the ground. Culminating in the current indie milieu of music, crafting, style, art, comics, and zines, Oakes reveals from whence indie came and where it will go next.', 2);

-- endorsement quotes
DROP TABLE IF EXISTS book_endorsements;
CREATE TABLE IF NOT EXISTS book_endorsements (
  id          INTEGER PRIMARY KEY AUTOINCREMENT,
  book_id     INTEGER NOT NULL REFERENCES books(id) ON DELETE CASCADE,
  quote       TEXT    NOT NULL,
  attribution TEXT    NOT NULL,
  position    INTEGER NOT NULL
);
INSERT INTO book_endorsements (id, book_id, quote, attribution, position) VALUES
  -- Not So Sorry (book_id 1)
  (1,  1, 'Kaya Oakes challenges those slippery, PR-constructed apologies that leave us rolling our eyes. But she does more than that. Throughout Not So Sorry, Kaya Oakes listens to the voices of victims, allows us to wrestle with our assumptions, and leads us on a path to restore justice.', 'Rev. Carol Howard, author of Healing Spiritual Wounds: Reconnecting with a Loving God after Experiencing a Hurtful Church, and pastor of Bedford Presbyterian Church', 1),
  (2,  1, 'In Not So Sorry, Kaya Oakes presents a thoughtful meditation on one of Jesus''s most challenging commandments: that we forgive those who have wronged us. With compassion, curiosity, and conviction, Oakes invites us to consider the implications of forgiveness in a fraught age.', 'Michael J. O''Loughlin, author of Hidden Mercy: AIDS, Catholics, and the Untold Stories of Compassion in the Face of Fear', 2),
  (3,  1, 'Kaya Oakes has long been one of my favorite writers on the religion beat, but I can testify that no work of hers has challenged me like Not So Sorry. When you believe, as I do, that the genius of Christianity is its offer of mercy to even the worst of sinners, it is bracing, and difficult, to be reminded of the limits of forgiveness and the perils of cheap grace. In an age when abuse has been exposed as rampant, and accountability is so rare, Oakes''s call to rethink forgiveness by centering survivors and reminding us of all the ways the powerful use and abuse the language of faith is essential reading', 'Matthew Sitman, host of the Know Your Enemy podcast', 3),
  -- The Defiant Middle (book_id 2)
  (4,  2, 'This is a book for all women, but I think especially for women who feel caught in between and pulled in different directions, who are trying to sort out our anger and craziness and deal with a culture that expects the impossible of us.', 'Rebecca Bratten Weiss, Commonweal', 1),
  (5,  2, 'In The Defiant Middle, Oakes proves herself to be the sort of practical role model she seeks out and so eloquently writes of. Even for the boys.', 'Anna Marchese, America Magazine', 2),
  (6,  2, 'The Defiant Middle is a provocative book that will feed hearts and minds with questions and answers. Simultaneously it will challenge the cultural and religious norms that put women in bondage. Living into new ways of being await us all — if we listen deeply and then act.', 'Fran Rossi Szpylczyn, National Catholic Reporter', 3),
  (7,  2, 'Journalist Kaya Oakes offers stories of trailblazing women and thought-provoking insights on how to defy society''s expectations.', 'Shelf Awareness', 4),
  (8,  2, 'This is a wonderful, wonderful book. While excavating and illuminating the everyday and profound in-betweens that women traverse, it is also an insightful meditation on the liminal realities of religion, and of life writ large. And it is so beautifully, winsomely written! I plan to give this book to every woman I know, beginning with my mother and my daughter.', 'Krista Tippett, founder and CEO of the On Being Project', 5),
  (9,  2, 'The Defiant Middle is the book I didn''t know I needed to read. An enlightening rumination on spirituality and embodiment, on the constraints women face, and also on the possibilities available to women as they navigate their own journeys.', 'Kristin Kobes Du Mez, author of Jesus and John Wayne', 6),
  (10, 2, 'Kaya Oakes is a guide and companion to the parts of female life and spirituality that are neglected, dismissed, erased, and ignored. For anyone who has ever felt too much, they are bound to feel both seen and known in these pages–and learn to wonder at the complicated stories we have flattened in our history and theology books. Kaya Oakes continues to stand out as one of the best writers of our time, bringing both her Catholic and Gen-X imagination into these thoughtful, complicated pages.', 'D. L. Mayfield, author of The Myth of the American Dream: Reflections on Affluence, Autonomy, Safety, and Power', 7),
  (11, 2, 'This book is vulnerable and real. For those of us who live in the liminal space known as middle age, The Defiant Middle will change and challenge how we navigate this stage of life. With wit and clarity, Kaya Oakes invites you to reconsider and reevaluate what you think you know by offering her own brilliant insights and the tested wisdom of the saints who''ve gone before us. In a world of polarities, Oakes speaks to the women in the middle with nuance and dimension. This is a book that will sit by my bedside because it''s filled with words I don''t want to forget.', 'Karen González, author of The God Who Sees: Immigrants, the Bible, and the Journey to Belong', 8),
  -- The Nones Are Alright (book_id 3)
  (12, 3, 'Kaya Oakes has written the Growing Up Absurd for 21st century religion — honest, inconvenient for the status quo, yet hopeful. The Nones Are Alright is an essential primer on the challenge religion faces today and a case for why that challenge is so worth meeting.', 'Nathan Schneider, author, God in Proof', 1),
  (13, 3, 'This beautifully written book describes many examples of the ''nones'' — those who say they have no religious affiliations — and their aspirations and conflicts around faith.', 'anya Marie Lurhman, author, When God Talks Back', 2),
  (14, 3, 'This book proves once again that Kaya Oakes isn''t afraid of honest conversation or tough questions. Through her interviews and reflections, she reminds readers that the spiritual life can involve both wonder and wandering and that growing in faith sometimes feels a lot like doubt.', 'Kerry Weber, managing editor, America and author, Mercy in the City', 3),
  -- Radical Reinvention (book_id 4)
  (15, 4, 'Oakes… not only treats readers to gorgeous prose, but manages to provide an overview and history of the best of the Catholic faith, without losing momentum.', 'Starred Review, Publishers Weekly', 1),
  (16, 4, 'Honestly, humorously, and irreverently recounted… A clarion call for an institution''s radical reinvention.', 'Booklist', 2),
  (17, 4, 'Bold and affecting… passionate …informative, irreverent, and often hilarious, Oakes has written one of the most important books about religion of the year.', 'LargeHearted Boy', 3),
  (18, 4, 'Turns the typical conceit of the conversion memoir on its head… a fascinating window into the world of belief that doesn''t lead the reader to a foregone conclusion about the nature of God or Christianity.', 'Zyzzyva Magazine', 4),
  (19, 4, 'Her eventual belief in a church that meets the needs of everyone, sinners and skeptics alike, is palpable — and perhaps enough to get other disenfranchised believers to look twice.', 'Bitch Magazine', 5),
  -- Slanted and Enchanted (book_id 5)
  (20, 5, 'Relays indie''s development… with uncommon insight… [and] makes an impassioned, optimistic case for indie''s vitality that doesn''t assume readers are coming to [the] book already well versed in the subject… A comprehensive approach to a subject that is too often reduced to discrete parts… Fresh and perceptive.', 'San Francisco Chronicle (2009 Notable Book)', 1),
  (21, 5, '[An] absorbing nonfiction study of indie culture… Oakes is no dry outsider. She believes in what she describes, she contributes to it and she speaks its language.', 'The Plain Dealer (Cleveland)', 2),
  (22, 5, '[A] lively and highly literate explication of various American indie scenes and art forms… [Oakes''] focus on independent publishing and writing — provides a worthy parallel narrative to Michael Azzerad''s essential indie music history, This Band Could Be Your Life… Oakes begins the book with a much appreciated primer on some of the intellectual forebears of her book''s central characters, including the poets Frank O''Hara and Allen Ginsberg and the revolutionary street theater group the Diggers. As an explanation and excavation of the already fading recent past, it is essential reading.', 'Publishers Weekly', 3);

-- essays
DROP TABLE IF EXISTS essays;
CREATE TABLE IF NOT EXISTS essays (
  id          INTEGER PRIMARY KEY AUTOINCREMENT,
  title       TEXT    NOT NULL,
  publication TEXT    NOT NULL,
  url         TEXT,
  quote       TEXT    NOT NULL,
  sort_order  INTEGER NOT NULL DEFAULT 0
);
INSERT INTO essays (title, publication, url, quote, sort_order) VALUES
  ('Ask Better Questions', 'Commonweal', 'https://www.commonwealmagazine.org/ask-better-questions', 'People have never stopped seeking God, transcendence, spirit, or community. They''re just not finding any of those things in church.', 1),
  ('The "New Menopause" Is the Same Old Patriarchal BS', 'Residuum', 'https://kayaoakes.substack.com/p/the-new-menopause-is-the-same-old', 'The new midlife, as it turns out, is much more accessible if you''re rich.', 2),
  ('Whose Sin Is It Anyway', 'The Revealer', 'https://therevealer.org/whose-sin-is-it-anyway-catholics-abortion-and-what-comes-next/', 'For many in the coming weeks, months, and years who will see suffering and death wrought by the end of Roe, including another 10-year-old girl in Ohio, that same conscience may well lead them away from the church that brought about that end.', 3),
  ('What "Drag Nuns" Get Right About Faith', 'Sojourners', 'https://sojo.net/articles/what-drag-nuns-get-right-about-catholic-faith', 'The daughter of a king, Wilgefortis was promised in marriage to a man she didn''t want, and in answer to her prayers for liberation, <a href="https://artuk.org/discover/stories/saint-wilgefortis-a-bearded-woman-with-a-queer-history">God caused her to sprout a miraculous beard.</a>', 4),
  ('Nick Cave Wants to Be Your Spiritual Director', 'America', 'https://www.americamagazine.org/arts-culture/2022/05/19/nick-cave-red-hand-files-242982', 'Our secular age still needs preachers, but even more, it needs pastors.', 5),
  ('On Forgiveness, Clergy Abuse, and the Need for New Understandings', 'The Revealer', 'https://therevealer.org/from-the-archive-on-forgiveness-clergy-abuse-and-the-need-for-new-understandings/', 'The Church can write checks to its heart''s content, bankrupt dioceses, stage Reparation Masses, build "healing gardens," and beg for forgiveness. But until it owns up to the fact that it has not allowed adequate space for victims to express themselves, confront their abusers, and thus begin to heal, no true acts of atonement have been performed.', 6),
  ('Letter from California', 'Commonweal', 'https://www.commonwealmagazine.org/letter-california-0', 'Californians have adapted. We know what to do in a disaster. Stop, drop, and do your best to hold on.', 7),
  ('This is Your Soul on Mysticism', 'America', 'https://www.americamagazine.org/faith/2020/12/17/mysticism-covid-19-julian-norwich-239506', 'Some of us work at home, anchorites tethered to our Wi-Fi connections, where we peer not through windows into the outside world like Julian, but into virtual windows that lead us into other people''s rooms, where they sit peering back into our rooms, monastic cells upon monastic cells, multiplying and dividing as we log on and off.', 8),
  ('We Are Not Middle Aged', 'On Being', 'https://onbeing.org/blog/kaya-oakes-we-are-not-middle-aged-what-medieval-women-taught-me-about-my-40s/', 'It starts happening before you realize it and by the time you do, the slow, grinding erasures have already begun.', 9),
  ('Mary: Our often reimagined, always radical mother', 'Religion News Service', 'https://www.oakestown.org/essays/Our%20often%20reimagined,%20always%20radical%20mother', 'Mary [is not] a sentimentally perfect woman, meek, mild and passive, a religious Hallmark card who has come to represent the idealized mother figure most of our own mothers would struggle to measure up to.', 10),
  ('A School Grows in Oakland', 'America', 'https://www.americamagazine.org/faith/2020/03/06/how-jesuits-and-christian-brothers-are-bringing-catholic-education-back-oakland', 'Because redlining was a common practice in Oakland, it was illegal for people of color to buy homes in many parts of town. Fruitvale was one of the exceptions.', 11),
  ('Popesplaining', 'Religion Dispatches', 'https://religiondispatches.org/popesplaining/', 'We choose our unhappiness. But in its decision to exclude women from serving as priests and in its insistence that, at best, women can be ''strawberries'' on a theological cake, the Catholic church also chooses unhappiness for us.', 12),
  ('Lay Down Your Weary Tune', 'Killing the Buddha', 'https://killingthebuddha.com/mag/damnation/lay-down-your-weary-tune/', 'Anxiety just might be my muse. Now it is my nation''s muse.', 13),
  ('The Conservative Resistance Inside the Vatican', 'The New Republic', 'https://newrepublic.com/article/151589/conservative-resistance-inside-vatican', 'Long ago, the Vatican and its leadership lost their connection to the ordinary lives of the billion Catholics worldwide. Now, they privilege reputation above truth, and, like many of the current accusations flying around, that instinct is rotten.', 14),
  ('I Got Shushed at a Yo-Yo Ma Concert', 'Slate', 'https://slate.com/culture/2018/10/classical-music-concert-quiet-shushing.html', 'Classical music isn''t dying, but our ways of experiencing it are becoming ossified.', 15);

-- about section paragraphs
DROP TABLE IF EXISTS about_paragraphs;
CREATE TABLE IF NOT EXISTS about_paragraphs (
  id        INTEGER PRIMARY KEY AUTOINCREMENT,
  content   TEXT    NOT NULL,
  position  INTEGER NOT NULL DEFAULT 0
);
INSERT INTO about_paragraphs (content, position) VALUES
  ('Kaya Oakes is the author of six books. Her most recent works include <em>Not So Sorry: Abusers, False Apologies and the Limits of Forgiveness</em> (Broadleaf Books, 2024), <em>The Defiant Middle: How Women Claim Life''s In Betweens to Remake the World</em> (Broadleaf Books, 2021), <em>The Nones Are Alright</em> (Orbis Books, 2015), and <em>Radical Reinvention</em> (Counterpoint Press, 2012).', 1),
  ('Her essays and journalism have appeared in The Revealer, The New Republic, Slate, Foreign Policy, The Guardian, The Washington Post, Sojourners, National Catholic Reporter, Commonweal, Religion Dispatches, Tricycle, On Being, and America. She co-founded the arts and culture magazine Kitchen Sink and serves on the editorial board of Killing the Buddha.', 2),
  ('She received the Religion News Association''s award for best commentary in 2021 and has appeared on CBC, NPR, and various podcasts. She has lectured at universities including Fordham, Syracuse, Notre Dame, Villanova, USC, and UC Berkeley, and was selected to study religion writing at the Vatican in 2016.', 3),
  ('Since 1999, she has taught creative nonfiction, cultural criticism, composition, and research writing at UC Berkeley''s College Writing Programs. She was born and raised in Oakland, California, where she currently resides.', 4);

-- admin sessions
DROP TABLE IF EXISTS admin_sessions;
CREATE TABLE IF NOT EXISTS admin_sessions (
  id         TEXT PRIMARY KEY,
  created_at TEXT NOT NULL DEFAULT (datetime('now')),
  expires_at TEXT NOT NULL
);
