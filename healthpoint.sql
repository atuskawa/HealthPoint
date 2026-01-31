-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 31, 2026 at 06:59 AM
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
-- Database: `healthpoint`
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
  `created_at` datetime DEFAULT NULL,
  `conversation` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `doctors`
--

CREATE TABLE `doctors` (
  `DoctorID` int(11) NOT NULL,
  `DoctorFirstName` varchar(50) DEFAULT NULL,
  `DoctorMidName` varchar(50) DEFAULT NULL,
  `DoctorLastName` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
  `PatientFirstName` varchar(50) DEFAULT NULL,
  `PatientMidName` varchar(50) DEFAULT NULL,
  `PatientLastName` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
  `username` varchar(50) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `UserEmail` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`UserID`, `UserFirstName`, `UserMidName`, `UserLastName`, `username`, `password`, `created_at`, `UserEmail`) VALUES
(4, 'Timothy', '', 'Elequin', 'timothyelequin', '$2y$10$GTdP/dvCNL85LZmx5AW0rOtuc3xPMZr15mMPZWj8zuddRdjgHLzYG', '2026-01-31 04:32:53', 'elequintimothyjudd@gmail.com');

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
  ADD PRIMARY KEY (`ConsultID`);

--
-- Indexes for table `doctors`
--
ALTER TABLE `doctors`
  ADD PRIMARY KEY (`DoctorID`);

--
-- Indexes for table `patients`
--
ALTER TABLE `patients`
  ADD PRIMARY KEY (`PatientID`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`UserID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `consultations`
--
ALTER TABLE `consultations`
  MODIFY `ConsultID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `doctors`
--
ALTER TABLE `doctors`
  MODIFY `DoctorID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `patients`
--
ALTER TABLE `patients`
  MODIFY `PatientID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `UserID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
