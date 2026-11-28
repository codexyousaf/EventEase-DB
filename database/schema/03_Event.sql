-- ============================================================
-- Table  : EVENT
-- ============================================================
USE EventEaseDB
Go

IF OBJECT_ID('dbo.Event') IS NULL
BEGIN
---Creating Schema for EVENT
CREATE TABLE Event (
    EventID INT IDENTITY(1,1) PRIMARY KEY,
    EventName NVARCHAR(100) NOT NULL,
    EventType VARCHAR(30) NOT NULL CHECK (EventType IN ('Wedding', 'University Function', 'Other')),
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    Description NVARCHAR(500) NULL,
    TotalCapacity INT NOT NULL CHECK (TotalCapacity > 0),
    Status VARCHAR(15) NOT NULL DEFAULT 'Draft' CHECK (Status IN ('Draft', 'Active', 'Completed', 'Cancelled')),
    CreatedBy INT NOT NULL,

    CONSTRAINT CK_Event_Dates CHECK (EndDate >= StartDate),
    CONSTRAINT FK_Event_Staff FOREIGN KEY (CreatedBy) REFERENCES Staff(StaffID)
);
END
GO


