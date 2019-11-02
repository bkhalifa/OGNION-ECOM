
USE [master]
GO
/****** Object:  Database [COMMERCE]  ******/
CREATE DATABASE [COMMERCE] ON  PRIMARY 
( NAME = N'COMMERCE', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.DEV\MSSQL\DATA\COMMERCE.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'COMMERCE_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.DEV\MSSQL\DATA\COMMERCE_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [COMMERCE] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [COMMERCE].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [COMMERCE] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [COMMERCE] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [COMMERCE] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [COMMERCE] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [COMMERCE] SET ARITHABORT OFF 
GO
ALTER DATABASE [COMMERCE] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [COMMERCE] SET AUTO_SHRINK ON 
GO
ALTER DATABASE [COMMERCE] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [COMMERCE] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [COMMERCE] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [COMMERCE] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [COMMERCE] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [COMMERCE] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [COMMERCE] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [COMMERCE] SET  DISABLE_BROKER 
GO
ALTER DATABASE [COMMERCE] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [COMMERCE] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [COMMERCE] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [COMMERCE] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [COMMERCE] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [COMMERCE] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [COMMERCE] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [COMMERCE] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [COMMERCE] SET  MULTI_USER 
GO
ALTER DATABASE [COMMERCE] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [COMMERCE] SET DB_CHAINING OFF 
GO
USE [COMMERCE]
GO
/****** Object:  User [AUTORITE NT\SERVICE RÉSEAU]    Script Date: 12/01/2017 14:34:56 ******/
CREATE USER [AUTORITE NT\SERVICE RÉSEAU] FOR LOGIN [AUTORITE NT\SERVICE RÉSEAU] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [AUTORITE NT\SERVICE RÉSEAU]
GO
/****** Object:  Schema [JHSW500B\Joe Stagner]    Script Date: 12/01/2017 14:34:56 ******/
CREATE SCHEMA [JHSW500B\Joe Stagner]
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 12/01/2017 14:34:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[CategoryID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [nvarchar](50) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[OrderDetails]    Script Date: 12/01/2017 14:34:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetails](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[OrderID] [int] NULL,
	[ProductID] [int] NULL,
	[Quantity] [int] NULL,
	[UnitCost] [money] NULL,
 CONSTRAINT [PK_OrderDetails] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Orders]    Script Date: 12/01/2017 14:34:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[OrderID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerName] [nvarchar](256) NOT NULL,
	[OrderDate] [datetime] NOT NULL CONSTRAINT [DF_Orders_OrderDate]  DEFAULT (getdate()),
	[ShipDate] [datetime] NOT NULL CONSTRAINT [DF_Orders_ShipDate]  DEFAULT (getdate())
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Products]    Script Date: 12/01/2017 14:34:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[ProductID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryID] [int] NOT NULL,
	[ModelNumber] [nvarchar](50) NULL,
	[ModelName] [nvarchar](50) NULL,
	[ProductImage] [nvarchar](50) NULL,
	[UnitCost] [money] NOT NULL,
	[Description] [nvarchar](3800) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [ci_product_modelname]    Script Date: 12/01/2017 14:34:56 ******/
CREATE CLUSTERED INDEX [ci_product_modelname] ON [dbo].[Products]
(
	[ModelName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Reviews]    Script Date: 12/01/2017 14:34:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reviews](
	[ReviewID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NOT NULL,
	[CustomerName] [nvarchar](50) NULL,
	[CustomerEmail] [nvarchar](50) NULL,
	[Rating] [int] NOT NULL,
	[Comments] [nvarchar](3850) NULL,
 CONSTRAINT [PK_Reviews] PRIMARY KEY CLUSTERED 
(
	[ReviewID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ShoppingCart]    Script Date: 12/01/2017 14:34:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ShoppingCart](
	[RecordID] [int] IDENTITY(1,1) NOT NULL,
	[CartID] [nvarchar](50) NULL,
	[Quantity] [int] NOT NULL CONSTRAINT [DF_ShoppingCart_Quantity]  DEFAULT ((1)),
	[ProductID] [int] NOT NULL,
	[DateCreated] [datetime] NOT NULL CONSTRAINT [DF_ShoppingCart_DateCreated]  DEFAULT (getdate())
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[VewOrderDetails]    Script Date: 12/01/2017 14:34:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VewOrderDetails]
AS
SELECT        dbo.Products.ProductID, dbo.Products.ModelNumber, dbo.Products.ModelName, dbo.OrderDetails.Quantity, dbo.OrderDetails.UnitCost, 
                         dbo.OrderDetails.OrderID
FROM            dbo.OrderDetails INNER JOIN
                         dbo.Products ON dbo.OrderDetails.ProductID = dbo.Products.ProductID


GO
/****** Object:  View [dbo].[ViewAlsoPurchased]    Script Date: 12/01/2017 14:34:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ViewAlsoPurchased]
AS
SELECT        TOP (5) dbo.OrderDetails.ProductID, dbo.Products.ModelName, SUM(dbo.OrderDetails.Quantity) AS TotalNumPurchased, dbo.OrderDetails.OrderID, 
                         dbo.Products.ProductID AS Products_ProductID
FROM            dbo.OrderDetails INNER JOIN
                         dbo.Products ON dbo.OrderDetails.ProductID = dbo.Products.ProductID
WHERE        (dbo.OrderDetails.OrderID IN
                             (SELECT DISTINCT OrderID
                               FROM            dbo.OrderDetails AS OrderDetailsSelected))
GROUP BY dbo.OrderDetails.ProductID, dbo.Products.ModelName, dbo.OrderDetails.OrderID, dbo.Products.ProductID
ORDER BY TotalNumPurchased DESC


GO
/****** Object:  View [dbo].[ViewCart]    Script Date: 12/01/2017 14:34:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ViewCart]
AS
SELECT        TOP (100) PERCENT dbo.Products.ProductID, dbo.Products.ModelNumber, dbo.Products.ModelName, dbo.Products.UnitCost, dbo.ShoppingCart.Quantity, 
                         dbo.ShoppingCart.CartID
FROM            dbo.Products INNER JOIN
                         dbo.ShoppingCart ON dbo.Products.ProductID = dbo.ShoppingCart.ProductID AND dbo.Products.ProductID = dbo.ShoppingCart.ProductID
ORDER BY dbo.Products.ModelName, dbo.Products.ModelNumber


GO
SET IDENTITY_INSERT [dbo].[Categories] ON 

INSERT [dbo].[Categories] ([CategoryID], [CategoryName]) VALUES (14, N'Communications')
INSERT [dbo].[Categories] ([CategoryID], [CategoryName]) VALUES (15, N'Deception')
INSERT [dbo].[Categories] ([CategoryID], [CategoryName]) VALUES (16, N'Travel')
INSERT [dbo].[Categories] ([CategoryID], [CategoryName]) VALUES (17, N'Protection')
INSERT [dbo].[Categories] ([CategoryID], [CategoryName]) VALUES (18, N'Munitions')
INSERT [dbo].[Categories] ([CategoryID], [CategoryName]) VALUES (19, N'Tools')
INSERT [dbo].[Categories] ([CategoryID], [CategoryName]) VALUES (20, N'General')
SET IDENTITY_INSERT [dbo].[Categories] OFF
SET IDENTITY_INSERT [dbo].[OrderDetails] ON 

INSERT [dbo].[OrderDetails] ([Id], [OrderID], [ProductID], [Quantity], [UnitCost]) VALUES (50, 126, 360, 1, 49.9900)
INSERT [dbo].[OrderDetails] ([Id], [OrderID], [ProductID], [Quantity], [UnitCost]) VALUES (51, 126, 362, 2, 1.9900)
INSERT [dbo].[OrderDetails] ([Id], [OrderID], [ProductID], [Quantity], [UnitCost]) VALUES (52, 126, 397, 1, 29.9900)
INSERT [dbo].[OrderDetails] ([Id], [OrderID], [ProductID], [Quantity], [UnitCost]) VALUES (53, 126, 401, 3, 599.9900)
INSERT [dbo].[OrderDetails] ([Id], [OrderID], [ProductID], [Quantity], [UnitCost]) VALUES (54, 126, 404, 1, 459.9900)
INSERT [dbo].[OrderDetails] ([Id], [OrderID], [ProductID], [Quantity], [UnitCost]) VALUES (55, 127, 377, 1, 6.9900)
INSERT [dbo].[OrderDetails] ([Id], [OrderID], [ProductID], [Quantity], [UnitCost]) VALUES (56, 127, 374, 1, 999.9900)
INSERT [dbo].[OrderDetails] ([Id], [OrderID], [ProductID], [Quantity], [UnitCost]) VALUES (57, 127, 384, 1, 99.9900)
INSERT [dbo].[OrderDetails] ([Id], [OrderID], [ProductID], [Quantity], [UnitCost]) VALUES (58, 127, 359, 1, 1299.9900)
INSERT [dbo].[OrderDetails] ([Id], [OrderID], [ProductID], [Quantity], [UnitCost]) VALUES (59, 127, 378, 1, 14.9900)
INSERT [dbo].[OrderDetails] ([Id], [OrderID], [ProductID], [Quantity], [UnitCost]) VALUES (60, 127, 382, 1, 6.9900)
INSERT [dbo].[OrderDetails] ([Id], [OrderID], [ProductID], [Quantity], [UnitCost]) VALUES (61, 127, 378, 1, 14.9900)
INSERT [dbo].[OrderDetails] ([Id], [OrderID], [ProductID], [Quantity], [UnitCost]) VALUES (62, 127, 371, 1, 129.9900)
SET IDENTITY_INSERT [dbo].[OrderDetails] OFF
SET IDENTITY_INSERT [dbo].[Orders] ON 

INSERT [dbo].[Orders] ([OrderID], [CustomerName], [OrderDate], [ShipDate]) VALUES (126, N'JoeUser', CAST(N'2010-04-28 09:25:15.957' AS DateTime), CAST(N'2010-04-30 09:25:15.957' AS DateTime))
INSERT [dbo].[Orders] ([OrderID], [CustomerName], [OrderDate], [ShipDate]) VALUES (127, N'JoeUser', CAST(N'2010-11-11 11:27:33.277' AS DateTime), CAST(N'2010-11-13 11:27:33.277' AS DateTime))
SET IDENTITY_INSERT [dbo].[Orders] OFF
SET IDENTITY_INSERT [dbo].[Products] ON 

INSERT [dbo].[Products] ([ProductID], [CategoryID], [ModelNumber], [ModelName], [ProductImage], [UnitCost], [Description]) VALUES (391, 17, N'BSUR2DUC', N'Bullet Proof Facial Tissue', N'image.gif', 79.9900, N'Being a spy can be dangerous work. Our patented Bulletproof Facial Tissue gives a spy confidence that any bullets in the vicinity risk-free. Unlike traditional bulletproof devices, these lightweight tissues have amazingly high tensile strength. To protect the upper body, simply place a tissue in your shirt pocket. To protect the lower body, place a tissue in your pants pocket. If you do not have any pockets, be sure to check out our Bulletproof Tape. 100 tissues per box. WARNING: Bullet must not be moving for device to successfully stop penetration.')
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ModelNumber], [ModelName], [ProductImage], [UnitCost], [Description]) VALUES (376, 15, N'CITSME9', N'Cloaking Device', N'image.gif', 9999.9900, N'Worried about detection on your covert mission? Confuse mission-threatening forces with this cloaking device. Powerful new features include string-activated pre-programmed phrases such as "Danger! Danger!", "Reach for the sky!", and other anti-enemy expressions. Hyper-reactive karate chop action deters even the most persistent villain.')
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ModelNumber], [ModelName], [ProductImage], [UnitCost], [Description]) VALUES (386, 17, N'1MOR4ME', N'Cocktail Party Pal', N'image.gif', 69.9900, N'Do your assignments have you flitting from one high society party to the next? Worried about keeping your wits about you as you mingle witih the champagne-and-caviar crowd? No matter how many drinks you''re offered, you can safely operate even the most complicated heavy machinery as long as you use our model 1MOR4ME alcohol-neutralizing coaster. Simply place the beverage glass on the patented circle to eliminate any trace of alcohol in the drink.')
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ModelNumber], [ModelName], [ProductImage], [UnitCost], [Description]) VALUES (360, 14, N'RED1', N'Communications Device', N'image.gif', 49.9900, N'Subversively stay in touch with this miniaturized wireless communications device. Speak into the pointy end and listen with the other end! Voice-activated dialing makes calling for backup a breeze. Excellent for undercover work at schools, rest homes, and most corporate headquarters. Comes in assorted colors.')
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ModelNumber], [ModelName], [ProductImage], [UnitCost], [Description]) VALUES (388, 20, N'ICUCLRLY00', N'Contact Lenses', N'image.GIF', 59.9900, N'Traditional binoculars and night goggles can be bulky, especially for assignments in confined areas. The problem is solved with these patent-pending contact lenses, which give excellent visibility up to 100 miles. New feature: now with a night vision feature that permits you to see in complete darkness! Contacts now come in a variety of fashionable colors for coordinating with your favorite ensembles.')
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ModelNumber], [ModelName], [ProductImage], [UnitCost], [Description]) VALUES (394, 15, N'BHONST93', N'Correction Fluid', N'image.gif', 1.9900, N'Disguised as typewriter correction fluid, this scientific truth serum forces subjects to correct anything not perfectly true. Simply place a drop of the special correction fluid on the tip of the subject''s nose. Within seconds, the suspect will automatically correct every lie. Effects from Correction Fluid last approximately 30 minutes per drop. WARNING: Discontinue use if skin appears irritated.')
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ModelNumber], [ModelName], [ProductImage], [UnitCost], [Description]) VALUES (374, 15, N'DNTGCGHT', N'Counterfeit Creation Wallet', N'image.gif', 999.9900, N'Don''t be caught penniless in Prague without this hot item! Instantly creates replicas of most common currencies! Simply place rocks and water in the wallet, close, open up again, and remove your legal tender!')
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ModelNumber], [ModelName], [ProductImage], [UnitCost], [Description]) VALUES (396, 19, N'BPRECISE00', N'Dilemma Resolution Device', N'image.gif', 11.9900, N'Facing a brick wall? Stopped short at a long, sheer cliff wall?  Carry our handy lightweight calculator for just these emergencies. Quickly enter in your dilemma and the calculator spews out the best solutions to the problem.   Manufacturer Warning: Use at own risk. Suggestions may lead to adverse outcomes.')
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ModelNumber], [ModelName], [ProductImage], [UnitCost], [Description]) VALUES (399, 20, N'QLT2112', N'Document Transportation System', N'image.gif', 299.9900, N'Keep your stolen Top Secret documents in a place they''ll never think to look!  This patent leather briefcase has multiple pockets to keep documents organized.  Top quality craftsmanship to last a lifetime.')
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ModelNumber], [ModelName], [ProductImage], [UnitCost], [Description]) VALUES (384, 19, N'FF007', N'Eavesdrop Detector', N'image.gif', 99.9900, N'Worried that counteragents have placed listening devices in your home or office? No problem! Use our bug-sweeping wiener to check your surroundings for unwanted surveillance devices. Just wave the frankfurter around the room ... when bugs are detected, this "foot-long" beeps! Comes complete with bun, relish, mustard, and headphones for privacy.')
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ModelNumber], [ModelName], [ProductImage], [UnitCost], [Description]) VALUES (356, 20, N'STKY1', N'Edible Tape', N'image.gif', 3.9900, N'The latest in personal survival gear, the STKY1 looks like a roll of ordinary office tape, but can save your life in an emergency.  Just remove the tape roll and place in a kettle of boiling water with mixed vegetables and a ham shank. In just 90 minutes you have a great tasking soup that really sticks to your ribs! Herbs and spices not included.')
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ModelNumber], [ModelName], [ProductImage], [UnitCost], [Description]) VALUES (365, 19, N'BRTLGT1', N'Effective Flashlight', N'image.gif', 9.9900, N'The most powerful darkness-removal device offered to creatures of this world.  Rather than amplifying existing/secondary light, this handy product actually REMOVES darkness allowing you to see with your own eyes.  Must-have for nighttime operations. An affordable alternative to the Night Vision Goggles.')
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ModelNumber], [ModelName], [ProductImage], [UnitCost], [Description]) VALUES (385, 16, N'LNGWADN', N'Escape Cord', N'image.gif', 13.9900, N'Any agent assigned to mountain terrain should carry this ordinary-looking extension cord ... except that it''s really a rappelling rope! Pull quickly on each end to convert the electrical cord into a rope capable of safely supporting up to two agents. Comes in various sizes including Mt McKinley, Everest, and Kilimanjaro. WARNING: To prevent serious injury, be sure to disconnect from wall socket before use.')
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ModelNumber], [ModelName], [ProductImage], [UnitCost], [Description]) VALUES (357, 16, N'P38', N'Escape Vehicle (Air)', N'image.gif', 2.9900, N'In a jam, need a quick escape? Just whip out a sheet of our patented P38 paper and, with a few quick folds, it converts into a lighter-than-air escape vehicle! Especially effective on windy days - no fuel required. Comes in several sizes including letter, legal, A10, and B52.')
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ModelNumber], [ModelName], [ProductImage], [UnitCost], [Description]) VALUES (359, 16, N'PT109', N'Escape Vehicle (Water)', N'image.gif', 1299.9900, N'Camouflaged as stylish wing tips, these ''shoes'' get you out of a jam on the high seas instantly. Exposed to water, the pair transforms into speedy miniature inflatable rafts. Complete with 76 HP outboard motor, these hip heels will whisk you to safety even in the roughest of seas. Warning: Not recommended for beachwear.')
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ModelNumber], [ModelName], [ProductImage], [UnitCost], [Description]) VALUES (358, 19, N'NOZ119', N'Extracting Tool', N'image.gif', 199.0000, N'High-tech miniaturized extracting tool. Excellent for extricating foreign objects from your person. Good for picking up really tiny stuff, too! Cleverly disguised as a pair of tweezers. ')
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ModelNumber], [ModelName], [ProductImage], [UnitCost], [Description]) VALUES (401, 14, N'TCKLR1', N'Fake Moustache Translator', N'image.gif', 599.9900, N'Fake Moustache Translator attaches between nose and mouth to double as a language translator and identity concealer. Sophisticated electronics translate your voice into the desired language. Wriggle your nose to toggle between Spanish, English, French, and Arabic. Excellent on diplomatic missions.')
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ModelNumber], [ModelName], [ProductImage], [UnitCost], [Description]) VALUES (375, 16, N'WRLD00', N'Global Navigational System', N'image.gif', 29.9900, N'No spy should be without one of these premium devices. Determine your exact location with a quick flick of the finger. Calculate destination points by spinning, closing your eyes, and stopping it with your index finger.')
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ModelNumber], [ModelName], [ProductImage], [UnitCost], [Description]) VALUES (378, 17, N'SQUKY1', N'Guard Dog Pacifier', N'image.gif', 14.9900, N'Pesky guard dogs become a spy''s best friend with the Guard Dog Pacifier. Even the most ferocious dogs suddenly act like cuddly kittens when they see this prop.  Simply hold the device in front of any threatening dogs, shaking it mildly.  For tougher canines, a quick squeeze emits an irresistible squeak that never fails to  place the dog under your control.')
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ModelNumber], [ModelName], [ProductImage], [UnitCost], [Description]) VALUES (400, 15, N'THNKDKE1', N'Hologram Cufflinks', N'image.gif', 799.9900, N'Just point, and a turn of the wrist will project a hologram of you up to 100 yards away. Sneaking past guards will be child''s play when you''ve sent them on a wild goose chase. Note: Hologram adds ten pounds to your appearance.')
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ModelNumber], [ModelName], [ProductImage], [UnitCost], [Description]) VALUES (377, 15, N'BME007', N'Identity Confusion Device', N'image.gif', 6.9900, N'Never leave on an undercover mission without our Identity Confusion Device! If a threatening person approaches, deploy the device and point toward the oncoming individual. The subject will fail to recognize you and let you pass unnoticed. Also works well on dogs.')
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ModelNumber], [ModelName], [ProductImage], [UnitCost], [Description]) VALUES (404, 14, N'JWLTRANS6', N'Interpreter Earrings', N'image.gif', 459.9900, N'The simple elegance of our stylish monosex earrings accents any wardrobe, but their clean lines mask the sophisticated technology within. Twist the lower half to engage a translator function that intercepts spoken words in any language and converts them to the wearer''s native tongue. Warning: do not use in conjunction with our Fake Moustache Translator product, as the resulting feedback loop makes any language sound like Pig Latin.')
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ModelNumber], [ModelName], [ProductImage], [UnitCost], [Description]) VALUES (371, 18, N'WOWPEN', N'Mighty Mighty Pen', N'image.gif', 129.9900, N'Some spies claim this item is more powerful than a sword. After examining the titanium frame, built-in blowtorch, and Nerf dart-launcher, we tend to agree! ')
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ModelNumber], [ModelName], [ProductImage], [UnitCost], [Description]) VALUES (363, 18, N'NTMBS1', N'Multi-Purpose Rubber Band', N'image.gif', 1.9900, N'One of our most popular items!  A band of rubber that stretches  20 times the original size. Uses include silent one-to-one communication across a crowded room, holding together a pack of Persuasive Pencils, and powering lightweight aircraft. Beware, stretching past 20 feet results in a painful snap and a rubber strip.')
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ModelNumber], [ModelName], [ProductImage], [UnitCost], [Description]) VALUES (370, 17, N'TGFDA', N'Multi-Purpose Towelette', N'image.gif', 12.9900, N'Don''t leave home without your monogrammed towelette! Made from lightweight, quick-dry fabric, this piece of equipment has more uses in a spy''s day than a Swiss Army knife. The perfect all-around tool while undercover in the locker room: serves as towel, shield, disguise, sled, defensive weapon, whip and emergency food source. Handy bail gear for the Toaster Boat. Monogram included with purchase price.')
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ModelNumber], [ModelName], [ProductImage], [UnitCost], [Description]) VALUES (406, 19, N'GRTWTCH9', N'Multi-Purpose Watch', N'image.gif', 399.9900, N'In the tradition of famous spy movies, the Multi Purpose Watch comes with every convenience! Installed with lighter, TV, camera, schedule-organizing software, MP3 player, water purifier, spotlight, and tire pump. Special feature: Displays current date and time. Kitchen sink add-on will be available in the fall of 2001.')
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ModelNumber], [ModelName], [ProductImage], [UnitCost], [Description]) VALUES (397, 14, N'LSRPTR1', N'Nonexplosive Cigar', N'image.gif', 29.9900, N'Contrary to popular spy lore, not all cigars owned by spies explode! Best used during mission briefings, our Nonexplosive Cigar is really a cleverly-disguised, top-of-the-line, precision laser pointer. Make your next presentation a hit.')
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ModelNumber], [ModelName], [ProductImage], [UnitCost], [Description]) VALUES (372, 20, N'ICNCU', N'Perfect-Vision Glasses', N'image.gif', 129.9900, N'Avoid painful and potentially devastating laser eye surgery and contact lenses. Cheaper and more effective than a visit to the optometrist, these Perfect-Vision Glasses simply slide over nose and eyes and hook on ears. Suddenly you have 20/20 vision! Glasses also function as HUD (Heads Up Display) for most European sports cars manufactured after 1992.')
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ModelNumber], [ModelName], [ProductImage], [UnitCost], [Description]) VALUES (362, 14, N'LK4TLNT', N'Persuasive Pencil', N'image.gif', 1.9900, N'Persuade anyone to see your point of view!  Captivate your friends and enemies alike!  Draw the crime-scene or map out the chain of events.  All you need is several years of training or copious amounts of natural talent. You''re halfway there with the Persuasive Pencil. Purchase this item with the Retro Pocket Protector Rocket Pack for optimum disguise.')
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ModelNumber], [ModelName], [ProductImage], [UnitCost], [Description]) VALUES (373, 17, N'LKARCKT', N'Pocket Protector Rocket Pack', N'image.gif', 1.9900, N'Any debonair spy knows that this accoutrement is coming back in style. Flawlessly protects the pockets of your short-sleeved oxford from unsightly ink and pencil marks. But there''s more! Strap it on your back and it doubles as a rocket pack. Provides enough turbo-thrust for a 250-pound spy or a passel of small children. Maximum travel radius: 3000 miles.')
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ModelNumber], [ModelName], [ProductImage], [UnitCost], [Description]) VALUES (355, 16, N'RU007', N'Rain Racer 2000', N'image.gif', 1499.9900, N'Looks like an ordinary bumbershoot, but don''t be fooled! Simply place Rain Racer''s tip on the ground and press the release latch. Within seconds, this ordinary rain umbrella converts into a two-wheeled gas-powered mini-scooter. Goes from 0 to 60 in 7.5 seconds - even in a driving rain! Comes in black, blue, and candy-apple red.')
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ModelNumber], [ModelName], [ProductImage], [UnitCost], [Description]) VALUES (387, 20, N'SQRTME1', N'Remote Foliage Feeder', N'image.gif', 9.9900, N'Even spies need to care for their office plants.  With this handy remote watering device, you can water your flowers as a spy should, from the comfort of your chair.  Water your plants from up to 50 feet away.  Comes with an optional aiming system that can be mounted to the top for improved accuracy.')
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ModelNumber], [ModelName], [ProductImage], [UnitCost], [Description]) VALUES (390, 19, N'ULOST007', N'Rubber Stamp Beacon', N'image.gif', 129.9900, N'With the Rubber Stamp Beacon, you''ll never get lost on your missions again. As you proceed through complicated terrain, stamp a stationary object with this device. Once an object has been stamped, the stamp''s patented ink will emit a signal that can be detected up to 153.2 miles away by the receiver embedded in the device''s case. WARNING: Do not expose ink to water.')
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ModelNumber], [ModelName], [ProductImage], [UnitCost], [Description]) VALUES (393, 20, N'NOBOOBOO4U', N'Speed Bandages', N'image.GIF', 3.9900, N'Even spies make mistakes.  Barbed wire and guard dogs pose a threat of injury for the active spy.  Use our special bandages on cuts and bruises to rapidly heal the injury.  Depending on the severity of the wound, the bandages can take between 10 to 30 minutes to completely heal the injury.')
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ModelNumber], [ModelName], [ProductImage], [UnitCost], [Description]) VALUES (382, 20, N'CHEW99', N'Survival Bar', N'image.gif', 6.9900, N'Survive for up to four days in confinement with this handy item. Disguised as a common eraser, it''s really a high-calorie food bar. Stranded in hostile territory without hope of nourishment? Simply break off a small piece of the eraser and chew vigorously for at least twenty minutes. Developed by the same folks who created freeze-dried ice cream, powdered drink mix, and glow-in-the-dark shoelaces.')
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ModelNumber], [ModelName], [ProductImage], [UnitCost], [Description]) VALUES (389, 20, N'OPNURMIND', N'Telekinesis Spoon', N'image.gif', 2.9900, N'Learn to move things with your mind! Broaden your mental powers using this training device to hone telekinesis skills. Simply look at the device, concentrate, and repeat "There is no spoon" over and over.')
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ModelNumber], [ModelName], [ProductImage], [UnitCost], [Description]) VALUES (402, 20, N'C00LCMB1', N'Telescoping Comb', N'image.gif', 399.9900, N'Use the Telescoping Comb to track down anyone, anywhere! Deceptively simple, this is no normal comb. Flip the hidden switch and two telescoping lenses project forward creating a surprisingly powerful set of binoculars (50X). Night-vision add-on is available for midnight hour operations.')
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ModelNumber], [ModelName], [ProductImage], [UnitCost], [Description]) VALUES (367, 18, N'INCPPRCLP', N'The Incredible Versatile Paperclip', N'image.gif', 1.4900, N'This 0. 01 oz piece of metal is the most versatile item in any respectable spy''s toolbox and will come in handy in all sorts of situations. Serves as a wily lock pick, aerodynamic projectile (used in conjunction with Multi-Purpose Rubber Band), or escape-proof finger cuffs.  Best of all, small size and pliability means it fits anywhere undetected.  Order several today!')
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ModelNumber], [ModelName], [ProductImage], [UnitCost], [Description]) VALUES (368, 16, N'DNTRPR', N'Toaster Boat', N'image.gif', 19999.9800, N'Turn breakfast into a high-speed chase! In addition to toasting bagels and breakfast pastries, this inconspicuous toaster turns into a speedboat at the touch of a button. Boasting top speeds of 60 knots and an ultra-quiet motor, this valuable item will get you where you need to be ... fast! Best of all, Toaster Boat is easily repaired using a Versatile Paperclip or a standard butter knife. Manufacturer''s Warning: Do not submerge electrical items.')
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ModelNumber], [ModelName], [ProductImage], [UnitCost], [Description]) VALUES (379, 17, N'SHADE01', N'Ultra Violet Attack Defender', N'image.gif', 89.9900, N'Be safe and suave. A spy wearing this trendy article of clothing is safe from ultraviolet ray-gun attacks. Worn correctly, the Defender deflects rays from ultraviolet weapons back to the instigator. As a bonus, also offers protection against harmful solar ultraviolet rays, equivalent to SPF 50.')
INSERT [dbo].[Products] ([ProductID], [CategoryID], [ModelNumber], [ModelName], [ProductImage], [UnitCost], [Description]) VALUES (364, 19, N'NE1RPR', N'Universal Repair System', N'image.gif', 4.9900, N'Few people appreciate the awesome repair possibilities contained in a single roll of duct tape. In fact, some houses in the Midwest are made entirely out of the miracle material contained in every roll! Can be safely used to repair cars, computers, people, dams, and a host of other items.')
SET IDENTITY_INSERT [dbo].[Products] OFF
SET IDENTITY_INSERT [dbo].[ShoppingCart] ON 

INSERT [dbo].[ShoppingCart] ([RecordID], [CartID], [Quantity], [ProductID], [DateCreated]) VALUES (178, N'1e0ca7a9-fe5a-4c6b-84cc-21267a980d10', 1, 355, CAST(N'2010-06-08 12:44:01.217' AS DateTime))
INSERT [dbo].[ShoppingCart] ([RecordID], [CartID], [Quantity], [ProductID], [DateCreated]) VALUES (1239, N'd62c2500-22ee-4fe6-88cb-e761c2cd3db1', 1, 360, CAST(N'2016-05-25 10:52:47.340' AS DateTime))
INSERT [dbo].[ShoppingCart] ([RecordID], [CartID], [Quantity], [ProductID], [DateCreated]) VALUES (180, N'43f2a179-002c-42d7-94ff-fddb1a4fd88b', 1, 377, CAST(N'2010-11-11 11:06:47.370' AS DateTime))
INSERT [dbo].[ShoppingCart] ([RecordID], [CartID], [Quantity], [ProductID], [DateCreated]) VALUES (181, N'187961ca-cee3-4605-9a24-88f9f4d9f180', 1, 377, CAST(N'2010-11-11 11:10:30.187' AS DateTime))
INSERT [dbo].[ShoppingCart] ([RecordID], [CartID], [Quantity], [ProductID], [DateCreated]) VALUES (182, N'6f597696-6182-4b51-a9d7-dd4203d3000d', 1, 359, CAST(N'2010-11-11 11:23:07.120' AS DateTime))
INSERT [dbo].[ShoppingCart] ([RecordID], [CartID], [Quantity], [ProductID], [DateCreated]) VALUES (183, N'6f597696-6182-4b51-a9d7-dd4203d3000d', 1, 371, CAST(N'2010-11-11 11:23:10.387' AS DateTime))
INSERT [dbo].[ShoppingCart] ([RecordID], [CartID], [Quantity], [ProductID], [DateCreated]) VALUES (1246, N'c8b4f91f-5c06-42b3-bcd9-1e6c430be6ee', 1, 401, CAST(N'2016-05-25 16:17:05.957' AS DateTime))
INSERT [dbo].[ShoppingCart] ([RecordID], [CartID], [Quantity], [ProductID], [DateCreated]) VALUES (1259, N'91d1e6f8-1e0c-4964-8e07-8e2f3c566927', 2, 360, CAST(N'2016-06-07 15:02:46.363' AS DateTime))
INSERT [dbo].[ShoppingCart] ([RecordID], [CartID], [Quantity], [ProductID], [DateCreated]) VALUES (1260, N'd478034e-2aec-4175-a64a-4689f58fefc9', 1, 360, CAST(N'2016-08-17 12:19:45.633' AS DateTime))
INSERT [dbo].[ShoppingCart] ([RecordID], [CartID], [Quantity], [ProductID], [DateCreated]) VALUES (189, N'JoeUser', 1, 378, CAST(N'2010-11-11 11:26:31.947' AS DateTime))
INSERT [dbo].[ShoppingCart] ([RecordID], [CartID], [Quantity], [ProductID], [DateCreated]) VALUES (1238, N'612f4ca5-0b8e-4798-b530-778451752b81', 2, 360, CAST(N'2016-05-25 10:52:47.347' AS DateTime))
INSERT [dbo].[ShoppingCart] ([RecordID], [CartID], [Quantity], [ProductID], [DateCreated]) VALUES (1240, N'e75eea6f-aea5-4ff8-a37e-1468cee74ab5', 2, 360, CAST(N'2016-05-25 11:21:57.027' AS DateTime))
INSERT [dbo].[ShoppingCart] ([RecordID], [CartID], [Quantity], [ProductID], [DateCreated]) VALUES (1241, N'dac405da-f74a-487b-940e-8c090610ca12', 3, 360, CAST(N'2016-05-25 11:22:43.643' AS DateTime))
INSERT [dbo].[ShoppingCart] ([RecordID], [CartID], [Quantity], [ProductID], [DateCreated]) VALUES (1242, N'dba78492-aa47-42c6-b678-aa399aedff50', 1, 360, CAST(N'2016-05-25 12:05:04.047' AS DateTime))
INSERT [dbo].[ShoppingCart] ([RecordID], [CartID], [Quantity], [ProductID], [DateCreated]) VALUES (1243, N'10b56fa7-1181-42ea-8103-10869ab2fa90', 3, 360, CAST(N'2016-05-25 12:06:43.873' AS DateTime))
INSERT [dbo].[ShoppingCart] ([RecordID], [CartID], [Quantity], [ProductID], [DateCreated]) VALUES (1244, N'1fa6da52-972c-4289-b081-0468a7b2203c', 1, 376, CAST(N'2016-05-25 15:50:21.760' AS DateTime))
INSERT [dbo].[ShoppingCart] ([RecordID], [CartID], [Quantity], [ProductID], [DateCreated]) VALUES (1245, N'86343f91-1451-4707-aefb-9223c591c025', 1, 360, CAST(N'2016-05-25 16:11:08.050' AS DateTime))
INSERT [dbo].[ShoppingCart] ([RecordID], [CartID], [Quantity], [ProductID], [DateCreated]) VALUES (1247, N'5142e7e3-2b97-4159-aa2e-dc7584db156e', 1, 360, CAST(N'2016-05-25 16:18:29.620' AS DateTime))
INSERT [dbo].[ShoppingCart] ([RecordID], [CartID], [Quantity], [ProductID], [DateCreated]) VALUES (1248, N'2600d1b1-068f-4522-9783-1c4d2a18e9da', 1, 360, CAST(N'2016-05-25 16:20:20.760' AS DateTime))
INSERT [dbo].[ShoppingCart] ([RecordID], [CartID], [Quantity], [ProductID], [DateCreated]) VALUES (1249, N'f22a1740-0d7c-4bf3-b067-922322fd74e7', 1, 360, CAST(N'2016-05-25 16:30:19.677' AS DateTime))
INSERT [dbo].[ShoppingCart] ([RecordID], [CartID], [Quantity], [ProductID], [DateCreated]) VALUES (1250, N'c2aaacc1-032d-4f15-98ed-1987149702e5', 1, 360, CAST(N'2016-05-25 16:33:30.447' AS DateTime))
INSERT [dbo].[ShoppingCart] ([RecordID], [CartID], [Quantity], [ProductID], [DateCreated]) VALUES (1251, N'1c1d19b0-3808-4a86-a09e-94861d352cbd', 1, 360, CAST(N'2016-05-25 16:39:18.433' AS DateTime))
INSERT [dbo].[ShoppingCart] ([RecordID], [CartID], [Quantity], [ProductID], [DateCreated]) VALUES (1252, N'd9816469-941c-464d-a643-ecfc2c17e997', 1, 401, CAST(N'2016-05-25 16:42:30.777' AS DateTime))
INSERT [dbo].[ShoppingCart] ([RecordID], [CartID], [Quantity], [ProductID], [DateCreated]) VALUES (1253, N'259cd369-f166-454f-b3ef-30af70e0338e', 1, 360, CAST(N'2016-05-26 11:57:03.990' AS DateTime))
INSERT [dbo].[ShoppingCart] ([RecordID], [CartID], [Quantity], [ProductID], [DateCreated]) VALUES (1254, N'6930dc14-9a5f-4fe5-aa79-704ed3e087a3', 1, 360, CAST(N'2016-05-26 12:09:19.167' AS DateTime))
INSERT [dbo].[ShoppingCart] ([RecordID], [CartID], [Quantity], [ProductID], [DateCreated]) VALUES (1255, N'89b4ad08-bf33-46fb-adc1-dcc1bd36b5d3', 1, 360, CAST(N'2016-05-26 12:19:19.020' AS DateTime))
INSERT [dbo].[ShoppingCart] ([RecordID], [CartID], [Quantity], [ProductID], [DateCreated]) VALUES (1256, N'1e9c00d2-9782-45cd-9932-e58c34ffbce7', 8, 360, CAST(N'2016-05-26 14:29:26.277' AS DateTime))
INSERT [dbo].[ShoppingCart] ([RecordID], [CartID], [Quantity], [ProductID], [DateCreated]) VALUES (1257, N'b68c3c92-d08c-4d97-9863-236e7f93f759', 6, 360, CAST(N'2016-05-26 14:30:36.183' AS DateTime))
INSERT [dbo].[ShoppingCart] ([RecordID], [CartID], [Quantity], [ProductID], [DateCreated]) VALUES (1258, N'5771c4f3-cf65-4f8b-8c8b-e8cddd356673', 4, 360, CAST(N'2016-05-27 11:48:57.447' AS DateTime))
INSERT [dbo].[ShoppingCart] ([RecordID], [CartID], [Quantity], [ProductID], [DateCreated]) VALUES (1261, N'27988457-9a3a-4784-818b-003477b085df', 1, 376, CAST(N'2016-09-19 11:06:38.183' AS DateTime))
INSERT [dbo].[ShoppingCart] ([RecordID], [CartID], [Quantity], [ProductID], [DateCreated]) VALUES (1262, N'970d5fcb-92b2-4980-bb03-e1f5c0f6859c', 4, 372, CAST(N'2016-10-17 18:28:16.737' AS DateTime))
INSERT [dbo].[ShoppingCart] ([RecordID], [CartID], [Quantity], [ProductID], [DateCreated]) VALUES (1263, N'b9ef3c14-6005-41ba-9b93-b11c55b2c1d4', 5, 385, CAST(N'2017-01-04 17:17:57.897' AS DateTime))
SET IDENTITY_INSERT [dbo].[ShoppingCart] OFF
/****** Object:  Index [PK_Categories]    Script Date: 12/01/2017 14:34:56 ******/
ALTER TABLE [dbo].[Categories] ADD  CONSTRAINT [PK_Categories] PRIMARY KEY NONCLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [PK_Orders]    Script Date: 12/01/2017 14:34:56 ******/
ALTER TABLE [dbo].[Orders] ADD  CONSTRAINT [PK_Orders] PRIMARY KEY NONCLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [PK_Products]    Script Date: 12/01/2017 14:34:56 ******/
ALTER TABLE [dbo].[Products] ADD  CONSTRAINT [PK_Products] PRIMARY KEY NONCLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [PK_ShoppingCart]    Script Date: 12/01/2017 14:34:56 ******/
ALTER TABLE [dbo].[ShoppingCart] ADD  CONSTRAINT [PK_ShoppingCart] PRIMARY KEY NONCLUSTERED 
(
	[RecordID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_ShoppingCart]    Script Date: 12/01/2017 14:34:56 ******/
CREATE NONCLUSTERED INDEX [IX_ShoppingCart] ON [dbo].[ShoppingCart]
(
	[CartID] ASC,
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_Order_OrderDetails] FOREIGN KEY([OrderID])
REFERENCES [dbo].[Orders] ([OrderID])
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [FK_Order_OrderDetails]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_Categories] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Categories] ([CategoryID])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_Categories]
GO
ALTER TABLE [dbo].[Reviews]  WITH NOCHECK ADD  CONSTRAINT [FK_Reviews_Products] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ProductID])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[Reviews] CHECK CONSTRAINT [FK_Reviews_Products]
GO
ALTER TABLE [dbo].[ShoppingCart]  WITH CHECK ADD  CONSTRAINT [FK_ShoppingCart_Products] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ProductID])
GO
ALTER TABLE [dbo].[ShoppingCart] CHECK CONSTRAINT [FK_ShoppingCart_Products]
GO
/****** Object:  StoredProcedure [dbo].[SelectPurchasedWithProducts]    Script Date: 12/01/2017 14:34:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SelectPurchasedWithProducts]
 @ProductID int
AS
	SELECT  TOP 5 
    OrderDetails.ProductID,
    Products.ModelName,
    SUM(OrderDetails.Quantity) as TotalNum

FROM    
    OrderDetails
  INNER JOIN Products ON OrderDetails.ProductID = Products.ProductID

WHERE   OrderID IN 
(
    /* This inner query should retrieve all orders that have contained the productID */
    SELECT DISTINCT OrderID 
    FROM OrderDetails
    WHERE ProductID = @ProductID
)
AND OrderDetails.ProductID != @ProductID 

GROUP BY OrderDetails.ProductID, Products.ModelName 

ORDER BY TotalNum DESC
RETURN



GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "OrderDetails"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 219
               Right = 198
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Products"
            Begin Extent = 
               Top = 6
               Left = 236
               Bottom = 219
               Right = 396
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VewOrderDetails'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VewOrderDetails'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[30] 4[23] 2[28] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "OrderDetails"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Products"
            Begin Extent = 
               Top = 6
               Left = 457
               Bottom = 135
               Right = 627
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 2820
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 2010
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 4590
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ViewAlsoPurchased'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ViewAlsoPurchased'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Products"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ShoppingCart"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 135
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 5535
         Alias = 900
         Table = 2790
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ViewCart'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ViewCart'
GO
USE [master]
GO
ALTER DATABASE [COMMERCE] SET  READ_WRITE 
GO
