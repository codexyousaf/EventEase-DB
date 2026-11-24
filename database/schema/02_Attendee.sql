-- ============================================================
-- Table  : Attendee
-- Part   : 2 (People and Staff)
-- Purpose: People who register for the event
-- Run    : after the database EventEaseDB exists
-- ============================================================
USE EventEaseDB;
GO

IF OBJECT_ID(N'dbo.Attendee', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.Attendee
    (
        AttendeeID    INT IDENTITY(1,1) NOT NULL,
        FullName      NVARCHAR(100)     NOT NULL,
        Phone         VARCHAR(20)       NOT NULL,
        Email         NVARCHAR(100)     NOT NULL,
        PasswordHash  VARBINARY(256)    NOT NULL,
        CreatedAt     DATETIME2         NOT NULL
                      CONSTRAINT DF_Attendee_CreatedAt DEFAULT SYSDATETIME(),

        CONSTRAINT PK_Attendee       PRIMARY KEY (AttendeeID),
        CONSTRAINT UQ_Attendee_Email UNIQUE (Email)
    );
END
GO
