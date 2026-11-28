
-- ============================================================
-- Sample data: Event (1), Hall (3) and Session (7)
-- Part       : 3 (Event Management)
-- Run        : after Event, Hall and Session table creation
--              and Staff sample data insertion
-- Note       : Event created by Admin (StaffID 1).
--              3 Halls with MinStaff (2, 2, 1).
--              Sessions assigned to StaffID 2 to 15.
-- ============================================================

USE EventEaseDB;
GO

-- ---------- Event: 1 University Student Week (CreatedBy = 1) ----------

IF NOT EXISTS (SELECT 1 FROM dbo.Event)
BEGIN
    INSERT INTO dbo.Event
    (
        EventName,
        EventType,
        StartDate,
        EndDate,
        Description,
        TotalCapacity,
        Status,
        CreatedBy
    )
    VALUES
    (
        'COMSATS Annual University Gala',
        'University Function',
        '2026-12-05',
        '2026-12-05',
        'A university event featuring entertainment, activities and networking specifically for students.',
        950,
        'Active',
        1
    );
END
GO


-- ---------- Hall: 3 Halls (MinStaff: 2, 2, 1) ----------

IF NOT EXISTS (SELECT 1 FROM dbo.Hall)
BEGIN
    DECLARE @EventID INT;

    SELECT @EventID = EventID
    FROM dbo.Event
    WHERE EventName = 'COMSATS Annual University Gala';

    IF @EventID IS NOT NULL
    BEGIN
        INSERT INTO dbo.Hall
        (
            EventID,
            HallName,
            Capacity,
            OpenTime,
            CloseTime,
            NoiseLimitDb,
            MinStaff
        )
        VALUES
        (
            @EventID,
            'Main Auditorium',
            400,
            '08:00',
            '22:00',
            85,
            2
        ),
        (
            @EventID,
            'Exhibition Hall',
            300,
            '08:00',
            '22:00',
            75,
            2
        ),
        (
            @EventID,
            'Seminar Hall',
            250,
            '08:00',
            '20:00',
            65,
            1
        );
    END
END
GO


-- ---------- Session: 7 Sessions across 3 Halls ----------

IF NOT EXISTS (SELECT 1 FROM dbo.Session)
BEGIN
    DECLARE @EventID INT;
    DECLARE @Hall1 INT, @Hall2 INT, @Hall3 INT;

    SELECT @EventID = EventID
    FROM dbo.Event
    WHERE EventName = 'COMSATS Annual University Gala';

    SELECT @Hall1 = HallID
    FROM dbo.Hall
    WHERE EventID = @EventID
      AND HallName = 'Main Auditorium';

    SELECT @Hall2 = HallID
    FROM dbo.Hall
    WHERE EventID = @EventID
      AND HallName = 'Exhibition Hall';

    SELECT @Hall3 = HallID
    FROM dbo.Hall
    WHERE EventID = @EventID
      AND HallName = 'Seminar Hall';

    IF @EventID IS NOT NULL
       AND @Hall1 IS NOT NULL
       AND @Hall2 IS NOT NULL
       AND @Hall3 IS NOT NULL
    BEGIN

        INSERT INTO dbo.Session
        (
            EventID,
            HallID,
            Title,
            FunctionName,
            StartTime,
            EndTime,
            ResponsibleStaffID,
            Status
        )
        VALUES

        -- Main Auditorium (Hall 1)
        (
            @EventID,
            @Hall1,
            'Opening Ceremony',
            'Welcome and Introduction',
            '2026-12-05 09:00',
            '2026-12-05 10:30',
            2,
            'Scheduled'
        ),
        (
            @EventID,
            @Hall1,
            'Guest Speaker Session',
            'Motivational Talk',
            '2026-12-05 11:00',
            '2026-12-05 12:30',
            3,
            'Scheduled'
        ),
        (
            @EventID,
            @Hall1,
            'Musical Night',
            'Live Music Performance',
            '2026-12-05 18:00',
            '2026-12-05 21:00',
            4,
            'Scheduled'
        ),

        -- Exhibition Hall (Hall 2)
        (
            @EventID,
            @Hall2,
            'Technology Exhibition',
            'Student Projects Showcase',
            '2026-12-05 10:00',
            '2026-12-05 13:00',
            5,
            'Scheduled'
        ),
        (
            @EventID,
            @Hall2,
            'Startup Competition',
            'Entrepreneurship and Innovation',
            '2026-12-05 14:00',
            '2026-12-05 16:30',
            6,
            'Scheduled'
        ),

        -- Seminar Hall (Hall 3)
        (
            @EventID,
            @Hall3,
            'AI and Future Technology',
            'Technical Seminar',
            '2026-12-05 10:00',
            '2026-12-05 12:00',
            7,
            'Scheduled'
        ),
        (
            @EventID,
            @Hall3,
            'Career Guidance Session',
            'Career and Internship Discussion',
            '2026-12-05 14:00',
            '2026-12-05 15:30',
            8,
            'Scheduled'
        );

    END
END
GO


-- ---------- Verification ----------

SELECT * FROM dbo.Event;

SELECT * FROM dbo.Hall;

SELECT * FROM dbo.Session;
GO
