-- ============================================================
-- Table  : Session
-- ============================================================
USE EventEaseDB
Go

---Creating Schema for Session
    CREATE TABLE Session (
    SessionID INT IDENTITY(1,1) PRIMARY KEY,
    EventID INT NOT NULL,
    HallID INT NOT NULL,
    Title NVARCHAR(100) NOT NULL,
    FunctionName NVARCHAR(100) NULL,
    StartTime DATETIME2 NOT NULL,
    EndTime DATETIME2 NOT NULL,
    ResponsibleStaffID INT NULL,
    Status VARCHAR(15) NOT NULL DEFAULT 'Scheduled' CHECK (Status IN ('Scheduled', 'Changed', 'Cancelled')),

    CONSTRAINT FK_Session_Event FOREIGN KEY (EventID) REFERENCES Event(EventID),
    CONSTRAINT FK_Session_Hall FOREIGN KEY (HallID) REFERENCES Hall(HallID),
    CONSTRAINT FK_Session_Staff FOREIGN KEY (ResponsibleStaffID) REFERENCES Staff(StaffID),
    CONSTRAINT CK_Session_Times CHECK (EndTime > StartTime)
);

