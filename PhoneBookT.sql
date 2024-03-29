USE [master]
GO
/****** Object:  Database [Phonebook]    Script Date: 3/22/2019 12:21:15 AM ******/
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
/****** Object:  UserDefinedTableType [dbo].[ListOfContacts]    Script Date: 3/22/2019 12:21:16 AM ******/
CREATE TYPE [dbo].[ListOfContacts] AS TABLE(
	[ContactDetail] [varchar](max) NOT NULL
)
GO
/****** Object:  Table [dbo].[ContactDetail]    Script Date: 3/22/2019 12:21:16 AM ******/
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
/****** Object:  Table [dbo].[ContactDetailType]    Script Date: 3/22/2019 12:21:16 AM ******/
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
/****** Object:  Table [dbo].[Contacts]    Script Date: 3/22/2019 12:21:16 AM ******/
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
/****** Object:  StoredProcedure [dbo].[spAddUpdateContact]    Script Date: 3/22/2019 12:21:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spAddUpdateContact]
(
   @FirstName varchar(100)
  ,@LastName varchar(100)
  ,@ContactId int =  null
  ,@ListOfEmail dbo.ListOfContacts READONLY
  ,@ListOfPhoneNumbers dbo.ListOfContacts READONLY
)
AS

BEGIN
	
	DECLARE @newContactId INT,
			@phoneContactTypeId INT,
			@emailContactTypeId INT

	SELECT @emailContactTypeId = c.ContactDetailTypeId
	FROM dbo.ContactDetailType c
	WHERE [ContactDetailType]= 'email'

	SELECT @phoneContactTypeId = c.ContactDetailTypeId
	FROM dbo.ContactDetailType c
	WHERE [ContactDetailType]= 'phone'


	BEGIN TRY	
		
		BEGIN TRANSACTION MAIN
			IF @ContactId IS NULL --Insert

			BEGIN

				INSERT INTO [dbo].[Contacts]
					   ([FirstName]
					   ,[LastName])
				 VALUES
					   (@FirstName
					   ,@LastName)

				SELECT @newContactId = SCOPE_IDENTITY()

				INSERT INTO [dbo].[ContactDetail] ([ContactId], [ContactDetailType], [ContactDetail])
				SELECT @newContactId, @phoneContactTypeId, lo.ContactDetail
				FROM @ListOfPhoneNumbers lo

				INSERT INTO [dbo].[ContactDetail] ([ContactId], [ContactDetailType], [ContactDetail])
				SELECT @newContactId, @emailContactTypeId, lo.ContactDetail
				FROM @ListOfEmail lo
	
			END
			ELSE --Update
				BEGIN
					UPDATE [dbo].[Contacts]
					SET FirstName = @FirstName
					   ,LastName = @LastName
					WHERE ContactId = @ContactId

					DELETE FROM [dbo].[ContactDetail]
					WHERE ContactId = @ContactId

					INSERT INTO [dbo].[ContactDetail] ([ContactId], [ContactDetailType], [ContactDetail])
					SELECT @contactId, @phoneContactTypeId, lo.ContactDetail
					FROM @ListOfPhoneNumbers lo

					INSERT INTO [dbo].[ContactDetail] ([ContactId], [ContactDetailType], [ContactDetail])
					SELECT @contactId, @emailContactTypeId, lo.ContactDetail
					FROM @ListOfEmail lo

				END
			COMMIT TRANSACTION MAIN
	END TRY
	BEGIN CATCH
		  IF (@@TRANCOUNT > 0)
	   BEGIN
		  ROLLBACK TRANSACTION SCHEDULEDELETE
		  PRINT 'Error detected, all changes reversed'
	   END 
		SELECT
			ERROR_NUMBER() AS ErrorNumber,
			ERROR_SEVERITY() AS ErrorSeverity,
			ERROR_STATE() AS ErrorState,
			ERROR_PROCEDURE() AS ErrorProcedure,
			ERROR_LINE() AS ErrorLine,
			ERROR_MESSAGE() AS ErrorMessage

	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[spDeleteContact]    Script Date: 3/22/2019 12:21:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spDeleteContact]
(
  @ContactId int
)
AS

BEGIN

	BEGIN TRY	
		
		BEGIN TRANSACTION MAIN

				DELETE FROM [dbo].[ContactDetail] 
				WHERE ContactId = @ContactId
				
				DELETE FROM [dbo].[Contacts]
				WHERE ContactId = @ContactId

			COMMIT TRANSACTION MAIN
	END TRY
	BEGIN CATCH
		  IF (@@TRANCOUNT > 0)
	   BEGIN
		  ROLLBACK TRANSACTION SCHEDULEDELETE
		  PRINT 'Error detected, all changes reversed'
	   END 
		SELECT
			ERROR_NUMBER() AS ErrorNumber,
			ERROR_SEVERITY() AS ErrorSeverity,
			ERROR_STATE() AS ErrorState,
			ERROR_PROCEDURE() AS ErrorProcedure,
			ERROR_LINE() AS ErrorLine,
			ERROR_MESSAGE() AS ErrorMessage

	END CATCH
END
GO
USE [master]
GO
ALTER DATABASE [Phonebook] SET  READ_WRITE 
GO
SET IDENTITY_INSERT [dbo].[ContactDetailType] ON 

INSERT [dbo].[ContactDetailType] ([ContactDetailTypeId], [ContactDetailType]) VALUES (1, N'Phone')
INSERT [dbo].[ContactDetailType] ([ContactDetailTypeId], [ContactDetailType]) VALUES (2, N'Email')
INSERT [dbo].[ContactDetailType] ([ContactDetailTypeId], [ContactDetailType]) VALUES (3, N'Fax')
SET IDENTITY_INSERT [dbo].[ContactDetailType] OFF