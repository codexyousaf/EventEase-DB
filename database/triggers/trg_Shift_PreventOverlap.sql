-- ============================================================
-- Trigger: trg_Shift_PreventOverlap
-- Part   : 2 (People and Staff)
-- Purpose: A staff member can never have two overlapping shifts
--          on the same date. Declined shifts are ignored.
--          Back-to-back shifts (13:00 end, 13:00 start) are allowed.
-- Run    : AFTER 06_Shift.sql
-- ============================================================
USE EventEaseDB;
GO

CREATE OR ALTER TRIGGER dbo.trg_Shift_PreventOverlap
ON dbo.Shift
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS
    (
        SELECT 1
        FROM inserted AS i
        JOIN dbo.Shift AS s
              ON  s.StaffID   = i.StaffID
              AND s.ShiftDate = i.ShiftDate
              AND s.ShiftID  <> i.ShiftID
        WHERE i.Status <> 'Declined'
          AND s.Status <> 'Declined'
          AND s.StartTime < i.EndTime     -- the two time ranges overlap
          AND s.EndTime   > i.StartTime
    )
    BEGIN
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        THROW 50001, 'Overlapping shift: this staff member already has a shift at that time.', 1;
    END
END
GO
