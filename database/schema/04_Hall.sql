-- ============================================================
-- Table  : Hall
-- ============================================================
USE EventEaseDB
Go

---Creating Schema for Hall
CREATE TABLE Hall (
    HallID INT IDENTITY(1,1) PRIMARY KEY,
    EventID INT NOT NULL,
    HallName NVARCHAR(50) NOT NULL,
    Capacity INT NOT NULL CHECK (Capacity > 0),
    OpenTime TIME NOT NULL,
    CloseTime TIME NOT NULL,
    NoiseLimitDb INT NULL,
    MinStaff INT NOT NULL DEFAULT 1 CHECK (MinStaff >= 0),

    CONSTRAINT FK_Hall_Event FOREIGN KEY (EventID) REFERENCES Event(EventID),
    CONSTRAINT UQ_Hall_Event_HallName UNIQUE (EventID, HallName),
    CONSTRAINT CK_Hall_Hours CHECK (CloseTime > OpenTime)
);