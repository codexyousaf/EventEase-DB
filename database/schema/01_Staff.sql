-- ============================================================
-- Table  : Staff
-- Part   : 2 (People and Staff)
-- Purpose: Admin and Staff accounts, roles and available times
-- Run    : after the database EventEaseDB exists
-- ============================================================
USE EventEaseDB;
GO

IF OBJECT_ID(N'dbo.Staff', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.Staff
    (
        StaffID        INT IDENTITY(1,1) NOT NULL,
        FullName       NVARCHAR(100)     NOT NULL,
        Phone          VARCHAR(20)       NOT NULL,
        Email          NVARCHAR(100)     NOT NULL,
        Role           VARCHAR(10)       NOT NULL,
        PasswordHash   VARBINARY(256)    NOT NULL,
        AvailableFrom  TIME              NULL,
        AvailableTo    TIME              NULL,

        CONSTRAINT PK_Staff           PRIMARY KEY (StaffID),
        CONSTRAINT UQ_Staff_Email     UNIQUE (Email),
        CONSTRAINT CK_Staff_Role      CHECK (Role IN ('Admin', 'Staff')),
        CONSTRAINT CK_Staff_Available CHECK (AvailableFrom IS NULL
                                          OR AvailableTo   IS NULL
                                          OR AvailableTo > AvailableFrom)
    );
END
GO
