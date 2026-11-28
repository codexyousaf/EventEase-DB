-- ============================================================
-- Sample data: Staff (1 Admin + 14 Staff) and Attendee (60)
-- Part       : 2 (People and Staff)
-- Run        : after 01_Staff.sql and 02_Attendee.sql
-- Note       : passwords are hashed with a salt (demo values only).
--              Each block only runs if its table is still empty.
-- ============================================================
USE EventEaseDB;
GO

-- ---------- Staff: 1 Admin (StaffID 1) + 14 Staff (StaffID 2 to 15) ----------
IF NOT EXISTS (SELECT 1 FROM dbo.Staff)
BEGIN
    INSERT INTO dbo.Staff (FullName, Phone, Email, Role, PasswordHash, AvailableFrom, AvailableTo)
    SELECT v.FullName, v.Phone, v.Email, v.Role,
           HASHBYTES('SHA2_256', CONCAT('S@lt-', v.Email, '-Pass@123')),
           v.AvFrom, v.AvTo
    FROM (VALUES
        ('Ayesha Khan',     '0300-1000001', 'admin@eventease.pk',    'Admin', '08:00', '20:00'),
        ('Bilal Ahmed',     '0300-1000002', 'bilal@eventease.pk',    'Staff', '08:00', '18:00'),
        ('Sana Malik',      '0300-1000003', 'sana@eventease.pk',     'Staff', '09:00', '19:00'),
        ('Usman Raza',      '0300-1000004', 'usman@eventease.pk',    'Staff', '08:00', '16:00'),
        ('Hira Siddiqui',   '0300-1000005', 'hira@eventease.pk',     'Staff', '10:00', '20:00'),
        ('Hassan Raza',     '0300-1000006', 'hassan@eventease.pk',   'Staff', '08:00', '18:00'),
        ('Mehwish Anwar',   '0300-1000007', 'mehwish@eventease.pk',  'Staff', '09:00', '19:00'),
        ('Talha Mehmood',   '0300-1000008', 'talha@eventease.pk',    'Staff', '12:00', '20:00'),
        ('Rabia Noor',      '0300-1000009', 'rabia@eventease.pk',    'Staff', '09:00', '18:00'),
        ('Kamran Ali',      '0300-1000010', 'kamran@eventease.pk',   'Staff', '12:00', '20:00'),
        ('Sidra Bashir',    '0300-1000011', 'sidra@eventease.pk',    'Staff', '08:00', '14:00'),
        ('Waqar Hussain',   '0300-1000012', 'waqar@eventease.pk',    'Staff', '10:00', '20:00'),
        ('Amna Farooq',     '0300-1000013', 'amna@eventease.pk',     'Staff', '09:00', '19:00'),
        ('Junaid Akhtar',   '0300-1000014', 'junaid@eventease.pk',   'Staff', '08:00', '16:00'),
        ('Komal Shehzadi',  '0300-1000015', 'komal@eventease.pk',    'Staff', '08:00', '20:00')
    ) AS v (FullName, Phone, Email, Role, AvFrom, AvTo);
END
GO

-- ---------- Attendee: 60 people (10 first names x 6 last names) ----------
IF NOT EXISTS (SELECT 1 FROM dbo.Attendee)
BEGIN
    ;WITH FirstNames (fn) AS
    (
        SELECT t.v FROM (VALUES
            ('Zainab'), ('Hamza'), ('Maryam'), ('Ali'), ('Noor'),
            ('Saad'), ('Iqra'), ('Danish'), ('Laiba'), ('Faizan')
        ) AS t (v)
    ),
    LastNames (ln) AS
    (
        SELECT t.v FROM (VALUES
            ('Tariq'), ('Iqbal'), ('Hassan'), ('Shah'), ('Butt'), ('Javed')
        ) AS t (v)
    ),
    Combos AS
    (
        SELECT f.fn, l.ln,
               ROW_NUMBER() OVER (ORDER BY l.ln, f.fn) AS rn
        FROM FirstNames AS f
        CROSS JOIN LastNames AS l
    )
    INSERT INTO dbo.Attendee (FullName, Phone, Email, PasswordHash, CreatedAt)
    SELECT fn + ' ' + ln,
           '0311-1' + RIGHT('000000' + CAST(rn AS VARCHAR(6)), 6),
           LOWER(fn) + '.' + LOWER(ln) + '@mail.com',
           HASHBYTES('SHA2_256', CONCAT('S@lt-', rn, '-Pass@123')),
           DATEADD(MINUTE, rn * 7, CAST('2026-11-01 09:00' AS DATETIME2))   -- different registration times
    FROM Combos;
END
GO
