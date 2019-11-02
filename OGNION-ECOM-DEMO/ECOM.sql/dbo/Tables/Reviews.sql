CREATE TABLE [dbo].[Reviews] (
    [ReviewID]      INT             IDENTITY (1, 1) NOT NULL,
    [ProductID]     INT             NOT NULL,
    [CustomerName]  NVARCHAR (50)   NULL,
    [CustomerEmail] NVARCHAR (50)   NULL,
    [Rating]        INT             NOT NULL,
    [Comments]      NVARCHAR (3850) NULL,
    CONSTRAINT [PK_Reviews] PRIMARY KEY CLUSTERED ([ReviewID] ASC),
    CONSTRAINT [FK_Reviews_Products] FOREIGN KEY ([ProductID]) REFERENCES [dbo].[Products] ([ProductID]) NOT FOR REPLICATION
);

