-- --------------------------------------------------------
-- 호스트:                          127.0.0.1
-- 서버 버전:                        10.11.6-MariaDB - mariadb.org binary distribution
-- 서버 OS:                        Win64
-- HeidiSQL 버전:                  12.5.0.6677
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- 테이블 duducalendar.approval 구조 내보내기
CREATE TABLE IF NOT EXISTS `approval` (
  `approval_auto` int(11) NOT NULL AUTO_INCREMENT,
  `approval_no` varchar(50) DEFAULT NULL,
  `user_email` varchar(50) DEFAULT NULL,
  `approval_first` varchar(50) DEFAULT NULL,
  `approval_middle` varchar(50) DEFAULT NULL,
  `approval_final` varchar(50) DEFAULT NULL,
  `approval_date` date DEFAULT NULL,
  `approval_content` varchar(1000) DEFAULT NULL,
  `approval_status` varchar(50) DEFAULT NULL,
  `approval_reason` varchar(200) DEFAULT NULL,
  `approval_file` varchar(300) DEFAULT NULL,
  `approval_ref` varchar(500) DEFAULT NULL,
  `approval_title` varchar(50) DEFAULT NULL,
  `approval_enddate` date DEFAULT NULL,
  `approval_filename` varchar(50) DEFAULT NULL,
  `findfirst` varchar(50) DEFAULT NULL,
  `findmiddle` varchar(50) DEFAULT NULL,
  `findfinal` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`approval_auto`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 duducalendar.approval:~9 rows (대략적) 내보내기
INSERT INTO `approval` (`approval_auto`, `approval_no`, `user_email`, `approval_first`, `approval_middle`, `approval_final`, `approval_date`, `approval_content`, `approval_status`, `approval_reason`, `approval_file`, `approval_ref`, `approval_title`, `approval_enddate`, `approval_filename`, `findfirst`, `findmiddle`, `findfinal`) VALUES
	(1, NULL, '조제민', '', '조제민', '4', '2024-04-01', '4~1123', '3', NULL, '', NULL, '안녕하세요 휴가 보내주세요', NULL, NULL, NULL, NULL, NULL),
	(2, NULL, '테스트', '', '3', '테스트', '2024-04-01', 'ㅁㅁㅁ', '완료', NULL, 'Welcome to Hwp.hwp', NULL, '결재', '2024-04-01', NULL, NULL, NULL, NULL),
	(3, NULL, '조제민', '', '조제민', '테스트', '2024-04-01', '등록 내용', '완료', NULL, '', NULL, '결재 등록', '2024-04-01', NULL, NULL, NULL, NULL),
	(4, NULL, '조제민,chojam301@duduit.co.kr', '완료', '완료', '0', '2024-04-08', '11', '3', NULL, '95383cfa.pdf', NULL, '11', NULL, '공문서+쉽고+바르게+쓰기_누리집.pdf', NULL, NULL, 'cho123@duduit.co.kr'),
	(5, NULL, '조제민,chojam301@duduit.co.kr', '완료', '완료', '테스터', '2024-04-08', '444444444444', '완료', NULL, '1b4ccfb8.pdf', NULL, 'hello', '2024-04-08', '공문서+쉽고+바르게+쓰기_누리집.pdf', NULL, NULL, 'user1@duduit.co.kr'),
	(6, NULL, '조제민,chojam301@duduit.co.kr', '완료', '완료', '3', '2024-04-08', '1', '3', NULL, '65918d9b.pdf', NULL, '공문서 작성법', NULL, '공문서+쉽고+바르게+쓰기_누리집.pdf', NULL, NULL, 'user1@duduit.co.kr'),
	(7, NULL, '테스터,user1@duduit.co.kr', '완료', '완료', '4', '2024-04-08', '1', '3', NULL, '28412ba0.pdf', NULL, '대표님 공문입니다', NULL, '공문서+쉽고+바르게+쓰기_누리집.pdf', NULL, NULL, 'test@duduit.co.kr'),
	(8, NULL, '김두두,user5@duduit.co.kr', '완료', '3', '4', '2024-04-08', '123', '반려', '반려', '5f179312.pdf', NULL, '결재 등록', '2024-04-08', 'Download_Sample.pdf', NULL, 'user1@duduit.co.kr', 'test@duduit.co.kr'),
	(9, NULL, '조제민,chojam301@duduit.co.kr', '완료', '완료', '4', '2024-04-08', 'ad', '3', NULL, 'b0399697.hwp', NULL, 'adf', NULL, 'Welcome to Hwp.hwp', NULL, NULL, 'test@duduit.co.kr');

-- 테이블 duducalendar.daily_schedule 구조 내보내기
CREATE TABLE IF NOT EXISTS `daily_schedule` (
  `daily_no` int(11) NOT NULL AUTO_INCREMENT,
  `user_email` varchar(50) NOT NULL,
  `project_no` varchar(50) NOT NULL,
  `daily_title` varchar(100) NOT NULL,
  `daily_content` varchar(2000) NOT NULL,
  `daily_date` datetime NOT NULL,
  `daily_color` varchar(20) NOT NULL,
  `daily_isFinish` tinyint(1) NOT NULL,
  `daily_importance` int(11) NOT NULL,
  PRIMARY KEY (`daily_no`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 duducalendar.daily_schedule:~11 rows (대략적) 내보내기
INSERT INTO `daily_schedule` (`daily_no`, `user_email`, `project_no`, `daily_title`, `daily_content`, `daily_date`, `daily_color`, `daily_isFinish`, `daily_importance`) VALUES
	(1, 'ddd@naver.com', '1', 'gfhfgh', 'fghgf', '2024-03-25 16:40:07', '#000000', 0, 1),
	(2, 'litk@duduit.co.kr', '1', 'dsafas', '121', '2024-03-27 11:00:01', '#000000', 0, 10),
	(3, 'litk@duduit.co.kr', '1', 'dsafas', 'gfdgfd', '2024-03-27 11:03:38', '#000000', 1, 10),
	(5, '', '1', '4/1 오늘의 일정', '두두캘린더 개발 마무리짓기', '2024-04-01 13:05:17', '#ad0b0b', 0, 5),
	(7, 'test@duduit.co.kr', '1', '두두캘린더 발표', '4시 발표', '2024-04-01 16:45:09', '#a7d93a', 0, 5),
	(8, 'user2@duduit.co.kr', '1', '오늘 점심 뭐먹지', '123', '2024-04-02 16:53:39', '#4d6aff', 0, 1),
	(9, 'user4@duduit.co.kr', '1', '4월 8일', '11', '2024-04-08 13:15:01', '#000000', 0, 1),
	(11, 'admin@duduit.co.kr', '1', '12313', '13131', '2024-04-03 15:48:32', '#000000', 0, 1),
	(12, 'admin@duduit.co.kr', '1', '12313', '13131', '2024-04-05 09:14:20', '#000000', 0, 1),
	(13, 'chojam301@duduit.co.kr', '1', 'ㅁㄹ', 'ㅁㄹ', '2024-04-09 17:53:40', '#000000', 0, 1);

-- 테이블 duducalendar.holiday 구조 내보내기
CREATE TABLE IF NOT EXISTS `holiday` (
  `holiday_index` bigint(20) NOT NULL AUTO_INCREMENT,
  `holiday_start` date NOT NULL,
  `holiday_end` date NOT NULL,
  `holiday_name` varchar(100) NOT NULL,
  PRIMARY KEY (`holiday_index`)
) ENGINE=InnoDB AUTO_INCREMENT=211 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 duducalendar.holiday:~54 rows (대략적) 내보내기
INSERT INTO `holiday` (`holiday_index`, `holiday_start`, `holiday_end`, `holiday_name`) VALUES
	(69, '2024-01-01', '2024-01-01', '1월1일'),
	(70, '2024-02-09', '2024-02-09', '설날'),
	(71, '2024-02-10', '2024-02-10', '설날'),
	(72, '2024-02-11', '2024-02-11', '설날'),
	(73, '2024-02-12', '2024-02-12', '대체공휴일(설날)'),
	(74, '2024-03-01', '2024-03-01', '삼일절'),
	(75, '2024-04-10', '2024-04-10', '국회의원선거'),
	(76, '2024-05-05', '2024-05-05', '어린이날'),
	(77, '2024-05-06', '2024-05-06', '대체공휴일(어린이날)'),
	(78, '2024-05-15', '2024-05-15', '부처님오신날'),
	(79, '2024-06-06', '2024-06-06', '현충일'),
	(80, '2024-08-15', '2024-08-15', '광복절'),
	(81, '2024-09-16', '2024-09-16', '추석'),
	(82, '2024-09-17', '2024-09-17', '추석'),
	(83, '2024-09-18', '2024-09-18', '추석'),
	(84, '2024-10-03', '2024-10-03', '개천절'),
	(85, '2024-10-09', '2024-10-09', '한글날'),
	(86, '2024-12-25', '2024-12-25', '기독탄신일'),
	(87, '2025-03-01', '2025-03-01', '삼일절'),
	(88, '2025-03-03', '2025-03-03', '대체공휴일'),
	(89, '2025-05-05', '2025-05-05', '어린이날'),
	(90, '2025-05-05', '2025-05-05', '부처님오신날'),
	(91, '2025-05-06', '2025-05-06', '대체공휴일'),
	(92, '2025-06-06', '2025-06-06', '현충일'),
	(93, '2025-08-15', '2025-08-15', '광복절'),
	(94, '2025-10-03', '2025-10-03', '개천절'),
	(95, '2025-10-05', '2025-10-05', '추석'),
	(96, '2025-10-06', '2025-10-06', '추석'),
	(97, '2025-10-07', '2025-10-07', '추석'),
	(98, '2025-10-08', '2025-10-08', '대체공휴일'),
	(99, '2025-10-09', '2025-10-09', '한글날'),
	(100, '2025-12-25', '2025-12-25', '기독탄신일'),
	(101, '2025-01-01', '2025-01-01', '1월1일'),
	(102, '2025-01-28', '2025-01-28', '설날'),
	(103, '2025-01-29', '2025-01-29', '설날'),
	(104, '2025-01-30', '2025-01-30', '설날'),
	(193, '2023-01-01', '2023-01-01', '1월1일'),
	(194, '2023-01-21', '2023-01-21', '설날'),
	(195, '2023-01-22', '2023-01-22', '설날'),
	(196, '2023-01-23', '2023-01-23', '설날'),
	(197, '2023-01-24', '2023-01-24', '대체공휴일'),
	(198, '2023-03-01', '2023-03-01', '삼일절'),
	(199, '2023-05-05', '2023-05-05', '어린이날'),
	(200, '2023-05-27', '2023-05-27', '부처님오신날'),
	(201, '2023-05-29', '2023-05-29', '대체공휴일'),
	(202, '2023-06-06', '2023-06-06', '현충일'),
	(203, '2023-08-15', '2023-08-15', '광복절'),
	(204, '2023-09-28', '2023-09-28', '추석'),
	(205, '2023-09-29', '2023-09-29', '추석'),
	(206, '2023-09-30', '2023-09-30', '추석'),
	(207, '2023-10-02', '2023-10-02', '임시공휴일'),
	(208, '2023-10-03', '2023-10-03', '개천절'),
	(209, '2023-10-09', '2023-10-09', '한글날'),
	(210, '2023-12-25', '2023-12-25', '기독탄신일');

-- 테이블 duducalendar.project_logs 구조 내보내기
CREATE TABLE IF NOT EXISTS `project_logs` (
  `LOG_NO` varchar(20) NOT NULL,
  `LOG_P_NO` int(11) NOT NULL AUTO_INCREMENT,
  `USER_EMAIL` varchar(50) NOT NULL,
  `LOG_OLDTITLE` varchar(100) DEFAULT NULL,
  `LOG_NEWTITLE` varchar(100) DEFAULT NULL,
  `LOG_OLDTEXT` varchar(2000) DEFAULT NULL,
  `LOG_NEWTEXT` varchar(2000) DEFAULT NULL,
  `LOG_OLDMEMBER` varchar(100) DEFAULT NULL,
  `LOG_NEWMEMBER` varchar(100) DEFAULT NULL,
  `LOG_OLDSTART` date DEFAULT NULL,
  `LOG_NEWSTART` date DEFAULT NULL,
  `LOG_OLDEND` date DEFAULT NULL,
  `LOG_NEWEND` date DEFAULT NULL,
  `LOG_DATE` datetime DEFAULT NULL,
  `LOG_OLDCOLOR` varchar(20) DEFAULT NULL,
  `LOG_NEWCOLOR` varchar(20) DEFAULT NULL,
  KEY `project_editor` (`USER_EMAIL`),
  KEY `project_number` (`LOG_P_NO`),
  CONSTRAINT `project_editor` FOREIGN KEY (`USER_EMAIL`) REFERENCES `user` (`user_email`),
  CONSTRAINT `project_number` FOREIGN KEY (`LOG_P_NO`) REFERENCES `project_schedule` (`PROJECT_NO`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 duducalendar.project_logs:~15 rows (대략적) 내보내기
INSERT INTO `project_logs` (`LOG_NO`, `LOG_P_NO`, `USER_EMAIL`, `LOG_OLDTITLE`, `LOG_NEWTITLE`, `LOG_OLDTEXT`, `LOG_NEWTEXT`, `LOG_OLDMEMBER`, `LOG_NEWMEMBER`, `LOG_OLDSTART`, `LOG_NEWSTART`, `LOG_OLDEND`, `LOG_NEWEND`, `LOG_DATE`, `LOG_OLDCOLOR`, `LOG_NEWCOLOR`) VALUES
	('p3-1', 3, 'chojam301@duduit.co.kr', NULL, 'pjno테스트', NULL, 'ㅇㅁㄹ', NULL, '조제민LMS', NULL, '2024-04-01', NULL, '2024-04-01', '2024-04-01 00:00:00', NULL, '#123456'),
	('p4-1', 4, 'chojam301@duduit.co.kr', NULL, 'auto_increment', NULL, 'dsfsadfafsd', NULL, '조제민LMS', NULL, '2024-04-02', NULL, '2024-04-03', '2024-04-01 00:00:00', NULL, '#dfc1d2'),
	('p6-1', 6, 'chojam301@duduit.co.kr', NULL, '마지막 테스트', NULL, 'ㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁ', NULL, '조제민LMS,테스트사업관리', NULL, '2024-04-05', NULL, '2024-04-25', '2024-04-01 00:00:00', NULL, '#6d983a'),
	('p9-1', 9, 'chojam301@duduit.co.kr', NULL, '프로젝트 등록1', NULL, '안녕하세요', NULL, '조제민LMS,테스트사업관리', NULL, '2024-04-04', NULL, '2024-04-18', '2024-04-01 00:00:00', NULL, '#7b3232'),
	('p6-2', 6, 'chojam301@duduit.co.kr', '마지막 테스트', '1차 수정', 'ㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁ', '12345', '조제민LMS,테스트사업관리', '조제민LMS', '2024-04-05', '2024-04-04', '2024-04-25', '2024-04-21', '2024-04-05 09:40:33', '#6d983a', '#e1b823'),
	('p10-1', 10, 'admin@duduit.co.kr', NULL, '8888', NULL, 'qqqqqq', NULL, '테스트사업관리,조제민LMS', NULL, '2024-04-08', NULL, '2024-04-09', '2024-04-05 14:40:50', NULL, '#000000'),
	('p11-1', 11, 'admin@duduit.co.kr', NULL, '4월 9일', NULL, '23', NULL, '박아무개기획', NULL, '2024-04-09', NULL, '2024-04-09', '2024-04-05 14:41:19', NULL, '#000000'),
	('p12-1', 12, 'chojam301@duduit.co.kr', NULL, '4월 8일 프로젝트 등록', NULL, '안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요', NULL, '박아무개기획,조제민LMS', NULL, '2024-04-08', NULL, '2024-04-12', '2024-04-08 13:10:06', NULL, '#2dc8a9'),
	('p13-1', 13, 'chojam301@duduit.co.kr', NULL, '1', NULL, '11', NULL, '조제민LMS', NULL, '2024-04-08', NULL, '2024-04-09', '2024-04-08 13:10:44', NULL, '#000000'),
	('p14-1', 14, 'chojam301@duduit.co.kr', NULL, '2', NULL, '2', NULL, '조제민LMS', NULL, '2024-04-08', NULL, '2024-04-10', '2024-04-08 13:11:02', NULL, '#000000'),
	('p15-1', 15, 'chojam301@duduit.co.kr', NULL, '3', NULL, '3', NULL, '조제민LMS', NULL, '2024-04-08', NULL, '2024-04-11', '2024-04-08 13:11:20', NULL, '#000000'),
	('p16-1', 16, 'chojam301@duduit.co.kr', NULL, '4', NULL, '4', NULL, '조제민LMS', NULL, '2024-04-08', NULL, '2024-04-18', '2024-04-08 13:11:41', NULL, '#000000'),
	('p17-1', 17, 'chojam301@duduit.co.kr', NULL, '5', NULL, '5', NULL, '조제민LMS', NULL, '2024-04-08', NULL, '2024-04-11', '2024-04-08 13:12:02', NULL, '#000000'),
	('p3-2', 3, 'chojam301@duduit.co.kr', 'pjno테스트', 'pjno테스트2', 'ㅇㅁㄹ', 'ㅇㅁㄹ22', '조제민LMS', '조제민LMS', '2024-04-01', '2024-04-01', '2024-04-01', '2024-04-01', '2024-04-09 16:11:16', '#123456', '#985325'),
	('p3-3', 3, 'chojam301@duduit.co.kr', 'pjno테스트2', 'pjno테스트2', 'ㅇㅁㄹ22', 'ㅇㅁㄹ22', '조제민LMS', '조제민LMS', '2024-04-01', '2024-04-01', '2024-04-01', '2024-04-01', '2024-04-09 16:38:34', '#985325', '#985325'),
	('p18-1', 18, 'chojam301@duduit.co.kr', NULL, 'ㅌㅊㅋㅊㅋ', NULL, 'ㄴㅁㅇㄴㅁㅇ', NULL, '조제민(LMS)', NULL, '2024-04-12', NULL, '2024-05-02', '2024-04-09 17:51:58', NULL, '#000000');

-- 테이블 duducalendar.project_schedule 구조 내보내기
CREATE TABLE IF NOT EXISTS `project_schedule` (
  `PROJECT_NO` int(11) NOT NULL AUTO_INCREMENT,
  `USER_EMAIL` varchar(50) NOT NULL,
  `USER_NAME` varchar(50) NOT NULL,
  `PROJECT_TITLE` varchar(100) NOT NULL,
  `PROJECT_CONTENT` varchar(2000) NOT NULL,
  `PROJECT_MEMBER` varchar(100) NOT NULL,
  `PROJECT_START` date NOT NULL,
  `PROJECT_END` date NOT NULL,
  `PROJECT_DEPARTMENT` varchar(100) NOT NULL,
  `PROJECT_COLOR` varchar(20) NOT NULL,
  `project_ischange` int(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`PROJECT_NO`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 duducalendar.project_schedule:~13 rows (대략적) 내보내기
INSERT INTO `project_schedule` (`PROJECT_NO`, `USER_EMAIL`, `USER_NAME`, `PROJECT_TITLE`, `PROJECT_CONTENT`, `PROJECT_MEMBER`, `PROJECT_START`, `PROJECT_END`, `PROJECT_DEPARTMENT`, `PROJECT_COLOR`, `project_ischange`) VALUES
	(3, 'chojam301@duduit.co.kr', '', 'pjno테스트2', 'ㅇㅁㄹ22', '조제민LMS', '2024-04-01', '2024-04-01', 'LMS', '#985325', 1),
	(4, 'chojam301@duduit.co.kr', '', 'auto_increment', 'dsfsadfafsd', '조제민LMS', '2024-04-02', '2024-04-03', 'LMS', '#dfc1d2', 0),
	(6, 'chojam301@duduit.co.kr', '', '1차 수정', '12345', '조제민LMS', '2024-04-04', '2024-04-21', 'LMS', '#e1b823', 1),
	(9, 'chojam301@duduit.co.kr', '', '프로젝트 등록1', '안녕하세요', '조제민LMS,테스트사업관리', '2024-04-04', '2024-04-18', 'LMS', '#7b3232', 0),
	(10, 'admin@duduit.co.kr', '', '8888', 'qqqqqq', '테스트사업관리,조제민LMS', '2024-04-08', '2024-04-09', '관리자', '#000000', 0),
	(11, 'admin@duduit.co.kr', '', '4월 9일', '23', '박아무개기획', '2024-04-09', '2024-04-09', '관리자', '#000000', 0),
	(12, 'chojam301@duduit.co.kr', '', '4월 8일 프로젝트 등록', '안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요', '박아무개기획,조제민LMS', '2024-04-08', '2024-04-12', 'LMS', '#2dc8a9', 0),
	(13, 'chojam301@duduit.co.kr', '', '1', '11', '조제민LMS', '2024-04-08', '2024-04-09', 'LMS', '#000000', 0),
	(14, 'chojam301@duduit.co.kr', '', '2', '2', '조제민LMS', '2024-04-08', '2024-04-10', 'LMS', '#000000', 0),
	(15, 'chojam301@duduit.co.kr', '', '3', '3', '조제민LMS', '2024-04-08', '2024-04-11', 'LMS', '#000000', 0),
	(16, 'chojam301@duduit.co.kr', '', '4', '4', '조제민LMS', '2024-04-08', '2024-04-18', 'LMS', '#000000', 0),
	(17, 'chojam301@duduit.co.kr', '', '5', '5', '조제민LMS', '2024-04-08', '2024-04-11', 'LMS', '#000000', 0),
	(18, 'chojam301@duduit.co.kr', '조제민', 'ㅌㅊㅋㅊㅋ', 'ㄴㅁㅇㄴㅁㅇ', '조제민(LMS)', '2024-04-12', '2024-05-02', 'LMS', '#000000', 0);

-- 테이블 duducalendar.user 구조 내보내기
CREATE TABLE IF NOT EXISTS `user` (
  `user_email` varchar(50) NOT NULL,
  `user_pw` varchar(100) NOT NULL,
  `user_name` varchar(100) NOT NULL,
  `user_department` varchar(100) NOT NULL,
  `user_rank` varchar(100) NOT NULL,
  `user_role` varchar(10) NOT NULL,
  `user_status` varchar(50) NOT NULL,
  PRIMARY KEY (`user_email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 duducalendar.user:~13 rows (대략적) 내보내기
INSERT INTO `user` (`user_email`, `user_pw`, `user_name`, `user_department`, `user_rank`, `user_role`, `user_status`) VALUES
	('admin@duduit.co.kr', 'GBODcvrUuUUzzUiB8D3GxpKW3YlyNODO6D9yfi5rH2M=', '관리자', '관리자', '관리자', '5', '승인'),
	('cho123@duduit.co.kr', 'GBODcvrUuUUzzUiB8D3GxpKW3YlyNODO6D9yfi5rH2M=', '조제민', 'LMS', '선임연구원', '1', '승인'),
	('chojam301@duduit.co.kr', 'GBODcvrUuUUzzUiB8D3GxpKW3YlyNODO6D9yfi5rH2M=', '조제민', 'LMS', '팀장', '3', '승인'),
	('pyj1997@duduit.co.kr', '0xCip/d/uKOaWwncQFqsDI6/tdyRCqT8pMlTGCwe+5s=', '박유진', 'LMS', '팀장', '3', '승인'),
	('qwe1234@duduit.co.kr', 'GBODcvrUuUUzzUiB8D3GxpKW3YlyNODO6D9yfi5rH2M=', '박아무개', '기획', '책임연구원', '2', '승인'),
	('qwe123@duduit.co.kr', 'GBODcvrUuUUzzUiB8D3GxpKW3YlyNODO6D9yfi5rH2M=', '큐덥이', '영업', '팀장', '3', '승인'),
	('teamjang@duduit.co.kr', '0uJNVNvygera/S2qjEwKOKRs/TE5Ca+ArGofbSFqBkI=', '박팀장', '컨텐츠', '팀장', '3', '미승인'),
	('test@duduit.co.kr', 'GBODcvrUuUUzzUiB8D3GxpKW3YlyNODO6D9yfi5rH2M=', '김대표', '사업관리', '대표', '4', '승인'),
	('user1@duduit.co.kr', 'GBODcvrUuUUzzUiB8D3GxpKW3YlyNODO6D9yfi5rH2M=', '테스터', 'LMS', '팀장', '3', '승인'),
	('user2@duduit.co.kr', 'GBODcvrUuUUzzUiB8D3GxpKW3YlyNODO6D9yfi5rH2M=', '조제민', 'LMS', '연구원', '0', '승인'),
	('user3@duduit.co.kr', 'GBODcvrUuUUzzUiB8D3GxpKW3YlyNODO6D9yfi5rH2M=', '김아무개', '사업관리', '연구원', '0', '미승인'),
	('user4@duduit.co.kr', '0xCip/d/uKOaWwncQFqsDI6/tdyRCqT8pMlTGCwe+5s=', '사용자', '영업', '연구원', '0', '승인'),
	('user5@duduit.co.kr', '0xCip/d/uKOaWwncQFqsDI6/tdyRCqT8pMlTGCwe+5s=', '김두두', '기획', '선임연구원', '1', '승인');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
