-- ============================================================
-- Table  : Shift
-- Part   : 2 (People and Staff)
-- Purpose: Staff assignments to halls and times
-- Run    : AFTER 01_Staff.sql and Part 1's 04_Hall.sql
--          (Shift has foreign keys to Staff and Hall)
-- ============================================================
USE EventEaseDB;
GO

IF OBJECT_ID(N'dbo.Shift', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.Shift
    (
        ShiftID    INT IDENTITY(1,1) NOT NULL,
        StaffID    INT               NOT NULL,
        HallID     INT               NOT NULL,
        ShiftDate  DATE              NOT NULL,
        StartTime  TIME              NOT NULL,
        EndTime    TIME              NOT NULL,
        Status     VARCHAR(10)       NOT NULL
                   CONSTRAINT DF_Shift_Status DEFAULT 'Assigned',

        CONSTRAINT PK_Shift        PRIMARY KEY (ShiftID),
        CONSTRAINT FK_Shift_Staff  FOREIGN KEY (StaffID) REFERENCES dbo.Staff (StaffID),
        CONSTRAINT FK_Shift_Hall   FOREIGN KEY (HallID)  REFERENCES dbo.Hall  (HallID),
        CONSTRAINT CK_Shift_Time   CHECK (EndTime > StartTime),
        CONSTRAINT CK_Shift_Status CHECK (Status IN ('Assigned', 'Accepted', 'Declined'))
    );

    -- Speeds up the overlap trigger and "shifts of one staff member" queries
    CREATE INDEX IX_Shift_Staff_Date ON dbo.Shift (StaffID, ShiftDate);
    CREATE INDEX IX_Shift_Hall_Date  ON dbo.Shift (HallID, ShiftDate);
END
GO
