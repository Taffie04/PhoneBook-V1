USE [master]
GO
/****** Object:  Database [Phonebook]    Script Date: 3/20/2019 12:43:11 AM ******/
CREATE DATABASE [Phonebook]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Phonebook', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\Phonebook.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Phonebook_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\Phonebook_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [Phonebook] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Phonebook].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Phonebook] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Phonebook] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Phonebook] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Phonebook] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Phonebook] SET ARITHABORT OFF 
GO
ALTER DATABASE [Phonebook] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Phonebook] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Phonebook] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Phonebook] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Phonebook] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Phonebook] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Phonebook] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Phonebook] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Phonebook] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Phonebook] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Phonebook] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Phonebook] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Phonebook] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Phonebook] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Phonebook] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Phonebook] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Phonebook] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Phonebook] SET RECOVERY FULL 
GO
ALTER DATABASE [Phonebook] SET  MULTI_USER 
GO
ALTER DATABASE [Phonebook] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Phonebook] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Phonebook] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Phonebook] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Phonebook] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'Phonebook', N'ON'
GO
ALTER DATABASE [Phonebook] SET QUERY_STORE = OFF
GO
USE [Phonebook]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
USE [Phonebook]
GO
/****** Object:  UserDefinedTableType [dbo].[ListOfContacts]    Script Date: 3/20/2019 12:43:11 AM ******/
CREATE TYPE [dbo].[ListOfContacts] AS TABLE(
	[ContactDetail] [varchar](50) NOT NULL,
	PRIMARY KEY CLUSTERED 
(
	[ContactDetail] ASC
)WITH (IGNORE_DUP_KEY = OFF)
)
GO
/****** Object:  Table [dbo].[ContactDetail]    Script Date: 3/20/2019 12:43:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ContactDetail](
	[ContactDetailID] [int] IDENTITY(1,1) NOT NULL,
	[ContactId] [int] NOT NULL,
	[ContactDetailType] [int] NOT NULL,
	[ContactDetail] [varchar](50) NULL,
 CONSTRAINT [PK_ContactDetail] PRIMARY KEY CLUSTERED 
(
	[ContactDetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ContactDetailType]    Script Date: 3/20/2019 12:43:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ContactDetailType](
	[ContactDetailTypeId] [int] IDENTITY(1,1) NOT NULL,
	[ContactDetailType] [varchar](50) NOT NULL,
 CONSTRAINT [PK_ContactDetailType] PRIMARY KEY CLUSTERED 
(
	[ContactDetailTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Contacts]    Script Date: 3/20/2019 12:43:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Contacts](
	[ContactId] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [varchar](100) NOT NULL,
	[LastName] [varchar](100) NOT NULL,
 CONSTRAINT [PK_Contacts] PRIMARY KEY CLUSTERED 
(
	[ContactId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[ContactDetail] ON 

INSERT [dbo].[ContactDetail] ([ContactDetailID], [ContactId], [ContactDetailType], [ContactDetail]) VALUES (1, 1, 1, N'0789658745')
INSERT [dbo].[ContactDetail] ([ContactDetailID], [ContactId], [ContactDetailType], [ContactDetail]) VALUES (2, 1, 2, N'email@test.com')
INSERT [dbo].[ContactDetail] ([ContactDetailID], [ContactId], [ContactDetailType], [ContactDetail]) VALUES (5, 1, 1, N'rest@rest.com')
INSERT [dbo].[ContactDetail] ([ContactDetailID], [ContactId], [ContactDetailType], [ContactDetail]) VALUES (6, 2, 1, N'98545555')
INSERT [dbo].[ContactDetail] ([ContactDetailID], [ContactId], [ContactDetailType], [ContactDetail]) VALUES (7, 2, 1, N'343544564')
INSERT [dbo].[ContactDetail] ([ContactDetailID], [ContactId], [ContactDetailType], [ContactDetail]) VALUES (8, 2, 2, N'it@it.com')
INSERT [dbo].[ContactDetail] ([ContactDetailID], [ContactId], [ContactDetailType], [ContactDetail]) VALUES (9, 3, 1, N'3425234523')
INSERT [dbo].[ContactDetail] ([ContactDetailID], [ContactId], [ContactDetailType], [ContactDetail]) VALUES (10, 3, 1, N'3238942')
INSERT [dbo].[ContactDetail] ([ContactDetailID], [ContactId], [ContactDetailType], [ContactDetail]) VALUES (11, 3, 2, N'ge@ge.com')
INSERT [dbo].[ContactDetail] ([ContactDetailID], [ContactId], [ContactDetailType], [ContactDetail]) VALUES (12, 3, 2, N'we@we.com')
SET IDENTITY_INSERT [dbo].[ContactDetail] OFF
SET IDENTITY_INSERT [dbo].[ContactDetailType] ON 

INSERT [dbo].[ContactDetailType] ([ContactDetailTypeId], [ContactDetailType]) VALUES (1, N'Phone')
INSERT [dbo].[ContactDetailType] ([ContactDetailTypeId], [ContactDetailType]) VALUES (2, N'Email')
INSERT [dbo].[ContactDetailType] ([ContactDetailTypeId], [ContactDetailType]) VALUES (3, N'Fax')
SET IDENTITY_INSERT [dbo].[ContactDetailType] OFF
SET IDENTITY_INSERT [dbo].[Contacts] ON 

INSERT [dbo].[Contacts] ([ContactId], [FirstName], [LastName]) VALUES (1, N'Kampos', N'Gondooo')
INSERT [dbo].[Contacts] ([ContactId], [FirstName], [LastName]) VALUES (2, N'Tafadzwa', N'Gondo')
INSERT [dbo].[Contacts] ([ContactId], [FirstName], [LastName]) VALUES (3, N'Simon', N'Gondogwa')
SET IDENTITY_INSERT [dbo].[Contacts] OFF
USE [master]
GO
ALTER DATABASE [Phonebook] SET  READ_WRITE 
GO
