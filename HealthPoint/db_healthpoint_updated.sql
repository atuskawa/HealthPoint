-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 29, 2026 at 08:10 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_healthpoint`
--

-- --------------------------------------------------------

--
-- Table structure for table `appointments`
--

CREATE TABLE `appointments` (
  `AppointmentID` int(11) NOT NULL,
  `PatientID` int(11) DEFAULT NULL,
  `DoctorID` int(11) DEFAULT NULL,
  `ScheduledDate` datetime DEFAULT NULL,
  `Status` enum('Pending','Approved','Rescheduled','Completed','Cancelled') DEFAULT NULL,
  `DoctorRemarks` varchar(255) DEFAULT NULL,
  `CreatedAt` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `appointments`
--

INSERT INTO `appointments` (`AppointmentID`, `PatientID`, `DoctorID`, `ScheduledDate`, `Status`, `DoctorRemarks`, `CreatedAt`) VALUES
(5, 1, 1, '2026-02-05 10:00:00', 'Pending', NULL, '2026-01-29 11:30:38'),
(6, 2, 2, '2026-02-06 14:30:00', 'Approved', NULL, '2026-01-29 11:30:38'),
(7, 3, 3, '2026-02-05 10:30:00', 'Rescheduled', NULL, '2026-01-29 11:30:38'),
(8, 4, 1, '2026-02-06 10:30:00', 'Cancelled', NULL, '2026-01-29 11:30:38');

-- --------------------------------------------------------

--
-- Table structure for table `appointment_symptoms`
--

CREATE TABLE `appointment_symptoms` (
  `AppointmentSymptomID` int(11) NOT NULL,
  `AppointmentID` int(11) DEFAULT NULL,
  `SymptomID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `appointment_symptoms`
--

INSERT INTO `appointment_symptoms` (`AppointmentSymptomID`, `AppointmentID`, `SymptomID`) VALUES
(11, 5, 1),
(12, 6, 3),
(13, 6, 4),
(14, 7, 1),
(15, 7, 2),
(16, 7, 3),
(17, 8, 1),
(18, 8, 2),
(19, 8, 3),
(20, 8, 4);

-- --------------------------------------------------------

--
-- Table structure for table `checkup_results`
--

CREATE TABLE `checkup_results` (
  `ResultID` int(11) NOT NULL,
  `AppointmentID` int(11) DEFAULT NULL,
  `FinalDiagnosis` varchar(100) DEFAULT NULL,
  `DoctorNotes` text DEFAULT NULL,
  `ResultDate` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `checkup_results`
--

INSERT INTO `checkup_results` (`ResultID`, `AppointmentID`, `FinalDiagnosis`, `DoctorNotes`, `ResultDate`) VALUES
(1, 6, 'Migraine', 'Patient advised to rest and avoid stress', '2026-01-29 11:49:14');

-- --------------------------------------------------------

--
-- Table structure for table `consultations`
--

CREATE TABLE `consultations` (
  `ConsultID` int(11) NOT NULL,
  `AppointmentID` int(11) NOT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `conversation` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `doctors`
--

CREATE TABLE `doctors` (
  `DoctorID` int(11) NOT NULL,
  `DoctorFullName` varchar(150) DEFAULT NULL,
  `UserID` int(11) NOT NULL,
  `Specialization` varchar(100) NOT NULL,
  `LicenseNumber` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `doctors`
--

INSERT INTO `doctors` (`DoctorID`, `DoctorFullName`, `UserID`, `Specialization`, `LicenseNumber`) VALUES
(1, 'Dela Cruz, Juan Santos', 1, 'General Medicine', 'LIC-12345'),
(2, 'Reyes, Maria Lopez', 2, 'Internal Medicine', 'LIC-67890'),
(3, 'Torres, Ana Villanueva', 3, 'Orthopedic', 'LIC-15973');

--
-- Triggers `doctors`
--
DELIMITER $$
CREATE TRIGGER `trg_doctor_fullname` BEFORE INSERT ON `doctors` FOR EACH ROW SET NEW.DoctorFullName = (
  SELECT CONCAT(
    UserLastName, ', ',
    UserFirstName, ' ',
    UserMidName
  )
  FROM users
  WHERE UserID = NEW.UserID
)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `follow_up_checkups`
--

CREATE TABLE `follow_up_checkups` (
  `FollowUpID` int(11) NOT NULL,
  `ResultID` int(11) DEFAULT NULL,
  `RecommendedDate` date DEFAULT NULL,
  `Notes` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `follow_up_checkups`
--

INSERT INTO `follow_up_checkups` (`FollowUpID`, `ResultID`, `RecommendedDate`, `Notes`) VALUES
(1, 1, '2026-02-20', 'Return if symptoms persist');

-- --------------------------------------------------------

--
-- Table structure for table `medicines`
--

CREATE TABLE `medicines` (
  `MedicineID` int(11) NOT NULL,
  `MedicineName` varchar(100) DEFAULT NULL,
  `Description` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `medicines`
--

INSERT INTO `medicines` (`MedicineID`, `MedicineName`, `Description`) VALUES
(1, 'Paracetamol', 'Pain and fever reducer'),
(2, 'Ibuprofen', 'Anti-inflammatory pain reliever');

-- --------------------------------------------------------

--
-- Table structure for table `patients`
--

CREATE TABLE `patients` (
  `PatientID` int(11) NOT NULL,
  `PatientFullName` varchar(150) DEFAULT NULL,
  `UserID` int(11) NOT NULL,
  `BirthDate` date NOT NULL,
  `Gender` enum('Male','Female') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `patients`
--

INSERT INTO `patients` (`PatientID`, `PatientFullName`, `UserID`, `BirthDate`, `Gender`) VALUES
(1, 'Farala, Joshua Vladimir Villanueva', 4, '2000-01-01', 'Male'),
(2, 'Yatco, Josh Francis', 5, '2001-01-02', 'Male'),
(3, 'Antaran, Rannie Paul', 6, '2001-01-03', 'Male'),
(4, 'Elequin, Timothy Judd', 7, '2001-01-04', 'Male');

--
-- Triggers `patients`
--
DELIMITER $$
CREATE TRIGGER `trg_patient_fullname` BEFORE INSERT ON `patients` FOR EACH ROW SET NEW.PatientFullName = (
  SELECT CONCAT(
    UserLastName, ', ',
    UserFirstName, ' ',
    UserMidName
  )
  FROM users
  WHERE UserID = NEW.UserID
)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `predictions`
--

CREATE TABLE `predictions` (
  `PredictionID` int(11) NOT NULL,
  `PredictedIllness` varchar(100) DEFAULT NULL,
  `ConfidenceLevel` int(3) DEFAULT NULL,
  `CreatedAt` datetime DEFAULT current_timestamp(),
  `ConsultID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `predictions`
--

INSERT INTO `predictions` (`PredictionID`, `PredictedIllness`, `ConfidenceLevel`, `CreatedAt`, `ConsultID`) VALUES
(1, 'Flu', 80, '2026-01-29 11:48:24', NULL),
(2, 'Migraine', 75, '2026-01-29 11:48:24', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `prescriptions`
--

CREATE TABLE `prescriptions` (
  `PrescriptionID` int(11) NOT NULL,
  `ResultID` int(11) DEFAULT NULL,
  `MedicineID` int(11) DEFAULT NULL,
  `Dosage` varchar(50) DEFAULT NULL,
  `Frequency` varchar(50) DEFAULT NULL,
  `Duration` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `prescriptions`
--

INSERT INTO `prescriptions` (`PrescriptionID`, `ResultID`, `MedicineID`, `Dosage`, `Frequency`, `Duration`) VALUES
(1, 1, 1, '500mg', 'Every 6 hours', '5 days'),
(2, 1, 2, '200mg', 'Every 8 hours', '3 days');

-- --------------------------------------------------------

--
-- Table structure for table `symptoms`
--

CREATE TABLE `symptoms` (
  `SymptomID` int(11) NOT NULL,
  `SymptomName` varchar(100) DEFAULT NULL,
  `Description` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `symptoms`
--

INSERT INTO `symptoms` (`SymptomID`, `SymptomName`, `Description`) VALUES
(1, 'Fever', 'Body temperature above normal'),
(2, 'Cough', 'Persistent dry or wet cough'),
(3, 'Headache', 'Pain in the head region'),
(4, 'Fatigue', 'Extreme tiredness');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `UserID` int(11) NOT NULL,
  `UserFirstName` varchar(50) DEFAULT NULL,
  `UserMidName` varchar(50) DEFAULT NULL,
  `UserLastName` varchar(50) DEFAULT NULL,
  `UserRole` enum('Doctor','Patient') DEFAULT NULL,
  `Email` varchar(100) NOT NULL,
  `Password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`UserID`, `UserFirstName`, `UserMidName`, `UserLastName`, `UserRole`, `Email`, `Password`) VALUES
(1, 'Juan', 'Santos', 'Dela Cruz', 'Doctor', 'juan.dc@email.com', 'docadm123'),
(2, 'Maria', 'Lopez', 'Reyes', 'Doctor', 'maria.reyes@email.com', 'docadm123'),
(3, 'Ana', 'Villanueva', 'Torres', 'Doctor', 'ana.torres@email.com', 'docadm123'),
(4, 'Joshua Vladimir', 'Villanueva', 'Farala', 'Patient', 'jv_farala@gmail.com', 'userpat123'),
(5, 'Josh', 'Francis', 'Yatco', 'Patient', 'jf_yatco@gmail.com', 'userpat123'),
(6, 'Rannie', 'Paul', 'Antaran', 'Patient', 'rp_antaran@gmail.com', 'userpat123'),
(7, 'Timothy', 'Judd', 'Elequin', 'Patient', 'tj_elequin@gmail.com', 'userpat123');

-- --------------------------------------------------------

--
-- Stand-in structure for view `vw_appointments`
-- (See below for the actual view)
--
CREATE TABLE `vw_appointments` (
`AppointmentID` int(11)
,`PatientFullName` varchar(153)
,`DoctorFullName` varchar(153)
,`ScheduledDate` datetime
,`Status` enum('Pending','Approved','Rescheduled','Completed','Cancelled')
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `vw_consultations`
-- (See below for the actual view)
--
CREATE TABLE `vw_consultations` (
`ConsultID` int(11)
,`created_at` datetime
,`PatientFullName` varchar(153)
,`DoctorFullName` varchar(153)
,`conversation` text
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `vw_doctors`
-- (See below for the actual view)
--
CREATE TABLE `vw_doctors` (
`DoctorID` int(11)
,`UserID` int(11)
,`DoctorFullName` varchar(153)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `vw_patients`
-- (See below for the actual view)
--
CREATE TABLE `vw_patients` (
`PatientID` int(11)
,`UserID` int(11)
,`PatientFullName` varchar(153)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `vw_predictions`
-- (See below for the actual view)
--
CREATE TABLE `vw_predictions` (
`PredictionID` int(11)
,`ConsultID` int(11)
,`DoctorFullName` varchar(153)
,`PatientFullName` varchar(153)
,`PredictedIllness` varchar(100)
,`ConfidenceLevel` int(3)
,`CreatedAt` datetime
);

-- --------------------------------------------------------

--
-- Structure for view `vw_appointments`
--
DROP TABLE IF EXISTS `vw_appointments`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_appointments`  AS SELECT `a`.`AppointmentID` AS `AppointmentID`, concat(`up`.`UserLastName`,', ',`up`.`UserFirstName`,' ',`up`.`UserMidName`) AS `PatientFullName`, concat(`ud`.`UserLastName`,', ',`ud`.`UserFirstName`,' ',`ud`.`UserMidName`) AS `DoctorFullName`, `a`.`ScheduledDate` AS `ScheduledDate`, `a`.`Status` AS `Status` FROM ((((`appointments` `a` join `patients` `p` on(`a`.`PatientID` = `p`.`PatientID`)) join `users` `up` on(`p`.`UserID` = `up`.`UserID`)) join `doctors` `d` on(`a`.`DoctorID` = `d`.`DoctorID`)) join `users` `ud` on(`d`.`UserID` = `ud`.`UserID`)) ;

-- --------------------------------------------------------

--
-- Structure for view `vw_consultations`
--
DROP TABLE IF EXISTS `vw_consultations`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_consultations`  AS SELECT `c`.`ConsultID` AS `ConsultID`, `c`.`created_at` AS `created_at`, concat(`up`.`UserLastName`,', ',`up`.`UserFirstName`,' ',`up`.`UserMidName`) AS `PatientFullName`, concat(`ud`.`UserLastName`,', ',`ud`.`UserFirstName`,' ',`ud`.`UserMidName`) AS `DoctorFullName`, `c`.`conversation` AS `conversation` FROM (((((`consultations` `c` join `appointments` `a` on(`c`.`AppointmentID` = `a`.`AppointmentID`)) join `patients` `p` on(`a`.`PatientID` = `p`.`PatientID`)) join `users` `up` on(`p`.`UserID` = `up`.`UserID`)) join `doctors` `d` on(`a`.`DoctorID` = `d`.`DoctorID`)) join `users` `ud` on(`d`.`UserID` = `ud`.`UserID`)) ;

-- --------------------------------------------------------

--
-- Structure for view `vw_doctors`
--
DROP TABLE IF EXISTS `vw_doctors`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_doctors`  AS SELECT `d`.`DoctorID` AS `DoctorID`, `u`.`UserID` AS `UserID`, concat(`u`.`UserLastName`,', ',`u`.`UserFirstName`,' ',`u`.`UserMidName`) AS `DoctorFullName` FROM (`doctors` `d` join `users` `u` on(`d`.`UserID` = `u`.`UserID`)) ;

-- --------------------------------------------------------

--
-- Structure for view `vw_patients`
--
DROP TABLE IF EXISTS `vw_patients`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_patients`  AS SELECT `p`.`PatientID` AS `PatientID`, `u`.`UserID` AS `UserID`, concat(`u`.`UserLastName`,', ',`u`.`UserFirstName`,' ',`u`.`UserMidName`) AS `PatientFullName` FROM (`patients` `p` join `users` `u` on(`p`.`UserID` = `u`.`UserID`)) ;

-- --------------------------------------------------------

--
-- Structure for view `vw_predictions`
--
DROP TABLE IF EXISTS `vw_predictions`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_predictions`  AS SELECT `pr`.`PredictionID` AS `PredictionID`, `pr`.`ConsultID` AS `ConsultID`, concat(`ud`.`UserLastName`,', ',`ud`.`UserFirstName`,' ',`ud`.`UserMidName`) AS `DoctorFullName`, concat(`up`.`UserLastName`,', ',`up`.`UserFirstName`,' ',`up`.`UserMidName`) AS `PatientFullName`, `pr`.`PredictedIllness` AS `PredictedIllness`, `pr`.`ConfidenceLevel` AS `ConfidenceLevel`, `pr`.`CreatedAt` AS `CreatedAt` FROM ((((((`predictions` `pr` join `consultations` `c` on(`pr`.`ConsultID` = `c`.`ConsultID`)) join `appointments` `a` on(`c`.`AppointmentID` = `a`.`AppointmentID`)) join `doctors` `d` on(`a`.`DoctorID` = `d`.`DoctorID`)) join `users` `ud` on(`d`.`UserID` = `ud`.`UserID`)) join `patients` `p` on(`a`.`PatientID` = `p`.`PatientID`)) join `users` `up` on(`p`.`UserID` = `up`.`UserID`)) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `appointments`
--
ALTER TABLE `appointments`
  ADD PRIMARY KEY (`AppointmentID`),
  ADD KEY `PatientID` (`PatientID`),
  ADD KEY `DoctorID` (`DoctorID`);

--
-- Indexes for table `appointment_symptoms`
--
ALTER TABLE `appointment_symptoms`
  ADD PRIMARY KEY (`AppointmentSymptomID`),
  ADD KEY `AppointmentID` (`AppointmentID`),
  ADD KEY `SymptomID` (`SymptomID`);

--
-- Indexes for table `checkup_results`
--
ALTER TABLE `checkup_results`
  ADD PRIMARY KEY (`ResultID`),
  ADD KEY `AppointmentID` (`AppointmentID`);

--
-- Indexes for table `consultations`
--
ALTER TABLE `consultations`
  ADD PRIMARY KEY (`ConsultID`),
  ADD KEY `AppointmentID` (`AppointmentID`);

--
-- Indexes for table `doctors`
--
ALTER TABLE `doctors`
  ADD PRIMARY KEY (`DoctorID`),
  ADD UNIQUE KEY `UserID` (`UserID`);

--
-- Indexes for table `follow_up_checkups`
--
ALTER TABLE `follow_up_checkups`
  ADD PRIMARY KEY (`FollowUpID`),
  ADD KEY `ResultID` (`ResultID`);

--
-- Indexes for table `medicines`
--
ALTER TABLE `medicines`
  ADD PRIMARY KEY (`MedicineID`);

--
-- Indexes for table `patients`
--
ALTER TABLE `patients`
  ADD PRIMARY KEY (`PatientID`),
  ADD KEY `UserID` (`UserID`);

--
-- Indexes for table `predictions`
--
ALTER TABLE `predictions`
  ADD PRIMARY KEY (`PredictionID`),
  ADD KEY `fk_predictions_consultation` (`ConsultID`);

--
-- Indexes for table `prescriptions`
--
ALTER TABLE `prescriptions`
  ADD PRIMARY KEY (`PrescriptionID`),
  ADD KEY `ResultID` (`ResultID`),
  ADD KEY `MedicineID` (`MedicineID`);

--
-- Indexes for table `symptoms`
--
ALTER TABLE `symptoms`
  ADD PRIMARY KEY (`SymptomID`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`UserID`),
  ADD UNIQUE KEY `Email` (`Email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `appointments`
--
ALTER TABLE `appointments`
  MODIFY `AppointmentID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `appointment_symptoms`
--
ALTER TABLE `appointment_symptoms`
  MODIFY `AppointmentSymptomID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `checkup_results`
--
ALTER TABLE `checkup_results`
  MODIFY `ResultID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `consultations`
--
ALTER TABLE `consultations`
  MODIFY `ConsultID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `doctors`
--
ALTER TABLE `doctors`
  MODIFY `DoctorID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `follow_up_checkups`
--
ALTER TABLE `follow_up_checkups`
  MODIFY `FollowUpID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `medicines`
--
ALTER TABLE `medicines`
  MODIFY `MedicineID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `patients`
--
ALTER TABLE `patients`
  MODIFY `PatientID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `predictions`
--
ALTER TABLE `predictions`
  MODIFY `PredictionID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `prescriptions`
--
ALTER TABLE `prescriptions`
  MODIFY `PrescriptionID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `symptoms`
--
ALTER TABLE `symptoms`
  MODIFY `SymptomID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `UserID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `appointments`
--
ALTER TABLE `appointments`
  ADD CONSTRAINT `appointments_ibfk_1` FOREIGN KEY (`PatientID`) REFERENCES `patients` (`PatientID`),
  ADD CONSTRAINT `appointments_ibfk_2` FOREIGN KEY (`DoctorID`) REFERENCES `doctors` (`DoctorID`);

--
-- Constraints for table `appointment_symptoms`
--
ALTER TABLE `appointment_symptoms`
  ADD CONSTRAINT `appointment_symptoms_ibfk_1` FOREIGN KEY (`AppointmentID`) REFERENCES `appointments` (`AppointmentID`),
  ADD CONSTRAINT `appointment_symptoms_ibfk_2` FOREIGN KEY (`SymptomID`) REFERENCES `symptoms` (`SymptomID`);

--
-- Constraints for table `checkup_results`
--
ALTER TABLE `checkup_results`
  ADD CONSTRAINT `checkup_results_ibfk_1` FOREIGN KEY (`AppointmentID`) REFERENCES `appointments` (`AppointmentID`);

--
-- Constraints for table `consultations`
--
ALTER TABLE `consultations`
  ADD CONSTRAINT `consultations_ibfk_1` FOREIGN KEY (`AppointmentID`) REFERENCES `appointments` (`AppointmentID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `consultations_ibfk_2` FOREIGN KEY (`ConsultID`) REFERENCES `predictions` (`ConsultID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `doctors`
--
ALTER TABLE `doctors`
  ADD CONSTRAINT `doctors_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `follow_up_checkups`
--
ALTER TABLE `follow_up_checkups`
  ADD CONSTRAINT `follow_up_checkups_ibfk_1` FOREIGN KEY (`ResultID`) REFERENCES `checkup_results` (`ResultID`);

--
-- Constraints for table `patients`
--
ALTER TABLE `patients`
  ADD CONSTRAINT `patients_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `predictions`
--
ALTER TABLE `predictions`
  ADD CONSTRAINT `fk_predictions_consultation` FOREIGN KEY (`ConsultID`) REFERENCES `consultations` (`ConsultID`);

--
-- Constraints for table `prescriptions`
--
ALTER TABLE `prescriptions`
  ADD CONSTRAINT `prescriptions_ibfk_1` FOREIGN KEY (`ResultID`) REFERENCES `checkup_results` (`ResultID`),
  ADD CONSTRAINT `prescriptions_ibfk_2` FOREIGN KEY (`MedicineID`) REFERENCES `medicines` (`MedicineID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
